module Ripple_carry_adder(a,b,out);

input [3:0] a,b;
output [4:0] out;

wire c[3:0];

assign out[0] = a[0]^b[0];
assign c[0]   = a[0] & b[0]; // if both are ones,carry is generated
assign out[1] = a[1] ^ b[1] ^ c[0];
assign c[1]   = (a[1] & b[1]) + (b[1] & c[0]) + (a[1] & c[0]);
assign out[2] = a[2] ^ b[2] ^ c[1];
assign c[2]   = (a[2] & b[2]) + (b[2] & c[1]) + (a[2] & c[1]);
assign out[3] = a[3] ^ b[3] ^ c[2];
assign c[3]   = (a[3] & b[3]) + (b[3] & c[2]) + (a[3] & c[2]);
assign out[4] = c[3];

endmodule
module Ripple_carry_adder_tb();
reg [3:0] a,b;
wire [4:0] out;
Ripple_carry_adder uut(a,b,out);
// verifying 4 bit adder, 16X16 possible inputs=256
integer i,j;

initial begin
   for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
         #5
         a=i;b=j;
      end
   end
end

initial $monitor("time = %t,a= %d,b=%d,out=%d",$time,a,b,out);
initial begin
   #500 $finish;
end
endmodule
