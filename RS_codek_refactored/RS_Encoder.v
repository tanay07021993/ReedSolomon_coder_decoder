							//------------------------------------------------------------
							//************************************************************
							//----------------Reed_Solomon 11, 15 encoder-----------------
							//----------------Created by Alexey Burov(c)------------------
							//************************************************************


							//-----------------------------------------------------------------------
							//					This is top level-module. This module contains
							//description of auto-regressive filter that perform procedure RS-coding 			
							//with incoming message
							
							
							//This encoder operate with generate polynomial:
							//g(x) = x^4 + x^3(alpha^12) + x^2(alpha^4) + x(1) + alpha^6 =
							// = g(x) = x^4 + 15*x^3 + 3*x^2 + x + 12
							
							//Encoder presents information as a sequense of 4-bits groups and run it to the output pins in view:
							
							//		XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.XXXX.		XXXX.XXXX.XXXX.XXXX
							//------	USABLE ENCODED INFORMATION	---------------------	   //SERVISE SPECIAL TAIL
							//------any symbol X can be zero or one
module RS_Encoder(start_impulse, clk, Data_in, 
                 Data_out, end_of_work 
                 //uncomment this string and how information overwrites in the inside registers will be shown (+ 2 same commented segments down the code)
                 //									DON`T FORGET REBUILD THE MODULE!!!
                 //,ctrl, regB0_0, regB0_1, regB0_2, regB0_3, regB1_0, regB1_1, regB1_2, regB1_3, regB2_0, regB2_1, regB2_2, regB2_3, regB3_0, regB3_1, regB3_2, regB3_3
                 );

//Start impulse should be given to this node
input start_impulse;

//Input clock should be given to this node
input clk;

//Inform bits from data source should be given to this nodes
input [0:3] Data_in;

//Encoded message should be readed from this nodes
output wire [0:3] Data_out;

//Inform about finish process of coding (impulse)
output wire end_of_work;

//uncomment this section and how information overwrites in the inside registers will be shown (+ 1 same comment segments down the code) 
//DON`T FORGET REBUILD THE MODULE!!!
/*
output wire ctrl;
output wire regB0_0; 
output wire regB0_1; 
output wire regB0_2; 
output wire regB0_3; 
output wire regB1_0; 
output wire regB1_1; 
output wire regB1_2; 
output wire regB1_3; 
output wire regB2_0; 
output wire regB2_1; 
output wire regB2_2; 
output wire regB2_3; 
output wire regB3_0; 
output wire regB3_1; 
output wire regB3_2;
output wire regB3_3;
*/

wire [0:3] Inside_data_bus0;
wire [0:3] Inside_data_bus1;
wire [0:3] Inside_data_bus2;
wire [0:3] Inside_data_bus3;
wire [0:3] Inside_data_bus4;
wire [0:3] Inside_data_bus5;
wire [0:3] Inside_data_bus6;
wire [0:3] Inside_data_bus7;
wire [0:3] Inside_data_bus8;
wire [0:3] Inside_data_bus9;
wire [0:3] Inside_data_bus10;
wire [0:3] Inside_data_bus11;

wire clk_inv;
wire gate_ctrl;
wire ctrl;
//This map description module interconnection 
//between main logic modules of encoder at the top-level
CONTROLLER 			controller				(.END_OF_WORK(end_of_work),			//out 
											 
											 .CLK(clk_inv), 					//in
											 .START_IMPULSE(start_impulse),		//in
											 
											 .CTRL(ctrl),
											 .GATE_CTRL(gate_ctrl)				//out
											 );
											 
//-------------------------------------------------------------------------------											 
CLK_INVERTOR 		clk_invertor			(.CLK_OUT(clk_inv),				//out 
											 .CLK(clk));					//in
