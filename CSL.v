module CSL(
	input clk,
	input reset_n,
	input [2:0] NextState,
	output reg [2:0] CurrentState
);

    always @(posedge clk or negedge reset_n)
        if(reset_n == 0)
            CurrentState = 3'b0;
        else
            CurrentState = NextState;

endmodule