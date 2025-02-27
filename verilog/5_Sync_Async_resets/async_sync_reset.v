module async_sync_reset(clk,rst,in,out_sync,out_async);

input clk,rst,in;
output reg out_sync=0,out_async=0;

//synchronous reset -----reset is active low
always@(posedge clk) begin
   if(!rst) out_sync<=1'b0;
   else out_sync <= in;
end
//asynchronous reset  -----reset is active low
always@(posedge clk or negedge rst) begin
   if(!rst) out_async<=1'b0;
   else out_async <= in;
end
endmodule
module async_sync_reset_tb();
reg clk=0,rst=1,in=0;
wire out_sync,out_async;

async_sync_reset uut(clk,rst,in,out_sync,out_async);
initial begin
  #10
  in=1;
  #20
  rst=0;
  #15
  rst=1;
end

initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("async_sync_reset.vcd");
   $dumpvars(0,async_sync_reset_tb);
end


endmodule