//-------------------------------------------------------------------------------	//test
FOUR_BIT_REGISTER	four_bit_reg_1			(.DATA_OUT0(Inside_data_bus1[0]), 
											 .DATA_OUT1(Inside_data_bus1[1]), 
											 .DATA_OUT2(Inside_data_bus1[2]), 
											 .DATA_OUT3(Inside_data_bus1[3]), 
													.DATA_IN0(Inside_data_bus0[0]), 
													.DATA_IN1(Inside_data_bus0[1]), 
													.DATA_IN2(Inside_data_bus0[2]), 
													.DATA_IN3(Inside_data_bus0[3]), 
													.CLK(clk_inv));
//--------------------------------------------------------------------------------													
FOUR_BIT_REGISTER	four_bit_reg_2			(.DATA_OUT0(Inside_data_bus3[0]), 
											 .DATA_OUT1(Inside_data_bus3[1]), 
											 .DATA_OUT2(Inside_data_bus3[2]), 
											 .DATA_OUT3(Inside_data_bus3[3]), 
													.DATA_IN0(Inside_data_bus2[0]), 
													.DATA_IN1(Inside_data_bus2[1]), 
													.DATA_IN2(Inside_data_bus2[2]), 
													.DATA_IN3(Inside_data_bus2[3]), 
													.CLK(clk_inv));
//--------------------------------------------------------------------------------													
FOUR_BIT_REGISTER	four_bit_reg_3			(.DATA_OUT0(Inside_data_bus5[0]), 
											 .DATA_OUT1(Inside_data_bus5[1]), 
											 .DATA_OUT2(Inside_data_bus5[2]), 
											 .DATA_OUT3(Inside_data_bus5[3]), 
													.DATA_IN0(Inside_data_bus4[0]), 
													.DATA_IN1(Inside_data_bus4[1]), 
													.DATA_IN2(Inside_data_bus4[2]), 
													.DATA_IN3(Inside_data_bus4[3]), 
													.CLK(clk_inv));
//--------------------------------------------------------------------------------													
FOUR_BIT_REGISTER	four_bit_reg_4			(.DATA_OUT0(Inside_data_bus7[0]),
											 .DATA_OUT1(Inside_data_bus7[1]), 
											 .DATA_OUT2(Inside_data_bus7[2]), 
											 .DATA_OUT3(Inside_data_bus7[3]), 
													.DATA_IN0(Inside_data_bus6[0]), 
													.DATA_IN1(Inside_data_bus6[1]), 
													.DATA_IN2(Inside_data_bus6[2]), 
													.DATA_IN3(Inside_data_bus6[3]), 
													.CLK(clk_inv));
//--------------------------------------------------------------------------------													
GALUA_ADDER			Galua_adder_1			(.RESULT0(Inside_data_bus2[0]), 
											 .RESULT1(Inside_data_bus2[1]), 
											 .RESULT2(Inside_data_bus2[2]), 
											 .RESULT3(Inside_data_bus2[3]), 
													.NUMBER_A0(Inside_data_bus11[0]), 
													.NUMBER_A1(Inside_data_bus11[1]), 
													.NUMBER_A2(Inside_data_bus11[2]), 
													.NUMBER_A3(Inside_data_bus11[3]), 
															.NUMBER_B0(Inside_data_bus1[0]), 
															.NUMBER_B1(Inside_data_bus1[1]), 
															.NUMBER_B2(Inside_data_bus1[2]), 
															.NUMBER_B3(Inside_data_bus1[3]));
//----------------------------------------------------------------------------------															
GALUA_ADDER			Galua_adder_2			(.RESULT0(Inside_data_bus4[0]), 
											 .RESULT1(Inside_data_bus4[1]), 
											 .RESULT2(Inside_data_bus4[2]), 
											 .RESULT3(Inside_data_bus4[3]), 
													.NUMBER_A0(Inside_data_bus10[0]), 
													.NUMBER_A1(Inside_data_bus10[1]), 
													.NUMBER_A2(Inside_data_bus10[2]), 
													.NUMBER_A3(Inside_data_bus10[3]), 
															.NUMBER_B0(Inside_data_bus3[0]), 
															.NUMBER_B1(Inside_data_bus3[1]), 
															.NUMBER_B2(Inside_data_bus3[2]), 
															.NUMBER_B3(Inside_data_bus3[3]));
