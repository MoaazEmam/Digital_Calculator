module rem(
input [2:0]num1,
input [2:0]num2,
output reg divide_byzero_flag,
output reg [4:0]rem
);
reg [1:0]unsignednum1;
reg [1:0]unsignednum2;
always @(*) begin 
    unsignednum1=num1[1:0];
    unsignednum2=num2[1:0];

if(((unsignednum1) == (unsignednum2))||(unsignednum2==2'b01) ||(unsignednum1==2'b00))begin 
 rem=4'b0000;
 /*enters if both numbers are equal , then the result is zero,
  any number divided one gives remainder zero
  if the first number is zero the result is zero*/
end 
 else if (unsignednum1<unsignednum2) begin 
   rem=unsignednum1;
end else if (unsignednum1>unsignednum2) begin
   rem=unsignednum1-unsignednum2; 
end 
rem[4]=num1[2];
if (unsignednum2==2'b00) begin
     rem=4'b0000; 
   divide_byzero_flag=1'b1;
end else begin 
divide_byzero_flag=1'b0;
end
end 
endmodule