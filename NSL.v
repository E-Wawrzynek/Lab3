module NSL(
	input [2:0] CurrentState,
    input clk,
    input [1:0] SW,
    input turn_side_r,
	output [2:0] NextState, 
    input [1:0] K
);

    parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b011;

    reg [2:0] NextState_temp;

    always @(CurrentState)
        begin
            if(SW[0] == 1)
                begin
                    NextState_temp <= HAZARDS; //3'b001; //hazards
                end
            else if(SW[1] == 1)
                begin
                    if(turn_side_r == 0)
                        NextState_temp <= TURN_LEFT; //3'b010; //turn left
                    else if(turn_side_r == 1)
                        NextState_temp <= TURN_RIGHT; //3'b100; //turn right
                end
            else
                NextState_temp <= IDLE; //3'b000; //idle
        end
    
    assign NextState = NextState_temp;
    
endmodule