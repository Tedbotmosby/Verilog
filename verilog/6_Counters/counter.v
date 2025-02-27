module counter(clk,en,rst,count,ring_counter);

input clk,rst,en;
output reg [3:0] count=0,ring_counter=4'b1000;

always@(posedge clk) begin
  if(rst) begin count <= 4'b0;ring_counter <= 4'b1000; end
  else if(en) begin
    count <= count +1;
    ring_counter <= {ring_counter[0],ring_counter[3:1]};
  end
end
endmodule

module counter_tb();
reg clk=0,en=0,rst=0;
wire [3:0] count,ring_counter;

counter uut(clk,en,rst,count,ring_counter);

initial begin
  #10
  rst=1;
  #10
  rst=0;
  en=1;
  #80
  rst=1;
end

initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("couter.vcd");
   $dumpvars(0,counter_tb);
end



endmodule
