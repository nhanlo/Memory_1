module lsu(
input wire        clk_i,
input wire        rst_n_i,
input wire [15:0] addr_i,
input reg  [31:0] st_data,
input wire        st_en,
input  reg [17:0] io_sw,
output reg [31:0] ld_data,
output reg [31:0] io_lcd,
output reg [31:0] io_ledg,
output reg [31:0] io_ledr,
output reg [31:0]  io_hex0,
output reg [31:0]  io_hex1,
output reg [31:0]  io_hex2,
output reg [31:0]  io_hex3,
output reg [31:0]  io_hex4,
output reg [31:0]  io_hex5,
output reg [31:0]  io_hex6,
output reg [31:0]  io_hex7
    );
    reg [31:0] array [65355:0];
    reg [1:0] addr_sel;
    
    assign addr_sel = (addr_i <= 16'h03ff) ? 2'b01 : 0;
    assign addr_sel = (16'h0400 <= addr_i <= 16'h04FF) ? 2'b10 : 0;
    assign addr_sel = (16'h0500 <= addr_i <= 16'h05FF) ? 2'b11 : 0;     
  initial $readmemh("inst_mem.mem",array);
//    assign addr_sel = addr_i;
  always @( posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i) begin
  io_hex0 <= '0;
  io_hex1 <= '0;
  io_hex2 <= '0;
  io_hex3 <= '0;
  io_hex4 <= '0;
  io_hex5 <= '0;
  io_hex6 <= '0;
  io_hex7 <= '0;
  io_lcd <=  '0;
  io_ledg <= '0;
  io_ledr <= '0;
  ld_data <= '0;
  end
   else if(!st_en) begin
  if(addr_sel == 2'b01) begin
   ld_data <= array[addr_i];
   end
   else if(addr_i >= 16'h0400 && addr_i <= 16'h04FF) begin
   ld_data <= array[addr_i];
      case(addr_i[15:0])
      16'h04A0: io_lcd  = array[addr_i];
      16'h0490: io_ledg = array[addr_i];
      16'h0480: io_ledr = array[addr_i];
      16'h0470: io_hex7 = array[addr_i];
      16'h0460: io_hex6 = array[addr_i];
      16'h0450: io_hex5 = array[addr_i];
      16'h0440: io_hex4 = array[addr_i];
      16'h0430: io_hex3 = array[addr_i];
      16'h0420: io_hex2 = array[addr_i];
      16'h0410: io_hex1 = array[addr_i];
      16'h0400: io_hex0 = array[addr_i];
      endcase
   end
    else if(addr_sel == 2'b11) begin
     ld_data <= {14'b0000_0000_0000_0000_00,io_sw};
     io_hex0       <= '0;
     io_hex1       <= '0;
     io_hex2       <= '0;
     io_hex3       <= '0;
     io_hex4       <= '0;
     io_hex5       <= '0;
     io_hex6       <= '0;
     io_hex7       <= '0;
     io_lcd        <= '0;
     io_ledg       <= '0;
     io_ledr       <= '0;
    end
    else if(addr_i >= 16'h0600 ) begin
     io_hex0 <= '0;
     io_hex1 <= '0;
     io_hex2 <= '0;
     io_hex3 <= '0;
     io_hex4 <= '0;
     io_hex5 <= '0;
     io_hex6 <= '0;
     io_hex7 <= '0;
     io_lcd  <= '0;
     io_ledg <= '0;
     io_ledr <= '0;     
     end
   end 
 end

 always @(posedge clk_i or negedge rst_n_i) begin
  if(!rst_n_i) begin
   array[addr_i] <= '0;
  end
  else if(st_en) begin
    if(addr_sel == 2'b01) begin
      array[addr_i] <= st_data;
     end
    else if(16'h0400 <= addr_i <= 16'h04FF) begin
      array[addr_i] <= st_data;
    end
    else if(addr_sel ==  2'b11) begin
     array[addr_i] <= {14'b0000_0000_0000_0000_00,io_sw};
    end
   end
 end 
 
 
endmodule