//-----------------------------------------------------------------------------------															
GALUA_ADDER			Galua_adder_3			(.RESULT0(Inside_data_bus6[0]), 
											 .RESULT1(Inside_data_bus6[1]), 
											 .RESULT2(Inside_data_bus6[2]), 
											 .RESULT3(Inside_data_bus6[3]), 
													.NUMBER_A0(Inside_data_bus9[0]), 
													.NUMBER_A1(Inside_data_bus9[1]), 
													.NUMBER_A2(Inside_data_bus9[2]), 
													.NUMBER_A3(Inside_data_bus9[3]), 
															.NUMBER_B0(Inside_data_bus5[0]), 
															.NUMBER_B1(Inside_data_bus5[1]), 
															.NUMBER_B2(Inside_data_bus5[2]), 
															.NUMBER_B3(Inside_data_bus5[3]));
//-----------------------------------------------------------------------------------															
GALUA_ADDER			Galua_adder_4			(.RESULT0(Inside_data_bus8[0]), 
											 .RESULT1(Inside_data_bus8[1]), 
											 .RESULT2(Inside_data_bus8[2]), 
											 .RESULT3(Inside_data_bus8[3]), 
													.NUMBER_A0(Inside_data_bus7[0]), 
													.NUMBER_A1(Inside_data_bus7[1]), 
													.NUMBER_A2(Inside_data_bus7[2]), 
													.NUMBER_A3(Inside_data_bus7[3]), 
															.NUMBER_B0(Data_in[0]), 
															.NUMBER_B1(Data_in[1]), 
															.NUMBER_B2(Data_in[2]), 
															.NUMBER_B3(Data_in[3]));
//------------------------------------------------------------------------------------															
MULTIPLIER_x3 		Multiplier_x3			(.DATA_OUT0(Inside_data_bus10[0]), 
											 .DATA_OUT1(Inside_data_bus10[1]), 
											 .DATA_OUT2(Inside_data_bus10[2]), 
											 .DATA_OUT3(Inside_data_bus10[3]), 
													.DATA_IN0(Inside_data_bus11[0]), 
													.DATA_IN1(Inside_data_bus11[1]), 
													.DATA_IN2(Inside_data_bus11[2]), 
													.DATA_IN3(Inside_data_bus11[3]));
//---------------------------------------------------------------------------------------													
MULTIPLIER_x12		Multiplier_x12			(.DATA_OUT0(Inside_data_bus0[0]), 
											 .DATA_OUT1(Inside_data_bus0[1]), 
											 .DATA_OUT2(Inside_data_bus0[2]), 
											 .DATA_OUT3(Inside_data_bus0[3]), 
													.DATA_IN0(Inside_data_bus11[0]), 
													.DATA_IN1(Inside_data_bus11[1]), 
													.DATA_IN2(Inside_data_bus11[2]), 
													.DATA_IN3(Inside_data_bus11[3]));
//----------------------------------------------------------------------------------------													
MULTIPLIER_x15		Multiplier_x15			(.DATA_OUT0(Inside_data_bus9[0]), 
											 .DATA_OUT1(Inside_data_bus9[1]), 
											 .DATA_OUT2(Inside_data_bus9[2]), 
											 .DATA_OUT3(Inside_data_bus9[3]), 
													.DATA_IN0(Inside_data_bus11[0]), 
													.DATA_IN1(Inside_data_bus11[1]), 
													.DATA_IN2(Inside_data_bus11[2]), 
													.DATA_IN3(Inside_data_bus11[3]));
//----------------------------------------------------------------------------------------													
GATE				Gate			 		(.DATA_OUT0(Inside_data_bus11[0]), 
											 .DATA_OUT1(Inside_data_bus11[1]), 
											 .DATA_OUT2(Inside_data_bus11[2]), 
											 .DATA_OUT3(Inside_data_bus11[3]), 
													.DATA_IN0(Inside_data_bus8[0]), 
													.DATA_IN1(Inside_data_bus8[1]), 
													.DATA_IN2(Inside_data_bus8[2]), 
													.DATA_IN3(Inside_data_bus8[3]), 
													.GATE(gate_ctrl),
													.CLK(clk));
