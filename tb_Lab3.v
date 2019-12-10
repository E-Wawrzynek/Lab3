`timescale 1 ns / 100 ps

module tb_Lab3();

    reg clk;
    reg Rn;
    wire [7:0] HEX0;
    wire [7:0] HEX1;
    wire [7:0] HEX3;
    wire [7:0] HEX2;
    wire [7:0] HEX4;
    wire [7:0] HEX5;
    wire [1:0] K;
    reg [9:0] sw = 9'b0;
    wire [9:0] led;

    Lab3 L0(
        .ADC_CLK_10(clk),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5),
        .KEY(K),
        .LEDR(led),
        .SW(sw)
    );

    initial
        begin
            clk = 1'b0;
            Rn = 1'b0;
        #10 Rn = 1'b1;
        end

    always
        #5 clk = ~clk;
         sw = ~sw;

    initial
        begin
            $dumpfile("output.vcd");
            $dumpvars;
            $display("Starting simulation");
        end   

    initial
        begin
        $monitor("%d,\t%b,\t%b,\t%d", $time, clk, Rn, led, HEX0);        
        end

        initial
            begin
            $display("Simulation ended.");
            #1300 $finish;
            end

endmodule