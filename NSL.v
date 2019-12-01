module NSL(
    input clk,
	input reset_n,

	input [2:0] CurrentState,
    input [1:0] SW,
    input [1:0] KEY,
	output reg [2:0] NextState,

    input turn_side,
    output [7:0] HEX0,
    output [2:0] LEDR_L,
    output [2:0] LEDR_R
);

    always @(CurrentState, SW[1:0], KEY[1])
        begin
            if(SW[0] == 1)
                begin
                    NextState = 3'b001; //hazards
                end
            else if(SW[1] == 1)
                begin
                    if(KEY[1] == 0)
                        NextState = 3'b010; //turn left
                    else if(KEY[1] == 1)
                        NextState = 3'b100; //turn right
                end
            else
                NextState = 3'b000; //idle
        end

    CSL C0(.clk(clk), .reset_n(reset_n), .NextState(NextState), .CurrentState(CurrentState));
    // parameter IDLE = 3'b000;
	// parameter HAZARDS = 3'b001;
	// parameter TURN_LEFT = 3'b010;
	// parameter TURN_RIGHT = 3'b100;
endmodule