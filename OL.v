module OL(
    input [2:0] CurrentState,
    input [1:0] SW,
    input turn_side,
    output [7:0] HEX0,
    output [2:0] LEDR_L,
    output [2:0] LEDR_R
);

    parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b100;

    reg ledr;
    reg ledl;
    reg ledh;

    always @(CurrentState)
        begin
            case(CurrentState)
            IDLE: 
                begin
                    ledr = 0;
                    ledl = 0;
                    ledh = 0;
                end
            HAZARDS:
                begin
                    ledr = 1;
                    ledl = 1;
                    ledh = 1;
                end
            TURN_LEFT:
                begin
                    ledr = 0;
                    ledl = 1;
                    ledh = 0;
                end
            TURN_RIGHT:
                begin
                    ledr = 1;
                    ledl = 0;
                    ledh = 0;
                end
            endcase 
        end

    assign LEDR_L[0] = ledr;
    assign LEDR_L[1] = ledl;
    assign LEDR_L[2] = ledh;
    
    reg[7:0] num;

    always @(CurrentState)
        num = CurrentState;

    SevenSeg S0(.H(HEX0), .NUM(num));

endmodule