`timescale 1ns / 1ps

module four_input_xor(input logic [3:0] a, b, output logic [3:0] res);
    assign res = a ^ b;
endmodule
