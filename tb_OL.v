`timescale 1 ns / 100 ps

module tb_OL();

    reg clk;
    reg Rn;
    wire [2:0] CurrentState;
    reg [2:0] CS;
    wire [1:0] sw;
    wire [2:0] NextState;
    wire turnstate;
    wire [7:0] HEX0;
    reg [7:0] H0;
    wire [2:0] led1;
    reg [2:0] l1;
    wire [2:0] led2;
    reg [2:0] l2;

    OL O0(
    .CurrentState(CurrentState),
    .SW(sw),
    .turn_side(turnstate),
    .HEX0(HEX0),
    .LEDR_L(led1),
    .LEDR_R(led2)
    );

     initial
        begin
            clk = 1'b0;
            Rn = 1'b0;    
        #10 Rn = 1'b1;
        end

    initial
        begin
        l1 = 0;
        l2 = 0;
        H0 = 0;
        #15 CS = 0;
        #20 CS = 1;
        #25 CS = 2;
        #30 CS = 3;
        end
        
    assign led1 = l1;
    assign led2 = l2;
    assign HEX0 = H0;
    assign CurrentState = CS;

    always
        #5 clk = ~clk;

    initial
        begin
            $dumpfile("output.vcd");
            $dumpvars;
            $display("Starting simulation");
        end   

    initial
        begin
        $monitor("%d,\t%b,\t%b,\t%d", $time, clk, Rn, led1, HEX0);        
        end

        initial
            begin
            $display("Simulation ended.");
            #1300 $finish;
            end
        

endmodule