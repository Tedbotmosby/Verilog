module FF_latch(clk,in,data_latch,data_ff);
input clk;
input [3:0] in;
output reg [3:0] data_latch=4'b0;
output reg [3:0] data_ff=4'b0;


//latch code -----input is copied when clk is high
always@(*) begin
   if(clk) begin
      data_latch <= in;
   end
end
//FF code-----input sampled on every clock edge
always@(posedge clk) begin
   data_ff <= in;
end
endmodule

module FF_latch_tb();
reg clk=0;
reg [3:0] in=4'b0;
wire [3:0] data_latch;
wire [3:0] data_ff;



FF_latch uut(clk,in,data_latch,data_ff);
initial begin
  #10
  in = 4'd9;
  #8
  in = 4'd7;
  #20
  in = 4'd9;
  #10
  in = 4'd0;
end

initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("FF_latch.vcd");
   $dumpvars(0,FF_latch_tb);
end


endmodule
