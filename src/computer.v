module computer(clk, alu_out_bus);
   input        clk;
   output [7:0] alu_out_bus;

   // Internal buses
   wire [3:0]   pc_out_bus;
   wire [14:0]  im_out_bus;
   wire [7:0]   regA_out_bus;
   wire [7:0]   regB_out_bus;
   wire [7:0]   alu_in_a;
   wire [7:0]   alu_in_b;

   // Control signals from decoder
   wire         load_A, load_B, mux_A_sel;
   wire [1:0]   mux_B_sel;
   wire [3:0]   alu_op;

   // Instruction parts
   wire [6:0]   opcode = im_out_bus[14:8];
   wire [7:0]   literal = im_out_bus[7:0];

   // 1. Program Counter
   pc PC(.clk(clk),
         .pc(pc_out_bus));

   // 2. Instruction Memory
   instruction_memory IM(.address(pc_out_bus),
                         .out(im_out_bus));

   // 3. Decoder
   decoder DEC(.opcode(opcode),
               .load_A(load_A),
               .load_B(load_B),
               .mux_A_sel(mux_A_sel),
               .mux_B_sel(mux_B_sel),
               .alu_op(alu_op));

   // 4. Registers
   register regA(.clk(clk),
                 .data(alu_out_bus),
                 .load(load_A),
                 .out(regA_out_bus));

   register regB(.clk(clk),
                 .data(alu_out_bus),
                 .load(load_B),
                 .out(regB_out_bus));

   // 5. ALU Input Multiplexers
   assign alu_in_a = mux_A_sel ? regB_out_bus : regA_out_bus;

   // Mux for ALU input B
   reg [7:0]    mux_b_out;
   always @(*) begin
      case(mux_B_sel)
         2'b00: mux_b_out = regA_out_bus;
         2'b01: mux_b_out = regB_out_bus;
         2'b10: mux_b_out = literal;
         default: mux_b_out = 8'h00;
      endcase
   end
   assign alu_in_b = mux_b_out;

   // 6. ALU
   alu ALU(.a(alu_in_a),
           .b(alu_in_b),
           .s(alu_op),
           .out(alu_out_bus));

endmodule