`timescale 1ns / 1ps
module inst_memory(
input wire clk_i,
input wire rst_n_i,
input reg [13:0] addr_i,
//input reg [31:0] wdata_i,
//input reg wren_i,
output reg [31:0] rdata_o
    );
    reg [31:0] array [16383:0];
//    reg [6:0]  opcode;
//    reg [2:0]  func3;
//    reg [6:0]  func7;
//    reg [12:0] imm_i;
//    reg [4:0 ] imm_s_des ; // rd for s_type 
//    reg [6:0 ] imm_s_data;
//    assign opcode = wdata_i[6:0  ];
//    assign func3  = wdata_i[14:12];
//    assign func7  = wdata_i[31:25];
//    assign imm_i  = wdata_i[31:20];
//    assign imm_s_des = imm_i[4:0];
//    assign imm_s_data = imm_i[12:5];
    //read instruction memory

 initial begin
 $readmemh("inst_mem.mem",array);
 end
 always @(posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i) begin
  rdata_o <= '0;
  end
  else begin
  rdata_o <= array[addr_i];
  end
 end
endmodule
