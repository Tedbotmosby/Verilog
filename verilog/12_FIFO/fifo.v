module fifo(i_rd_en,i_wr_en,i_clk,i_rst,i_wr_data,o_rd_data,o_fifo_full,o_fifo_empty);
input i_clk,i_rst;
input i_rd_en,i_wr_en;
input [7:0] i_wr_data;
output [7:0] o_rd_data;
output o_fifo_full;
output o_fifo_empty;

reg [7:0] mem [0:15]; //16 entries of 8 bits each
reg [7:0] data_out=0;

reg [4:0] wr_ptr_q=0; // adding extra MSB bit to pointer to check if they are in the same iteration or not; to check for full and empty conditions
reg [4:0] rd_ptr_q=0;

wire [4:0] wr_ptr_d,rd_ptr_d;

assign wr_ptr_d = i_wr_en ? wr_ptr_q+1 : wr_ptr_q; //increment or hold
assign rd_ptr_d = i_rd_en ? rd_ptr_q+1 : rd_ptr_q;

always@(posedge i_clk) begin
  if(i_rst) begin
    wr_ptr_q<=0;
  end
  else if(i_wr_en) begin
    wr_ptr_q <= wr_ptr_d;
  end
end
always@(posedge i_clk) begin
  if(i_rst) begin
    rd_ptr_q<=0;
  end
  else if(i_rd_en) begin
    rd_ptr_q <= rd_ptr_d;
  end
end

always@(posedge i_clk) begin
  if(i_wr_en) begin
    mem[wr_ptr_q] <= i_wr_data;
  end
end
always@(posedge i_clk) begin
  if(i_rd_en) begin
    data_out <= mem[rd_ptr_q];
  end
end

assign o_rd_data = data_out;

assign o_fifo_full = wr_ptr_q[3:0] ==rd_ptr_q[3:0] && wr_ptr_q[4]!=rd_ptr_q[4];
assign o_fifo_empty = wr_ptr_q[4:0] ==rd_ptr_q[4:0];    //Beware when Fifo depths are not a power of 2
endmodule

module tb;
reg clk,rst;
reg i_wr_en;
reg i_rd_en;
reg [7:0] i_wr_data;

wire [7:0] o_rd_data;
wire fifo_full;
wire fifo_empty;

initial begin
    rst=1;
    #10
    rst=0;
    clk=0;
    i_wr_en=0;
    i_rd_en=0;
    #10
    i_wr_en=1;
    i_wr_data=8'd4;
    #10
    i_wr_en=0;
    #10
    i_rd_en=1;
    #10
    i_rd_en=0;
    #10
    i_wr_en=1;
    i_wr_data=8'd5;
    #10
    i_wr_data=8'd6;
    #10
    i_wr_data=8'd7;
    #10
    i_wr_data=8'd8;
    #10
    i_wr_data=8'd9;
    #10
    i_wr_data=8'd10;
    #10
    i_wr_data=8'd11;
    #10
    i_wr_data=8'd12;
    #10
    i_wr_data=8'd13;
    #10
    i_wr_data=8'd14;
    #10
    i_wr_data=8'd15;
    #10
    i_wr_data=8'd14;
    #10
    i_wr_data=8'd13;
    #10
    i_wr_data=8'd12;
    #10
    i_wr_data=8'd11;
    #10
    i_wr_data=8'd10;
    #10
    i_wr_data=8'd9;
    #10
    i_wr_data=8'd8;
    #10
    i_wr_data=8'd7;
    #10
    i_wr_en=0;
    #10
    i_rd_en=1;
    #40
    i_rd_en=0;



end

fifo uut(i_rd_en,i_wr_en,clk,rst,i_wr_data,o_rd_data,fifo_full,fifo_empty);
initial begin
   forever #5 clk = ~clk;
end
initial begin #400 $finish; end
initial begin
   $dumpfile("fifo.vcd");
   $dumpvars(0,tb);
end

endmodule
