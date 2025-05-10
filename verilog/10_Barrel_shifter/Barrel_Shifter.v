module Barrel_Shifter(in,shft,out);
  input [7:0] in;
  input [2:0] shft;
  output [7:0] out;

  wire [7:0] in1,in2,in3;
  assign in1 = shft[2]?{in[3:0],4'b0000}: in[7:0];
  assign in2 = shft[1]?{in1[5:0],2'b00} : in1[7:0];
  assign in3 = shft[0]?{in2[6:0],1'b0}  : in2[7:0];

  assign out = in3;


endmodule

module tb;
reg [7:0] in=8'b1001_1001;
reg [2:0] shft=3'b100;
wire [7:0] out;

Barrel_Shifter uut(in,shft,out);

initial begin
   $dumpfile("Barrel_Shifter.vcd");
   $dumpvars(0,tb);
end


endmodule
