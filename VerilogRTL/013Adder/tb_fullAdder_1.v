module tb_fullAdder_1 ();

reg a,b,ci;
wire s,cout;

initial begin
    a = 1;
    b = 1;
    ci = 1;

    repeat (10)begin
        #10 a = a + 1;
    end

end


fullAdder_1 add_1(
    .a(a), 
    .b(b), //两个一位加数字
    .c_i(ci),  //进位输入

    .s(s), 
    .c_out(cout)
);

endmodule

// vsim .\tb_fullAdder_1.v -voptargs=+acc