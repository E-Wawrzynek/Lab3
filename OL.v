module OL(
    input [2:0] CurrentState,
    input clk,
    input reset_n,
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
    reg turn_cnt= 2'b00;

    always @(posedge clk, negedge reset_n)
        begin
            if(reset_n == 0)
                begin
                LEDR_R = 3'b000;
                LEDR_L = 3'b000;
                end
            else
                begin
                case(CurrentState)
                HAZARDS: begin
                        hazard_r <= ~hazard_r;
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
                    end
                TURN_LEFT: begin
                        LEDR_R <= 3'b000;
                        if(turn_cnt == 2'b11)
                            turn_cnt <= 2'b00;
                        else
                            turn_cnt <= turn_cnt + 1'b1;
                        case(turn_cnt)
                        2'b01: LEDR_L <= 3'b001;
                        2'b10: LEDR_L <= 3'b010;
                        2'b11: LEDR_L <= 3'b100;
                        default: LEDR_L <= 3'b000;
                        endcase
                    end
                TURN_RIGHT: begin
                        LEDR_L <= 3'b000;
                        if(turn_cnt == 2'b11)
                            turn_cnt <= 2'b00;
                        else
                            turn_cnt <= turn_cnt + 1'b1;
                        case(turn_cnt)
                        2'b01: LEDR_R <= 3'b100;
                        2'b10: LEDR_R <= 3'b010;
                        2'b11: LEDR_R <= 3'b001;
                        default: LEDR_R <= 3'b000;
                        endcase  
                    end
                default: begin
                        LEDR_L <= 3'b000;
                        LEDR_R <= 3'b000;
                    end
            endcase
            end 
        end


    reg[7:0] num;

    always @(CurrentState)
        num <= CurrentState;

    SevenSeg S0(.H(HEX0), .NUM(num));

endmodule