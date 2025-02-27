module moore_1011_detector(clk,rst,in,out);
input clk,in,rst;
output out;

parameter s0    = 3'b000;
parameter s1    = 3'b001;
parameter s10   = 3'b010;
parameter s101  = 3'b011;
parameter s1011 = 3'b101;


reg [2:0] curr_state,next_state;

always@(posedge clk or posedge rst) begin
  if(rst) curr_state <= s0;
  else curr_state <= next_state;
end

always@(*) begin
case(curr_state)
   s0: begin
          if(in) next_state<=s1;
          else next_state<= s0;
       end
   s1: begin
          if(in) next_state<=s1;
          else next_state<= s10;
       end
   s10: begin
          if(in) next_state<=s101;
          else next_state<= s0;
       end
   s101: begin
          if(in) next_state<=s1011;
          else next_state<= s10;
       end
   s1011: begin
          if(in) next_state<=s1;
          else next_state<= s10;
       end
    default: next_state <= s0;
endcase
end

assign out = (curr_state==s1011)?1:0;//if output is needed in the curr cycle,next_state should be used instead of curr_state
endmodule

module tb;
reg clk=1,in=0,rst=1;
wire out;

moore_1011_detector uut(clk,rst,in,out);
initial begin
   in =0;
   #10
   rst=0;
   in =0;
   #10
   in =1;
   #10
   in =0;
   #10
   in =1;
   #10
   in =0;
   #10
   in =1;
   #10
   in =1;
   #10
   in=0;
end
initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("moore_1011_detector.vcd");
   $dumpvars(0,tb);
end


endmodule
