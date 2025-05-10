module count_ones #(parameter W=4) (in,out);

input [W-1:0] in;
output [$clog2(W):0] out;

//The idea is to divide and conqueor, countones in left half, right half and add
// do the bisection until you have two bits left which is the basecase
// recursively add countones(left half) and countones(right half)
//In hardware logic gets duplicated/synthezised for all specific W

//recursive approach is not valid in verilog 2001, use generate for to replicate hardware

//count ones for two bit truth table which is adder acts as base case
// 0 0 0 0
// 0 1 1 0
// 1 0 1 0
// 1 1 0 1

//anyways, code written for for loop going through each iteration!!!
reg [$clog2(W+1):0] countones;
integer i;
always@(*) begin
  countones=0;
  for(i=0;i<W;i=i+1) begin
    countones = countones+in[i];
  end
end

assign out = countones;

endmodule
module tb;
reg [3:0] in=4'b1111;
wire [2:0] out;

count_ones #(.W(4)) uut (in,out);

initial begin
   $dumpfile("count_ones.vcd");
   $dumpvars(0,tb);
end

endmodule
