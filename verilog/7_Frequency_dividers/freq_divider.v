module freq_divider(clk,outby2,outby3,outby4,outby5);

input clk;
output outby2,outby3,outby4,outby5;
reg [4:0] count=0;
reg [1:0] mod3_counter=0;//00,01,10,00,01,10
reg [2:0] mod5_counter=0;//000,001,010,011,100,000,001,010,011,100



always@(posedge clk) begin
      count <= count + 1;
      if(mod3_counter==2'b10) mod3_counter=2'b00;
      else mod3_counter <= mod3_counter+1;
end
always@(posedge clk) begin
      if(mod5_counter==3'b100) mod5_counter=3'b000;
      else mod5_counter <= mod5_counter+1;
end

assign outby2 = count[0];//1 cycle ON; 1 cycle OFF
assign outby4 = count[1];// 2 cycles ON; 2 cycles OFF

reg shiftforby3;//to make 1 cycle ON signal to 1.5 cycle ON signal ----shift it using negedge flipflop
reg shiftforby5;//

always@(negedge clk) begin
  shiftforby3 <= mod3_counter[1];
  shiftforby5 <= mod5_counter[1];// this bit goes like 0,0,1,1,0
end

assign outby3 =  mod3_counter[1] | shiftforby3; // 1.5cycle ON; 1.5 cycle OFF
assign outby5 = mod5_counter[1] | shiftforby5; //  2.5 ON; 2.5 OFF

endmodule
module freq_divider_tb;
reg clk=0;
wire outby2,outby3,outby4,outby5;

freq_divider uut(clk, outby2,outby3,outby4,outby5);

initial begin
   forever #5 clk = ~clk;
end
initial begin #200 $finish; end
initial begin
   $dumpfile("freq_divider.vcd");
   $dumpvars(0,freq_divider_tb);
end





endmodule
