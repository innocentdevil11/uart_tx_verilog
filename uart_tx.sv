`timescale 1ns/1ps

module uart_tx (
    input wire clk,
    input wire rst,
    input wire load,
    input wire baud_tick,
    input wire [7:0] data_in,
    output reg tx,
    output reg busy
);

    reg [3:0] bit_index;
    reg [9:0] shift_reg;
    reg [1:0] state;

    // State encoding
    parameter IDLE = 2'b00;
    parameter LOAD = 2'b01;
    parameter SHIFT = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            busy <= 1'b0;
            bit_index <= 4'd0;
            shift_reg <= 10'b1111111111;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    busy <= 1'b0;
                    bit_index <= 4'd0;
                    if (load) begin
                        state <= LOAD;
                    end
                end

                LOAD: begin
                    shift_reg <= {1'b1, data_in, 1'b0}; // stop, data, start
                    busy <= 1'b1;
                    state <= SHIFT;
                end

                SHIFT: begin
                    if (baud_tick) begin
                        tx <= shift_reg[0];
                        shift_reg <= shift_reg >> 1;
                        bit_index <= bit_index + 1;
                        if (bit_index == 4'd9) begin
                            state <= IDLE;
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
