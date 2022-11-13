//-------------------------------------------------------------------
//                                                                 
//-------------------------------------------------------------------------
//© 2022 Microchip Technology Inc. and its subsidiaries
//All rights reserved.
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//-------------------------------------------------------------------------
//
//-------------------------------------------------------------------
// Title        : FabUART.v
// Created      : June-2017
// Description  : This module implements the logic in the fabric for  
// 		  communication between the CoreUART and user fabric logic
// Revision     : NA
// Hierarchy    :
//                Top_SD

//                  -- UART_INTERFACE
//                   -- FabUART.v             <-- This module
//
// Target device: <Family:PolarFire> <Die:MPF300TS_ES> <Pkg:FCG1152>
//-------------------------------------------------------------------

//******************************************************************************
//**************************** Module Declaration ******************************
//******************************************************************************
module FabUART( 
             
 input clk, 
 input reset,
 input uart_txrdy,
 input uart_rxrdy,
 input rx_val,
 input rx_lock,
 input rx_error,
 input [7:0]uart_data_in,
 input [31:0]error_count,

 output uart_wen,
 output uart_oen,
 output start,
 output switch,
 output clear,
 output genrate_err,
 output connect_o,
 output timer_switch,
 output [7:0]uart_data_out
 );

//******************************************************************************
//**************************** Signal Declaration ******************************
//******************************************************************************

 reg uart_wen_t;
 reg uart_oen_t;
 reg start_t;
 reg switch_t;
 reg clear_t;
 reg [7:0]uart_data_out_t;
 reg genrate_err_t;
 reg data_flag;
 reg connect_t;
 reg scan_t;
 reg timer_switch_t;
 
 parameter [4:0] INIT =5'b00000;
 parameter [4:0] UART_TX_CMD=5'b00001;
 parameter [4:0] UART_WAIT0=5'b00010;
 parameter [4:0] UART_TX1=5'b00011;
 parameter [4:0] UART_WAIT1=5'b00100;
 parameter [4:0] UART_TX2=5'b00101;
 
 parameter [4:0] UART_TX_CNT =5'b 00110;
 parameter [4:0] UART_WAIT2=5'b00111;
 parameter [4:0] UART_TX_CNT1=5'b01000;
 parameter [4:0] UART_WAIT3=5'b01001;
 parameter [4:0] UART_TX_CNT2=5'b01010;
 parameter [4:0] UART_WAIT4=5'b01011; 
 
 parameter [4:0] UART_TX_SCAN =5'b01100;
 parameter [4:0] UART_WAIT5=5'b01101;
 parameter [4:0] UART_TX_SCAN1=5'b01110;
 parameter [4:0] UART_WAIT6=5'b01111;
 parameter [4:0] UART_TX_SCAN2=5'b10000;
 parameter [4:0] UART_WAIT7=5'b10001; 
 
 parameter [4:0] UART_WAIT1_EXT1=5'b10010;
 parameter [4:0] UART_TX3=5'b10011;
 parameter [4:0] UART_WAIT1_EXT2=5'b10100;
 parameter [4:0] UART_TX4=5'b10101;
 parameter [4:0] UART_WAIT1_EXT3=5'b10110;
 parameter [4:0] UART_TX5=5'b10111;

 reg [4:0] state /* synthesis syn_noprune=1 */;

