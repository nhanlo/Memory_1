`include"parameter.sv"
module data_memory(
input wire clk_i,
input wire rst_n_i,
input reg [11:0] addr_i,
input reg [31:0] wdata_i,
input reg wren_i,
input reg [2:0] func3,
output reg [31:0] rdata_o
    );
    reg [7:0] array [4095:0];    
    initial $readmemh("inst_mem.mem",array);
 // write data memory
 always @(posedge clk_i or negedge rst_n_i) begin
   if(!rst_n_i) begin
     array[addr_i] <= '0;
    end
    else if(wren_i) begin
          array[addr_i] = wdata_i;
         case(func3) 
         `sb: array[addr_i] = wdata_i[7:0]; // store 1 byte
         `lh: begin
          array[addr_i] = wdata_i[7:0]; //store a halfword
          array[addr_i-1] = wdata_i[15:8];
         end
         endcase
         end
   // read memory 
   else if(!wren_i) begin
   rdata_o = array[addr_i];
        case(func3) 
         `lb: begin
          rdata_o[7:0] = array[addr_i];
          rdata_o[31:8] = (rdata_o[7]) ? 24'hffffff : 24'd0;
          end
         `lh: begin
          rdata_o[7:0] = array[addr_i];
          rdata_o[15:8] = array[addr_i];
          rdata_o[31:16] = (rdata_o[15]) ? 16'hffff : 16'd0;         
         end
         `lbu: begin
          rdata_o[7:0] = array[addr_i];
          rdata_o[31:8] = 24'd0;
               end
         `lhu: begin
          rdata_o[7:0] = array[addr_i];
          rdata_o[15:8] = array[addr_i];
          rdata_o[31:16] = array[addr_i];
              end
        endcase
      end
   end
endmodule