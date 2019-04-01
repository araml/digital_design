`timescale 1ns / 1ps

module two_bit_comparator(input logic[1:0] i0, i1, output logic eq);
    logic p0, p1, p2, p3;

    assign eq = p0 | p1 | p2 | p3;

    assign p0 = (~i0[1] & ~i1[1]) & (~i0[0] & ~i1[0]);
    assign p1 = (~i0[1] & ~i1[1]) & (i0[0] & i1[0]);
    assign p2 = (i0[1] & i1[1]) & (~i0[0] & ~i1[0]);
    assign p3 = (i0[1] & i1[1]) & (i0[0] & i1[0]);

endmodule
