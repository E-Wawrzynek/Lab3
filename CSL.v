module CSL(
	input clk,
	input reset_n,
	input [2:0] NextState,
	output reg [2:0] CurrentState,
    input [9:0] SW,
    input [1:0] K
);

    parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b011;

    always @(posedge clk, negedge reset_n)
        if(reset_n == 0)
            CurrentState = IDLE; //3'b000;
        else
            CurrentState = NextState;

endmodule