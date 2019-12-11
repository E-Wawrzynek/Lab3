
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Lab3(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);

	// assign LEDR[6:3] = 4'b0000;

	// //currently ALL seven segs blanked, need to use some to display state of state machine
	// //SevenSeg U0(.H(HEX0), .NUM(8'd88));
	// SevenSeg U1(.H(HEX1), .NUM(8'd88));
	// SevenSeg U2(.H(HEX2), .NUM(8'd88));
	// SevenSeg U3(.H(HEX3), .NUM(8'd88));
	// SevenSeg U4(.H(HEX4), .NUM(8'd88));
	// SevenSeg U5(.H(HEX5), .NUM(8'd88));

	// reg reset_latch = 1'b0;

	// always @(negedge KEY[0])
	// 	begin
	// 		reset_latch <= ~reset_latch;
	// 	end

	wire s_clk2;
	wire reset_latch = KEY[0];

	clock_divider #(25_000_000) C0(.clk(ADC_CLK_10), .reset_n(reset_latch), .slower_clk(s_clk2));

	//assign LEDR[6] = s_clk2;

	wire [1:0] addr;
	cntr R0(.clk(s_clk2), .cnt(addr));

	assign LEDR[4:3] = addr;

	wire [7:0] data;

	wire [1:0] switches;
	wire [1:0] keys;

	mem M0(.address({6'b000000, addr}), .clock(s_clk2), .q(data));

	assign data[7:4] = 4'b0000;
	assign LEDR[6:5] = data[1:0];

	assign switches[1] = SW[9] ? data[3] : SW[1];
	assign switches[0] = SW[9] ? data[2] : SW[0];
	assign keys[1] = SW[9] ? data[1] : KEY[1];
	//assign keys[0] = SW[9] ? data[0] : KEY[0];

	statemachine G0(.ADC_CLK_10(ADC_CLK_10), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .KEY({keys[1], KEY[0]}), .LEDR_L(LEDR[9:7]),  .LEDR_R(LEDR[2:0]), .SW({SW[9], 7'b000000, switches[1:0]}));
	// reg turn_side_r = 1'b0;

	// always @(negedge KEY[1])
	// 	begin
	// 		turn_side_r <= ~turn_side_r;
	// 	end


	// parameter IDLE = 3'b000;
	// parameter HAZARDS = 3'b001;
	// parameter TURN_LEFT = 3'b010;
	// parameter TURN_RIGHT = 3'b011;

	// wire [2:0] CurrentState;
	// wire [2:0] NextState;

	// CSL S0(.clk(s_clk), .reset_n(reset_latch), .NextState(NextState), .CurrentState(CurrentState), .SW(SW), .K(KEY));
	// NSL N0(.CurrentState(CurrentState), .SW(SW[1:0]), .turn_side_r(turn_side_r), .NextState(NextState), .K(KEY));
	// OL O0(.CurrentState(CurrentState), .clk(s_clk), .reset_n(reset_latch), .K(KEY), .SW(SW[1:0]), .HEX0(HEX0), .LEDR_L(LEDR[9:7]), .LEDR_R(LEDR[2:0]));

endmodule
