`timescale 1ns / 1ps
module regfile(
input wire clk_i,
input wire rst_n_i,
input reg [4:0] rs1_addr_i,
input reg [4:0] rs2_addr_i,
input reg [4:0] rsd_addr_i,
input reg [31:0] rsd_i,
input reg rd_wren_i,

output reg [31:0] rs1_data_o,
output reg [31:0] rs2_data_o
    );

 reg [31:0] array [0:31];
 initial begin
  $readmemh("regfile.mem",array,0,31);
 end
 integer i;
 always @( posedge clk_i or negedge rst_n_i) begin
 if(!rst_n_i) begin
 for (i=0; i<32; i= i+1 )begin
 array[i] = 32'd0;
 end
 end
 else if(rd_wren_i) begin
  array[rsd_addr_i] <= rsd_i;
 end
 else begin
 rs1_data_o <= array[rs1_addr_i];
 rs2_data_o <= array[rs2_addr_i];
  end
 end
endmodule