//------------------------------------------------------------------------------------------													
DATA_MPX			DataMultiplexor	 		(.DATA_OUT0(Data_out[0]), 
											 .DATA_OUT1(Data_out[1]), 
											 .DATA_OUT2(Data_out[2]), 
											 .DATA_OUT3(Data_out[3]), 
													.DATA_IN_FROM_AUTOREGRESSIVE0(Inside_data_bus7[0]), 
													.DATA_IN_FROM_AUTOREGRESSIVE1(Inside_data_bus7[1]), 
													.DATA_IN_FROM_AUTOREGRESSIVE2(Inside_data_bus7[2]), 
													.DATA_IN_FROM_AUTOREGRESSIVE3(Inside_data_bus7[3]), 
															.DATA_IN_FROM_SOURCE0(Data_in[0]), 
															.DATA_IN_FROM_SOURCE1(Data_in[1]), 
															.DATA_IN_FROM_SOURCE2(Data_in[2]), 
															.DATA_IN_FROM_SOURCE3(Data_in[3]), 
																	.CONTROL(ctrl));
//--------------------------------------------------------------------------------------------
//uncomment this section and how information overwrites in the inside registers will be shown
//DON`T FORGET REBUILD THE MODULE!!!
/*
assign regB0_0 = Inside_data_bus1[0]; 
assign regB0_1 = Inside_data_bus1[1]; 
assign regB0_2 = Inside_data_bus1[2]; 
assign regB0_3 = Inside_data_bus1[3]; 

assign regB1_0 = Inside_data_bus3[0]; 
assign regB1_1 = Inside_data_bus3[1]; 
assign regB1_2 = Inside_data_bus3[2]; 
assign regB1_3 = Inside_data_bus3[3];
 
assign regB2_0 = Inside_data_bus5[0]; 
assign regB2_1 = Inside_data_bus5[1]; 
assign regB2_2 = Inside_data_bus5[2]; 
assign regB2_3 = Inside_data_bus5[3];
 
assign regB3_0 = Inside_data_bus7[0]; 
assign regB3_1 = Inside_data_bus7[1]; 
assign regB3_2 = Inside_data_bus7[2];
assign regB3_3 = Inside_data_bus7[3];
*/
endmodule


//***********************************************************************************************************************************************************************************
//------------------------------------------------------------------------------------------------------------------------------------------------
//Module that controls process of encoding. While clk`s == 0......11 at the registers "four-bit-reg1",...four-bit-reg4" forming additional tail, that 
//helps to understand is the error was added while information translating from coder`s side to decoder`s side. While clk`s == 11..15 information from
// registers "four-bit-reg1",...four-bit-reg4" adding to main information, translated at clk`s 0 - 11
//------------------------------------------------------------------------------------------------------------------------------------------------
module CONTROLLER(input START_IMPULSE, 
				  input CLK, 
							output reg GATE_CTRL = 1'b1,
							output reg CTRL = 1'b1, 
							output wire END_OF_WORK);

//Service node that forming order to device for waiting next start impulse 
//and tell you about process of message transmission is already finished
// is "output wire END_OF_WORK";

//Service registers
reg start_work = 1'b0;
reg device_in_work = 1'b0;
reg reset_device = 1'b0;
integer i = 0;

always @ (posedge START_IMPULSE or posedge END_OF_WORK)
begin

		if (END_OF_WORK)
		begin
		start_work = 1'b0;
		end
		else
		begin
		start_work = 1'b1;
		end

end


