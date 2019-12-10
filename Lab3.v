
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Lab3(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

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

	assign LEDR[6:3] = 4'b0000;

	//currently ALL seven segs blanked, need to use some to display state of state machine
	//SevenSeg U0(.H(HEX0), .NUM(8'd88));
	SevenSeg U1(.H(HEX1), .NUM(8'd88));
	SevenSeg U2(.H(HEX2), .NUM(8'd88));
	SevenSeg U3(.H(HEX3), .NUM(8'd88));
	SevenSeg U4(.H(HEX4), .NUM(8'd88));
	SevenSeg U5(.H(HEX5), .NUM(8'd88));

	reg reset_latch = 1'b0;

	always @(negedge KEY[0])
		begin
			reset_latch <= ~reset_latch;
		end

	wire s_clk;

	clock_divider #(1_000_000) C0(.clk(ADC_CLK_10), .reset_n(reset_latch), .slower_clk(s_clk));


	reg turn_side_r = 1'b0;

	always @(negedge KEY[1])
		begin
			turn_side_r <= ~turn_side_r;
		end


	parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b011;

	wire [2:0] CurrentState;
	wire [2:0] NextState;

	CSL S0(.clk(s_clk), .reset_n(reset_latch), .NextState(NextState), .CurrentState(CurrentState));
	NSL N0(.CurrentState(CurrentState), .SW(SW[1:0]), .turn_side_r(turn_side_r), .NextState(NextState));
	OL O0(.CurrentState(CurrentState), .clk(s_clk), .reset_n(reset_latch), .SW(SW[1:0]), .HEX0(HEX0), .LEDR_L(LEDR[9:7]), .LEDR_R(LEDR[2:0]));

endmodule
