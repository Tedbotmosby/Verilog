module Generic_Barrel_Shifter #(parameter WIDTH = 8)(in,out,shft);
input [WIDTH-1 : 0] in;
input [ ($clog2(WIDTH))-1 : 0] shft;
output [WIDTH-1:0] out;

wire [WIDTH-1:0] intermediate_stages [0:$clog2(WIDTH)-1];
genvar i;
generate
  for (i = 0; i < $clog2(WIDTH); i = i + 1) begin
    if(i==0) begin
      assign intermediate_stages[i] = shft[i] ? in << 1 : in;
    end
    else begin
      assign intermediate_stages[i] = shft[i] ? (intermediate_stages[i-1] << (1<<i)) : intermediate_stages[i-1];
      //do not use 2^i as it means XOR AAAAAARRRRRRRRRRRRHHHH
    end
  end
endgenerate

assign out = intermediate_stages[($clog2(WIDTH))-1];

endmodule

module tb_gen;
reg [7:0] in = 8'b1001_1101;
reg [2:0] shft =3'b111;
wire [7:0] out;
Generic_Barrel_Shifter #(.WIDTH(8)) uut (in,out,shft);

initial begin
   $dumpfile("Generic_Barrel_Shifter.vcd");
   $dumpvars(0,tb_gen);
end

endmodule
