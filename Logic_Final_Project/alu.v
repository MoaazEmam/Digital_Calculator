module alu(
    input [2:0] A,
    input [2:0] B,
    input [1:0] S,
    output reg [3:0] R,
    output reg SF,
    output reg ZF,
    output reg DZF
);

 wire tempresultAS [3:0];
 wire tempsignAS;
add_sub ADDSUB(
    .a1(A),
    .b1(B),
    .Add_Sub(S[0]),
    .sf(tempresultAS),
    .sign(tempsignAS)
);

wire tempresultM [4:0];
mul MULTIPLY(
    .num1(A),
    .num2(B),
    .num1_num2(tempresultM)
);

wire tempresultR[4:0];
wire tempDZF;
rem REMAINDER(
    .num1(A),
    .num2(B),
    .divide_byzero_flag(tempDZF),
    .rem(tempresult)
); 

always@(*) begin
    case(S)
        2'b00 : begin
            assign R = tempresultAS;
            assign SF = tempsignAS;
            assign DZF = 0;
        end
        2'b01 : begin
            assign R = tempresultAS;
            assign SF = tempsignAS;
            assign DZF = 0;
        end
        2'b10 : begin
            assign R = tempresultM[3:0];
            assign SF = tempresultM[4];
            assign DZF = 0;
        end
        2'b11 : begin
            assign R = tempresultR[3:0];
            assign SF = tempresultR[4];
            assign DZF = tempDZF;
        end
    endcase
    if(R==4'b0000) begin 
        assign ZF = 1;
    end
    else begin 
        assign ZF = 0;
    end
end

endmodule