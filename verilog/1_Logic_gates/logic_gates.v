module logic_gates(a,b,out_and,out_or,out_xor);
input a,b;
output out_and,out_or,out_xor;

assign out_and = a & b;
assign out_or  = a | b;
assign out_xor = a ^ b;

endmodule


module logic_gates_tb();
reg a,b;
wire and_out,or_out,xor_out;

logic_gates uut(.a(a),.b(b),.out_and(and_out),.out_or(or_out),.out_xor(xor_out));

initial begin
   a=1'b0;
   b=1'b0;
   #5
   a=1'b1;
   b=1'b1;
   #5
   a=1'b1;
   b=1'b0;
   #5
   a=1'b0;
   b=1'b1;
end
initial  $monitor("time=%t ; a=%b, b=%b , and_out = %b, or_out = %b, xor_out = %b",$time,a,b,and_out,or_out,xor_out);
initial begin
   $dumpfile("logic_gates.vcd");
   $dumpvars(0,logic_gates_tb);
end
initial begin
   #50 $finish;
end

endmodule
