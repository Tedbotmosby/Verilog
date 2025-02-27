module edgedetector(clk,in,riseedge,falledge,anyedge);
input in,clk;

output riseedge,falledge,anyedge;
reg in_delayed=0;

always@(posedge clk) begin
      in_delayed <= in;
end

assign riseedge = (~in_delayed) & in;
assign falledge = in_delayed & (~in);

assign anyedge = in_delayed ^ in;


endmodule
module edgedetector_tb;
reg clk=0;
reg in =0;
wire riseedge,falledge,anyedge;

edgedetector uut(clk,in,riseedge,falledge,anyedge);

initial begin
   #10
   in=1;
   #30;
   in=0;
end

initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("edgedetector.vcd");
   $dumpvars(0,edgedetector_tb);
end


endmodule
