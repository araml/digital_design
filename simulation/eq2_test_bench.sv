`timescale 1ns / 10ps

module eq2_test_bench();
    logic [1:0] test_in0, test_in1;
    wire test_out;

    two_bit_comparator uut(.i0(test_in0), .i1(test_in1), .eq(test_out));

    initial
    begin
        test_in0 = 2'b00;
        test_in1 = 2'b00;
        # 200;
        test_in0 = 2'b01;
        //assert(test_in1 == 2'b01);
        test_in1 = 2'b00;
        # 200;
        $stop;
    end

    logic [3:0] test_a, test_b, result;
    four_input_xor xxor(.a(test_a), .b(test_b), .res(result));
    
    initial
    begin
        test_a = 4'b0000;
        test_b = 4'b0001;
        # 200;
        test_a = 4'b1010;
        test_b = 4'b1010;
        # 200;
        test_a = 4'b1010;
        test_b = 4'b0101;
        #200;
        $stop;
    end
    
    logic x, y, z, res_min;
    
    minority mino(x, y, z, res_min);
    
    initial
    begin
        x = 1'b0;
        y = 1'b0;
        z = 1'b0;
        assert (res_min == 1'b1);
        # 200;
        x = 1'b1;
        y = 1'b0;
        z = 1'b0;
        assert (res_min == 1'b1);
        # 200;
        x = 1'b1;
        y = 1'b1;
        z = 1'b0;
        assert (res_min == 1'b0);
        # 200;
        x = 1'b1;
        y = 1'b1;
        z = 1'b1;
        assert (res_min == 1'b0);
        # 200;
        $stop;
    end
    
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
