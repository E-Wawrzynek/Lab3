module NSL(
	input [2:0] CurrentState,
    input [1:0] SW,
    input [1:0] KEY,
	output reg [2:0] NextState
);

    always @(CurrentState, SW[1:0], KEY[1])
        begin
            if(SW[0] == 1)
                begin
                    NextState = Lab3.HAZARDS;
                end
            else if(SW[1] == 1)
                begin
                    if(KEY[1] == 0)
                        NextState = Lab3.TURN_LEFT;
                    else if(KEY[1] == 1)
                        NextState = Lab3.TURN_RIGHT;
                end
            else
                NextState = Lab3.IDLE;
        end

endmodule