//******************************************************************************
//**************************** Fabric Uart Logic  ******************************
//******************************************************************************
always @(posedge clk,negedge reset)begin
  if(reset==1'b0)
    begin
     uart_wen_t <= 1'b1;
     uart_oen_t <= 1'b1;
     uart_data_out_t <= 8'h00;
     state <= INIT;
     start_t <=1'b0;
     switch_t <=1'b0;
     clear_t<=1'b0;
     connect_t <=1'b0;
     scan_t<=1'b0;
     genrate_err_t <=1'b0;
     timer_switch_t<=1'b1;
     data_flag <=1'b0;
    end
  else
    begin
      case (state)
       INIT: 
          begin
	        uart_wen_t <= 1'b1;
           if (uart_rxrdy ==1'b1) 
           begin
	   case (uart_data_in)
             8'h01:  begin
                     start_t <=1'b1;
                     clear_t <=1'b1;
        	     uart_oen_t <= 1'b0;               
                     end   
             8'h02:  begin
                     switch_t <=1'b0;
        	     uart_oen_t <= 1'b0;               
                     end 
             8'h03:  begin
                     switch_t <=1'b1;
        	     uart_oen_t <= 1'b0;               
                     end
             8'h04:  begin
                     scan_t <=1'b1;
        	     uart_oen_t <= 1'b0;                                       
	             state <= UART_TX_SCAN;
                     end 
             8'h05:  begin
                     start_t <=1'b0;
        	     uart_oen_t <= 1'b0;  
                     end
             8'h06:  begin
                     data_flag <=1'b1;
                     clear_t <=1'b0;           
        	     uart_oen_t <= 1'b0;  
	             state <= UART_TX_CMD;
                     end                                                           
             8'h07:  begin
                     genrate_err_t <=1'b1;
                     clear_t <=1'b0;
        	     uart_oen_t <= 1'b0;  
                     end
             8'h08:  begin
                     clear_t <=1'b1;
                     genrate_err_t <=1'b0;
        	     uart_oen_t <= 1'b0;  
                     end 
             8'h09:  begin
                     connect_t <=1'b1;
        	     uart_oen_t <= 1'b0; 
                     timer_switch_t <=1'b0; 
	             state <= UART_TX_CNT;
                     end  
             default: begin   
                     clear_t <=1'b0; 
                     genrate_err_t <=1'b0;  
                                      end                             
              endcase                       
            end
           else 
	       begin
		   state <= INIT;
		   uart_oen_t <= 1'b1;
	       end 
          end
      UART_TX_CMD :
               begin
	        uart_oen_t <= 1'b1;              
	        if (uart_txrdy == 1'b1) begin
		 if(data_flag==1'b1) begin
                   uart_data_out_t <= 8'h06; 	     // send UartMsgTx[0]
		   uart_wen_t <= 1'b0;
                 end
                 else;
                end		  
                else
                begin
		uart_wen_t <= 1'b1;
                state <= UART_WAIT0;
	        end 
               end
      UART_WAIT0:
               begin
                if (uart_txrdy == 1'b0) 
                 uart_wen_t <= 1'b1;
                else
                 state <= UART_TX1;
               end
      UART_TX1:
               begin
                if (uart_txrdy == 1'b1) begin
		 if(data_flag==1'b1) begin
	 uart_data_out_t <= {5'b0,rx_val,rx_error,rx_lock}; // send UartMsgTx[1]
		  uart_wen_t <= 1'b0;
                 end
                 else;
                end		  
                else
                begin
		  uart_wen_t <= 1'b1;
		  state <= UART_WAIT1;
	        end 
           end
      UART_WAIT1:
               begin
                if (uart_txrdy == 1'b0) 
                 uart_wen_t <= 1'b1;
                else
                 state <= UART_TX2;
               end
      UART_TX2:
              begin
               if (uart_txrdy == 1'b1) begin
		if(data_flag==1'b1) begin
	        uart_data_out_t <= {error_count[7:0]}; // send UartMsgTx[2]
	        uart_wen_t <= 1'b0;
                end
                else;
               end		  
               else
               begin
		uart_wen_t <= 1'b1;
		state <= UART_WAIT1_EXT1;
	       end 
              end
      UART_WAIT1_EXT1:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX3;
               end
      UART_TX3:
             begin
              if (uart_txrdy == 1'b1) begin
               if(data_flag==1'b1) begin
	  uart_data_out_t <= {error_count[15:8]}; // send UartMsgTx[3]
	      uart_wen_t <= 1'b0;
               end
               else;
              end		  
              else
              begin
		 uart_wen_t <= 1'b1;
		 state <= UART_WAIT1_EXT2;
	      end 
             end
      UART_WAIT1_EXT2:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX4;
               end
      UART_TX4:
                begin
                 if (uart_txrdy == 1'b1) begin
		  if(data_flag==1'b1) begin
	  uart_data_out_t <= {error_count[23:16]}; // send UartMsgTx[4]
		    uart_wen_t <= 1'b0;
                  end
                  else;
                 end		  
                 else
                 begin
		 uart_wen_t <= 1'b1;
		 state <= UART_WAIT1_EXT3;
	         end 
                end
      UART_WAIT1_EXT3:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX5;
               end
      UART_TX5:
              begin
               if (uart_txrdy == 1'b1) begin
		if(data_flag==1'b1) begin
        uart_data_out_t <= {error_count[31:24]};  // send UartMsgTx[5]
		  uart_wen_t <= 1'b0;
                end
                else;
               end		  
               else
               begin
		 uart_wen_t <= 1'b1;
		 state <= INIT;
	       end 
              end

//******************************************************************************
//********************* Start of Connect Command  ******************************
//******************************************************************************
      UART_TX_CNT :
               begin
	        uart_oen_t <= 1'b1;              
            if (uart_txrdy == 1'b1) begin
		 if(connect_t==1'b1) begin
        uart_data_out_t <= 8'h09;            // send UartMsgTx[0]
		   uart_wen_t <= 1'b0;
                 end
                 else;
                 end		  
                else
                begin
		 uart_wen_t <= 1'b1;
                 state <= UART_WAIT2;
	        end 
               end
      UART_WAIT2:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX_CNT1;
               end
      UART_TX_CNT1:
                  begin
                   if (uart_txrdy == 1'b1) begin
		    if(connect_t==1'b1) begin
	 uart_data_out_t <= 8'h00;	    // send UartMsgTx[1]
		     uart_wen_t <= 1'b0;
                    end
                    else;
                   end		  
                   else
                   begin
		    uart_wen_t <= 1'b1;
		    state <= UART_WAIT3;
	           end 
                  end
      UART_WAIT3:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX_CNT2;
               end
      UART_TX_CNT2:
                begin
                 if (uart_txrdy == 1'b1) begin
		  if(connect_t==1'b1) begin
	            uart_data_out_t <= 8'h0F;	 // send UartMsgTx[2]
		    uart_wen_t <= 1'b0; 
                  end
                  else;
                 end		  
                 else
                 begin
		  uart_wen_t <= 1'b1;
		  state <= UART_WAIT4;
	         end 
                end
      UART_WAIT4:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= INIT;
               end
//******************************************************************************
//********************* End of Connect Command  ********************************
//******************************************************************************

//******************************************************************************
//********************* Start of Scan Command  *********************************
//******************************************************************************

      UART_TX_SCAN :
                begin
	         uart_oen_t <= 1'b1;              
             if (uart_txrdy == 1'b1) begin
		  if(scan_t==1'b1) begin
                   uart_data_out_t <= 8'h04; 	      // send UartMsgTx[0]
		   uart_wen_t <= 1'b0;
                  end
                  else;
                 end		  
                 else
                 begin
		 uart_wen_t <= 1'b1;
                 state <= UART_WAIT5;
		         end 
               end
      UART_WAIT5:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX_SCAN1;
               end
      UART_TX_SCAN1:
               begin
                if (uart_txrdy == 1'b1) begin
		 if(scan_t==1'b1) begin
	           uart_data_out_t <= 8'h00;	// send UartMsgTx[1]
		   uart_wen_t <= 1'b0;
                 end
                 else;
                end		  
                else
                begin
		 uart_wen_t <= 1'b1;
		 state <= UART_WAIT6;
	        end 
              end
      UART_WAIT6:
              begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= UART_TX_SCAN2;
              end
     UART_TX_SCAN2:
              begin
               if (uart_txrdy == 1'b1) begin
		if(scan_t==1'b1) begin
	           uart_data_out_t <= 8'h0E;	 //send UartMsgTx[2]
		   uart_wen_t <= 1'b0;
                end
                else;
               end		  
               else
               begin
		 uart_wen_t <= 1'b1;
		 state <= UART_WAIT7;
	       end 
             end
      UART_WAIT7:
               begin
                if (uart_txrdy == 1'b0) 
                    uart_wen_t <= 1'b1;
                else
                   state <= INIT;
               end
//******************************************************************************
//********************* End of Scan Command  ***********************************
//******************************************************************************  
    
      default :	state <= INIT;
  endcase
 end
end

//******************************************************************************
//*************************** Concurrent Assignment ****************************
//******************************************************************************
  assign uart_data_out=uart_data_out_t;
  assign start=start_t;
  assign switch=switch_t;
  assign uart_wen=uart_wen_t;
  assign uart_oen=uart_oen_t;
  assign clear= clear_t;
  assign genrate_err= genrate_err_t;
  assign connect_o=connect_t;
  assign timer_switch=timer_switch_t;
endmodule
//******************************************************************************
//******************************* End of Module ********************************
//******************************************************************************
