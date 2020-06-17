module neuron_tb;
reg clk, neuron_1, neuron_2, neuron_3;
reg [39:0] in1 = 40'b1010101010101010101010101010101010101010;
reg [39:0] in2 = 40'b0101010101010101010101010101010101010101;
reg [39:0] in3 = 40'b0000011000001100000110000011000001100000;
wire neuron_7;
wire neuron_8;
  
spiking_network U0 (
  .clk (clk),
  .neuron_1 (neuron_1),
  .neuron_2 (neuron_2),
  .neuron_3 (neuron_3),
  .neuron_7 (neuron_7),
  .neuron_8 (neuron_8)
);
  
initial begin
  $dumpfile("fire_sequence_1.vcd");
  $dumpvars;
  $display("\t\ttime,\tclk,\tneuron_1,\tneuron_2,\tneuron_3, \tneuron_7, \tneuron_8");
  $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clk, neuron_1, neuron_2, neuron_3, neuron_7, neuron_8);
#500 $finish;
end
  
initial begin
clk = 0;
neuron_1 = 0;
neuron_2 = 0;
neuron_3 = 0;
end
  
always
#5 clk = !clk;
 
integer i = 39;
always @(posedge clk) begin
  if (i >= 0) begin
	neuron_1 = in1[i];
	neuron_2 = in2[i];
	neuron_3 = in3[i];
	i <= i - 1;
  end
  if (i < 0) begin
    neuron_1 = 0;
    neuron_2 = 0;
    neuron_3 = 0;
  end
end
  
endmodule