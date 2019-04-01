`timescale 1ns / 1ps


module minority(
    input logic x,
    input logic y,
    input logic z,
    output logic result
    );
    
    /*
        if two are false then (a and b) and (b and c) are bot 0
        then we negate both and and them, if two or all are true this would be false, lets test it
    */
    
    logic a, b;
    assign a = x & y;
    assign b = y & z;
    assign result = ~a & ~b;

/*
    x y z res
    0 0 0 true
    1 0 0 true
    1 1 0 false
    1 1 1 false
    1 0 1 false
    0 1 0 true
    0 1 1 false
    0 0 1 true
*/
endmodule
