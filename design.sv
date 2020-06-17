`timescale 1ns/1ns

module spike_neuron (clk, neuron_in1, neuron_in2, neuron_in3,
                     w3i, w2i, w1i, neuron_out);
  
  // Neuron Inputs Declaration
  input wire [2:0] w1i;
  input wire [2:0] w2i;
  input wire [2:0] w3i;
  input wire clk;
  input wire neuron_in1;
  input wire neuron_in2;
  input wire neuron_in3;
  
  //Neuron Outputs Declaration
  output neuron_out;
  
  // Neuron Constants
  reg [4:0] V_rest = 6;
  reg [4:0] V_leak = 1;
  reg K_syn = 1;
  reg [4:0] V_thresh = 14;
  reg [4:0] V_i = 6;
  reg neuron_i_reg = 0;
  
  // Neuron Dynamics
  always @(posedge clk) begin
    neuron_i_reg = 0; 
    V_i = V_i + K_syn * (w1i*neuron_in1 + w2i*neuron_in2 + w3i*neuron_in3) - V_leak;
    if (V_i >= V_thresh) begin
      V_i = V_rest;
      neuron_i_reg = 1;
    end
    if (V_i < V_rest) begin
      V_i = V_rest;
    end
  end
  assign neuron_out = neuron_i_reg;
endmodule

module spiking_network (clk, neuron_1, neuron_2, neuron_3, neuron_7,
                        neuron_8);
  
  // Network Inputs Declaration
  input wire clk;
  input wire neuron_1;
  input wire neuron_2;
  input wire neuron_3;
  
  //Neuron Outputs Declaration
  output wire neuron_7;
  output wire neuron_8;
  
  // Network Synaptic Weights
  reg [2:0] w14 = 3;
  reg [2:0] w15 = 1;
  reg [2:0] w16 = 4;
  reg [2:0] w24 = 3;
  reg [2:0] w25 = 2;
  reg [2:0] w26 = 3;
  reg [2:0] w34 = 2;
  reg [2:0] w35 = 3;
  reg [2:0] w36 = 4;
  reg [2:0] w47 = 3;
  reg [2:0] w48 = 2;
  reg [2:0] w57 = 2;
  reg [2:0] w58 = 4;
  reg [2:0] w67 = 3;
  reg [2:0] w68 = 2;
  
  // Hidden Layer Neurons
  wire neuron_4;
  wire neuron_5;
  wire neuron_6;
  
  spike_neuron neuron4 (
    .clk (clk),
    .neuron_in1 (neuron_1),
    .neuron_in2 (neuron_2),
    .neuron_in3 (neuron_3),
    .w1i (w14),
    .w2i (w24),
    .w3i (w34),
    .neuron_out (neuron_4)
  );
  
  spike_neuron neuron5 (
    .clk (clk),
    .neuron_in1 (neuron_1),
    .neuron_in2 (neuron_2),
    .neuron_in3 (neuron_3),
    .w1i (w15),
    .w2i (w25),
    .w3i (w35),
    .neuron_out (neuron_5)
  );
  
  spike_neuron neuron6 (
    .clk (clk),
    .neuron_in1 (neuron_1),
    .neuron_in2 (neuron_2),
    .neuron_in3 (neuron_3),
    .w1i (w16),
    .w2i (w26),
    .w3i (w36),
    .neuron_out (neuron_6)
  );
  
  spike_neuron neuron7 (
    .clk (clk),
    .neuron_in1 (neuron_4),
    .neuron_in2 (neuron_5),
    .neuron_in3 (neuron_6),
    .w1i (w47),
    .w2i (w57),
    .w3i (w67),
    .neuron_out (neuron_7)
  );
  
  spike_neuron neuron8 (
    .clk (clk),
    .neuron_in1 (neuron_4),
    .neuron_in2 (neuron_5),
    .neuron_in3 (neuron_6),
    .w1i (w48),
    .w2i (w58),
    .w3i (w68),
    .neuron_out (neuron_8)
  );
  
endmodule