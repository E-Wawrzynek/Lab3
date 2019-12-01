module CSL(
	input clk,
	input reset_n,
	input [2:0] NextState,
	output reg [2:0] CurrentState,

    input [1:0] SW,
    input turn_side,
    output [7:0] HEX0,
    output [2:0] LEDR_L,
    output [2:0] LEDR_R
);

    always @(posedge clk, negedge reset_n)
        if(reset_n == 0)
            CurrentState = 3'b000;
        else
            CurrentState = NextState;

    OL O0(.CurrentState(CurrentState), .SW(SW), .KEY(KEY), .turn_side(turn_side_r), .HEX0(HEX0), .LEDR_L(LEDR_L), .LEDR_R(LEDR_R));

endmodule