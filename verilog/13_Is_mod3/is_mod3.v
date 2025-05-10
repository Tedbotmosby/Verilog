module is_mod3(rst,clk,in,out);
input rst,clk;
input in;
output out;

parameter  s0=2'b00;
parameter  s1=2'b01;
parameter  s2=2'b10;


reg [1:0] curr_state,next_state=0;

always@(posedge clk) begin
  if(rst) curr_state <= s0;
  else    curr_state <= next_state;
end


always@(curr_state or in) begin
  next_state = curr_state;  // Default to avoid inferred latches
  if(curr_state==s0) begin
    if(in) next_state = s1;
    else   next_state = s0;
  end
  else if(curr_state==s1) begin
    if(in) next_state = s0;
    else   next_state = s2;
  end
  else if(curr_state==s2) begin
    if(in) next_state = s2;
    else   next_state = s1;
  end
end

assign out = (curr_state==s0 && !rst);
endmodule


module tb;
reg clk,rst,in;
wire out;

initial begin
  rst=1;clk=0;in=0;
  #15 // values to change at posedge
  rst=0;
  #10
  in=1;
  #10
  in=0;
  #10
  in=1;
  #10
  in=0;
  #10
  in=0;
  #10
  in=0;
  #10
  in=1;
  #10
  in=0;


end


is_mod3 uut(rst,clk,in,out);

initial begin
   forever #5 clk = ~clk;
end
initial begin #400 $finish; end
initial begin
   $dumpfile("is_mod3.vcd");
   $dumpvars(0,tb);
end

endmodule
