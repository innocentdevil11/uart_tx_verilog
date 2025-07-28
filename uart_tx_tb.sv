`timescale 1ns/1ps

module uart_tx_tb;

    reg clk = 0;
    reg rst = 1;
    reg load = 0;
    reg baud_tick = 0;
    reg [7:0] data_in = 8'b01010101;
    wire tx;
    wire busy;

    uart_tx uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .baud_tick(baud_tick),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    // Clock: 10ns period
    always #5 clk = ~clk;

    // Baud tick generation
    initial begin
        forever begin
            #10417 baud_tick = 1;
            #5 baud_tick = 0;
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, uart_tx_tb);

        #20 rst = 0;
        #50 load = 1;
        #10 load = 0;

        #120000 $finish;
    end

endmodule
