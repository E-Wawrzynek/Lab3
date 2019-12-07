module OL(
    input [2:0] CurrentState,
    input [1:0] SW,
    //input turn_side,
    output [7:0] HEX0,
    output reg [2:0] LEDR_L,
    output reg [2:0] LEDR_R
);

    parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b011;

    reg hazard_r = 1'b0;
    reg turn_cnt = 3'b000;

    always @(CurrentState)
        begin
            case(CurrentState)
            IDLE: 
                begin
                    LEDR_L <= 3'b000;
                    LEDR_R <= 3'b000;
                end
            HAZARDS:
                begin
                    if(hazard_r == 1'b0)
                        begin
                            LEDR_L <= 3'b000;
                            LEDR_R <= 3'b000;
                        end
                    else if(hazard_r == 1'b1)
                        begin
                            LEDR_L <= 3'b111;
                            LEDR_R <= 3'b111;
                        end
                    hazard_r <= ~hazard_r;
                end
            TURN_LEFT:
                begin
                    case(turn_cnt)
                    3'b001: LEDR_L <= 3'b001;
                    3'b010: LEDR_L <= 3'b010;
                    3'b011: LEDR_L <= 3'b100;
                    default: LEDR_L <= 3'b000;
                    endcase
                    if(turn_cnt == 3'b011)
                        turn_cnt <= 3'b000;
                    else
                        turn_cnt <= turn_cnt + 1;
                end
            TURN_RIGHT:
                begin
                    case(turn_cnt)
                    3'b001: LEDR_R <= 3'b100;
                    3'b010: LEDR_R <= 3'b010;
                    3'b011: LEDR_R <= 3'b001;
                    default: LEDR_R <= 3'b000;
                    endcase
                    if(turn_cnt == 3'b011)
                        turn_cnt <= 3'b000;
                    else
                        turn_cnt <= turn_cnt + 1;
                end
            endcase 
        end


    reg[7:0] num;

    always @(CurrentState)
        num = CurrentState;

    SevenSeg S0(.H(HEX0), .NUM(num));

endmodule