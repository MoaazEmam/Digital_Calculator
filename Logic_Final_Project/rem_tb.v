module rem_tb;
reg [2:0]num1;
reg [2:0]num2;
wire divide_byzero_flag;
wire [4:0]rem;


rem UUT(
    .num1(num1),
    .num2(num2),
    .divide_byzero_flag(divide_byzero_flag),
    .rem(rem)
);

integer i=0;
integer j=0;
integer file_rem;

initial begin
    //open rem file
    file_rem = $fopen("rem.txt", "w");
    for (i=0;i<8;i=i+1) begin 
        num1=i;
        for (j=0;j<8;j=j+1)begin 
            num2=j;
            #100
            //checking that the output of the module is correct when dividing by zero
            if (num2[1:0] == 0) begin //ignore the sign when zero
                if(divide_byzero_flag) begin
                    $fdisplay(file_rem,"Case %s%d / %s%d = %s%d math error (dividing by zero) passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                    $display("Case %s%d / %s%d = %s%d math error (dividing by zero) passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                end else begin
                    $fdisplay(file_rem,"Case %s%d / %s%d = %s%d math error (dividing by zero) failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                    $error("Case %s%d / %s%d = %s%d math error (dividing by zero) failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                end
            //checking the rest of the cases
            end else if ((num1[1:0] % num2[1:0] == rem[3:0]) && (num1[2] == rem[4]) ) begin
                $fdisplay(file_rem,"Case %s%d / %s%d = %s%d passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                $display("Case %s%d / %s%d = %s%d passed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
            end else begin
                $fdisplay(file_rem,"Case %s%d / %s%d = %s%d failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
                $error("Case %s%d / %s%d = %s%d failed",(num1[2] && num1[1:0] !== 0)?"-":"",num1[1:0],(num2[2] && num2[1:0] !== 0)?"-":"",num2[1:0],(rem[4] && rem[3:0] !== 0)?"-":"",rem[3:0]);
            end
        end 
    end
    //close rem file
    $fclose(file_rem);
    $finish();
 end
endmodule
