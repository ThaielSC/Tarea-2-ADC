module computer (
    clk,
    alu_out_bus
);
  input clk;
  output [7:0] alu_out_bus;

  // Internal buses
  wire [ 7:0] pc_out_bus;
  wire [14:0] im_out_bus;
  wire [ 7:0] regA_out_bus;
  wire [ 7:0] regB_out_bus;
  wire [ 7:0] alu_in_a;
  wire [ 7:0] alu_in_b;
  wire [ 7:0] dm_read_data;
  wire [ 7:0] dm_write_data;
  wire [ 7:0] dm_address;

  // Control signals from decoder
  wire load_A, load_B, mem_write;
  wire [1:0] mux_A_sel;
  wire [1:0] mux_B_sel;
  wire [1:0] dm_addr_sel;
  wire [1:0] dm_write_data_sel;
  wire [3:0] alu_op;

  // Instruction parts
  wire [6:0] opcode = im_out_bus[14:8];
  wire [7:0] literal = im_out_bus[7:0];

  // 1. Program Counter
  pc PC (
      .clk(clk),
      .pc (pc_out_bus)
  );

  // 2. Instruction Memory
  instruction_memory IM (
      .address(pc_out_bus),
      .out(im_out_bus)
  );

  // 3. Decoder
  decoder DEC (
      .opcode(opcode),
      .load_A(load_A),
      .load_B(load_B),
      .mux_A_sel(mux_A_sel),
      .mux_B_sel(mux_B_sel),
      .alu_op(alu_op),
      .mem_write(mem_write),
      .dm_write_data_sel(dm_write_data_sel),
      .dm_addr_sel(dm_addr_sel)
  );

  // 4. Data Memory
  data_memory DM (
      .clk(clk),
      .address(dm_address),
      .write_data(dm_write_data),
      .write_enable(mem_write),
      .read_data(dm_read_data)
  );
  
  // Mux for DM write data
  reg [7:0] dm_write_data_mux_out;
  always @(*) begin
    case (dm_write_data_sel)
      2'b00:   dm_write_data_mux_out = regA_out_bus;
      2'b01:   dm_write_data_mux_out = regB_out_bus;
      2'b10:   dm_write_data_mux_out = alu_out_bus;
      default: dm_write_data_mux_out = 8'h00;
    endcase
  end
  assign dm_write_data = dm_write_data_mux_out;

  // Mux for DM address
  reg [7:0] dm_address_mux_out;
  always @(*) begin
    case (dm_addr_sel)
      2'b00:   dm_address_mux_out = literal;
      2'b01:   dm_address_mux_out = regA_out_bus;
      2'b10:   dm_address_mux_out = regB_out_bus;
      default: dm_address_mux_out = literal;
    endcase
  end
  assign dm_address = dm_address_mux_out;

  // 5. Registers
  register regA (
      .clk (clk),
      .data(alu_out_bus),
      .load(load_A),
      .out (regA_out_bus)
  );

  register regB (
      .clk (clk),
      .data(alu_out_bus),
      .load(load_B),
      .out (regB_out_bus)
  );

  // 6. ALU Input Multiplexers
  reg [7:0] mux_a_out;
  always @(*) begin
    case (mux_A_sel)
      2'b00:   mux_a_out = regA_out_bus;
      2'b01:   mux_a_out = regB_out_bus;
      2'b10:   mux_a_out = dm_read_data;
      default: mux_a_out = 8'h00;
    endcase
  end
  assign alu_in_a = mux_a_out;

  // Mux for ALU input B
  reg [7:0] mux_b_out;
  always @(*) begin
    case (mux_B_sel)
      2'b00:   mux_b_out = regA_out_bus;
      2'b01:   mux_b_out = regB_out_bus;
      2'b10:   mux_b_out = literal;
      2'b11:   mux_b_out = dm_read_data;
      default: mux_b_out = 8'h00;
    endcase
  end
  assign alu_in_b = mux_b_out;

  // 7. ALU
  alu ALU (
      .a  (alu_in_a),
      .b  (alu_in_b),
      .s  (alu_op),
      .out(alu_out_bus)
  );

endmodule
