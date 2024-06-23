module full_adder(
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);
assign sum = a ^ b ^ cin;
assign cout = (((a^b) && cin) || (b && a));
endmodule

module add_sub (
    input [2:0] a1, 
    input [2:0] b1,
    input Add_Sub,
    output [2:0] sf,
    output sign
);

wire [2:0] s; //declaring s
wire control = (b1[2]^Add_Sub) ^ a1[2]; //calculating control
wire [2:0] tempcarry; //hold carry temporarily 
wire dispose; //wire to dispose of last carry

full_adder s0 ( //first adder 
    .a(a1[0]),
    .b(control^b1[0]),
    .cin(control),
    .sum(s[0]), 
    .cout(tempcarry[0])
);

full_adder s1_2 ( //second adder
    .a(a1[1]),
    .b(control^b1[1]),
    .cin(tempcarry[0]),
    .sum(s[1]), 
    .cout(s[2]) 
);

wire compliment = control && ~s[2]; //used to determine whether to compliment b or not
assign sign = (compliment && (~a1[2])) || (a1[2] && (s[2] || ~control)); //calculates sign

full_adder sf0 ( //third adder, calculates sf0
    .a(compliment^s[0]),
    .b(0),
    .cin(compliment),
    .sum(sf[0]), 
    .cout(tempcarry[1])
);

full_adder sf1 ( //fourth adder, calculates sf1
    .a(s[1]^compliment),
    .b(0),
    .cin(tempcarry[1]),
    .sum(sf[1]),
    .cout(tempcarry[2])
);

full_adder sf2 ( //fifth adder, calculates sf2
    .a(s[2] && ~control),
    .b(1'b0),
    .cin(tempcarry[2]),
    .sum(sf[2]),
    .cout(dispose)
);

endmodule