always @ (posedge CLK)
begin
	case (start_work)
	1:
	begin
	device_in_work = 1'b1;
	end
	
	0:
	begin
	device_in_work = 1'b0;		
	end
	
	default:
	begin
	device_in_work = 1'b0;
	end
	endcase
	
	
	if (device_in_work==1'b1)
			begin
					if (i<15)			
					//********************************************************************
					//-------------here is main actions of device-----------------------**
					//******************************************************************** 
					//when clk`s == 0..10 information run to the air directly from data source
					//when clk`s == 11..14 tail concatenate with main message was runned earlier and translate follow it


					begin
								case(i)
								0:
								begin
								CTRL = 1'b1;
								reset_device = 1'b0;
								GATE_CTRL = 1'b1;
								i = i + 1;
								end
								1:
								begin
								i = i + 1;
								end
								2:
								begin
								i = i + 1;
								end
								3:
								begin
								i = i + 1;
								end
								4:
								begin
								i = i + 1;
								end
								5:
								begin
								i = i + 1;
								end
								6:
								begin
								i = i + 1;
								end
								7:
								begin
								i = i + 1;
								end
								8:
								begin
								i = i + 1;
								end
								9:
								begin
								i = i + 1;
								end
								
								10:
								begin
								i = i + 1;
								
								end
								
								11:
								begin
								GATE_CTRL = 1'b0;
								CTRL = 1'b0;
								i = i + 1;
								end
								
								12:
								begin
								i = i + 1;
								end
								
								13:
								begin
								i = i + 1;
								end
								
								14:
								begin
								reset_device = 1'b1;
								i = i + 1;
								end
								

								default://------------put here what will doing this device by default
								begin
								i = 0;
								reset_device = 1'b0;
								GATE_CTRL = 1'b0;
								end
								endcase
					end
					else
					
					begin
					i = 0; 
					device_in_work = 1'b0;
					end
			end
end	

assign END_OF_WORK = device_in_work && reset_device;
endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------
// in the case if the clk in input node has high logic level, the clk in the output node has low logic level and back;
//------------------------------------------------------------------------------------------------------------------------------------------------
module CLK_INVERTOR(input CLK, output CLK_OUT);
assign CLK_OUT = ~CLK;
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//4 - bit register....
//------------------------------------------------------------------------------------------------------------------------------------------------
module FOUR_BIT_REGISTER(input DATA_IN0, 
						 input DATA_IN1, 
						 input DATA_IN2, 
						 input DATA_IN3, 
						 input CLK,
							output reg DATA_OUT0, 
							output reg DATA_OUT1, 
							output reg DATA_OUT2, 
							output reg DATA_OUT3);

always @ (posedge CLK)
begin
DATA_OUT0 = DATA_IN0;
DATA_OUT1 = DATA_IN1;
DATA_OUT2 = DATA_IN2;
DATA_OUT3 = DATA_IN3;
end

endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
// Galua field`s summary is logical operation named XOR
//------------------------------------------------------------------------------------------------------------------------------------------------
module GALUA_ADDER (input NUMBER_A0, 
					input NUMBER_A1,
					input NUMBER_A2,
					input NUMBER_A3,
						input NUMBER_B0,
						input NUMBER_B1,
						input NUMBER_B2,
						input NUMBER_B3,
							output RESULT0,
							output RESULT1,
							output RESULT2,
							output RESULT3);
assign RESULT0 = NUMBER_A0 ^ NUMBER_B0;			
assign RESULT1 = NUMBER_A1 ^ NUMBER_B1;
assign RESULT2 = NUMBER_A2 ^ NUMBER_B2;
assign RESULT3 = NUMBER_A3 ^ NUMBER_B3;
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//--Galua field multipliers can be discribed as a combinatorial schemes (see special theory)
//------------------------------------------------------------------------------------------------------------------------------------------------
module MULTIPLIER_x3(input DATA_IN0,
					 input DATA_IN1,
					 input DATA_IN2,
					 input DATA_IN3,
						output DATA_OUT0,
						output DATA_OUT1,
						output DATA_OUT2,
						output DATA_OUT3);
assign DATA_OUT0 = DATA_IN0 ^ DATA_IN3;
assign DATA_OUT1 = DATA_IN0 ^ DATA_IN1 ^ DATA_IN3;
assign DATA_OUT2 = DATA_IN1 ^ DATA_IN2;
assign DATA_OUT3 = DATA_IN2 ^ DATA_IN3;
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//--Galua field multipliers can be discribed as a combinatorial schemes (see special theory)
//------------------------------------------------------------------------------------------------------------------------------------------------
module MULTIPLIER_x12(input DATA_IN0,
					 input DATA_IN1,
					 input DATA_IN2,
					 input DATA_IN3,
						output DATA_OUT0,
						output DATA_OUT1,
						output DATA_OUT2,
						output DATA_OUT3);
assign DATA_OUT0 = DATA_IN1 ^ DATA_IN2;
assign DATA_OUT1 = DATA_IN1 ^ DATA_IN3;
assign DATA_OUT2 = DATA_IN0 ^ DATA_IN2;
assign DATA_OUT3 = DATA_IN0 ^ DATA_IN1 ^ DATA_IN3;
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//--Galua field multipliers can be discribed as a combinatorial schemes (see special theory)
//------------------------------------------------------------------------------------------------------------------------------------------------
module MULTIPLIER_x15(input DATA_IN0,
					  input DATA_IN1,
					  input DATA_IN2,
					  input DATA_IN3,
						output DATA_OUT0,
						output DATA_OUT1,
						output DATA_OUT2,
						output DATA_OUT3);
assign DATA_OUT0 = DATA_IN0^DATA_IN1^DATA_IN2^DATA_IN3;
assign DATA_OUT1 = DATA_IN0;
assign DATA_OUT2 = DATA_IN0^DATA_IN1;
assign DATA_OUT3 = DATA_IN0^DATA_IN1^DATA_IN2;
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------
module GATE(input DATA_IN0,
			input DATA_IN1,
			input DATA_IN2,
			input DATA_IN3,
				input CLK, 
				input GATE,
					output reg DATA_OUT0,
					output reg DATA_OUT1,
					output reg DATA_OUT2,
					output reg DATA_OUT3);


always @ (posedge CLK)

	case (GATE)
	1'b1:
	begin
		DATA_OUT0 = DATA_IN0; 
		DATA_OUT1 = DATA_IN1;
		DATA_OUT2 = DATA_IN2;
		DATA_OUT3 = DATA_IN3;  
	end		
	1'b0:	
	begin	
		DATA_OUT0 = 1'b0; 
		DATA_OUT1 = 1'b0;
		DATA_OUT2 = 1'b0;
		DATA_OUT3 = 1'b0;
	end
	default:
	begin
		DATA_OUT0 = 1'b0; 
		DATA_OUT1 = 1'b0;
		DATA_OUT2 = 1'b0;
		DATA_OUT3 = 1'b0;
	end
	endcase
endmodule
//------------------------------------------------------------------------------------------------------------------------------------------------
//Simple multiplexor
//------------------------------------------------------------------------------------------------------------------------------------------------
module DATA_MPX(input DATA_IN_FROM_AUTOREGRESSIVE0,
					   input DATA_IN_FROM_AUTOREGRESSIVE1,
					   input DATA_IN_FROM_AUTOREGRESSIVE2,
					   input DATA_IN_FROM_AUTOREGRESSIVE3,
							input DATA_IN_FROM_SOURCE0,
							input DATA_IN_FROM_SOURCE1,
							input DATA_IN_FROM_SOURCE2,
							input DATA_IN_FROM_SOURCE3,
								input CONTROL,
										output DATA_OUT0,
										output DATA_OUT1,
										output DATA_OUT2,
										output DATA_OUT3);
										
assign DATA_OUT0 = CONTROL ? DATA_IN_FROM_SOURCE0 : DATA_IN_FROM_AUTOREGRESSIVE0;
assign DATA_OUT1 = CONTROL ? DATA_IN_FROM_SOURCE1 : DATA_IN_FROM_AUTOREGRESSIVE1;
assign DATA_OUT2 = CONTROL ? DATA_IN_FROM_SOURCE2 : DATA_IN_FROM_AUTOREGRESSIVE2;
assign DATA_OUT3 = CONTROL ? DATA_IN_FROM_SOURCE3 : DATA_IN_FROM_AUTOREGRESSIVE3;
endmodule
