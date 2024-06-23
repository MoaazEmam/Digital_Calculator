module add_sub_tb;
    reg signed [2:0] a;
    reg signed  [2:0] b;
    reg addsub;
    wire [2:0] sf;
    wire sign;
 
add_sub DUT(
    .a1(a),
    .b1(b),
    .Add_Sub(addsub),
    .sf(sf),
    .sign(sign)
);
integer signed i,j;
integer file_add,file_sub;

//to check the output of the module
reg [2:0] magnitude;
reg sign_test;


initial begin
    //open add file
    file_add = $fopen("add.txt", "w");
    for (i = 0; i < 8; i = i + 1) begin
        for (j = 0; j < 8; j = j + 1) begin
            a = i;
            b = j;
            //check the module for the addition operation
            addsub = 0;
            //if same sign add
            if(a[2] == b[2])begin
                sign_test = a[2];
                magnitude = a[1:0] + b[1:0];
            //if a > b then subtract b from a and the sign is the same as a
            end else if (a[1:0] > b[1:0]) begin
                sign_test = a[2];
                magnitude = a[1:0] - b[1:0];
            //if b > a then subtract a from b and the sign is the same as b
            end else begin
                sign_test = b[2];
                magnitude = b[1:0] - a[1:0];
            end
            #100;
            if (sf == magnitude && (sign == sign_test || magnitude == 0)) begin
                //writing in add file
                $fdisplay(file_add,"Case %s%d + %s%d = %s%d passed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
                //displaying in the console
                $display("Case %s%d + %s%d = %s%d passed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
            end else begin
                //writing in add file
                $fdisplay(file_add,"Case %s%d + %s%d = %s%d failed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
                //displaying in the console
                $error("Case %s%d + %s%d = %s%d failed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
            end
        end
    end
    //close add file
    $fclose(file_add);

    //open sub file
    file_sub = $fopen("sub.txt", "w");
    for (i = 0; i < 8; i = i + 1) begin
        for (j = 0; j < 8; j = j + 1) begin
            a = i;
            b = j;
            //testing the module for the subtraction operation
            addsub = 1;
            //if different sign add and the sign is that of a (since the - will make sign of b same as a)
            if(a[2] != b[2])begin
                sign_test = a[2];
                magnitude = a[1:0] + b[1:0];
            //if a > b then subtract b from a and the sign is the same as a
            end else if (a[1:0] > b[1:0]) begin
                sign_test = a[2];
                magnitude = a[1:0] - b[1:0];
            //if b > a then subtract a from b and the sign is the opposite of b (due to -)
            end else begin
                sign_test = !b[2];
                magnitude = b[1:0] - a[1:0];
            end
            #100;
            if (sf == magnitude && (sign == sign_test || magnitude == 0)) begin
                //writing in sub file
                $fdisplay(file_sub,"Case %s%d - %s%d = %s%d passed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
                //displaying in the console
                $display("Case %s%d - %s%d = %s%d passed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
            end else begin
                //writing in sub file
                $fdisplay(file_sub,"Case %s%d - %s%d = %s%d failed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
                //displaying in the console
                $error("Case %s%d - %s%d = %s%d failed",(a[2] && a[1:0] !== 0)?"-":"",a[1:0],(b[2] && b[1:0] !== 0)?"-":"",b[1:0],(sign && sf !== 0)?"-":"",sf);
            end
        end
    end
    //close sub file
    $fclose(file_sub);

    $finish();
end
endmodule