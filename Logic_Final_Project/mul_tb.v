module mul_tb;
reg [2:0] num1;
reg [2:0] num2;
wire [4:0]num1_num2 ;

mul DUT(
.num1(num1),
.num2(num2),
.num1_num2(num1_num2)
);


integer i,j;
integer file_mult;
initial begin 
    //open mult file
    file_mult = $fopen("mult.txt", "w");
    for(i=0;i<8;i=i+1) begin
        for (j=0;j<8;j=j+1) begin
            num1=i;
            num2=j;
            #100;
            //check that the output of the module is correct
            if ((num1_num2[3:0] == num1[1:0] * num2[1:0]) && (num1_num2[4] == num1[2] ^ num2[2]))begin
                $fdisplay(file_mult,"Case %s%d * %s%d = %s%d passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(num1_num2[4] && num1_num2[3:0] !== 0)?"-":"",num1_num2[3:0]);  
                $display("Case %s%d * %s%d = %s%d passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(num1_num2[4] && num1_num2[3:0] !== 0)?"-":"",num1_num2[3:0]);
            end else begin
                $fdisplay(file_mult,"Case %s%d * %s%d = %s%d failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(num1_num2[4] && num1_num2[3:0] !== 0)?"-":"",num1_num2[3:0]);  
                $error("Case %s%d * %s%d = %s%d failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(num1_num2[4] && num1_num2[3:0] !== 0)?"-":"",num1_num2[3:0]);
            end
        end
    end
    //close mult file
    $fclose(file_mult);
    $finish();
 end
endmodule