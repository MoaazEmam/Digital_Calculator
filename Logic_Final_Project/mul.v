module mul(
input [2:0]num1,
input [2:0]num2,
output reg [4:0]num1_num2
);
reg [2:0]unsignednum1;
always @(*)begin
  num1_num2=5'b00000;
  
if(num2[0]==1'b1) begin 
  num1_num2=num1[1:0];
end if(num2[1]==1'b1) begin 
unsignednum1=num1<<1;
  num1_num2=num1_num2+unsignednum1;
end else if(num2[1:0]==2'b00) begin
  num1_num2=5'b00000;
end if(num1[2]^num2[2])begin 
num1_num2[4]=1'b1;
end 
end

endmodule