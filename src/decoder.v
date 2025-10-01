module decoder (
    opcode,
    load_A,
    load_B,
    mux_A_sel,
    mux_B_sel,
    alu_op
);
  input [6:0] opcode;
  output reg load_A, load_B, mux_A_sel;
  output reg [1:0] mux_B_sel;
  output reg [3:0] alu_op;

  always @(*) begin
    // Default values (NOP)
    load_A    = 0;
    load_B    = 0;
    mux_A_sel = 0;
    mux_B_sel = 0;
    alu_op    = 4'hF;

    case (opcode)
      // MOV
      7'b0000000: begin
        load_A    = 1;
        alu_op    = 4'h9;
        mux_B_sel = 2'b01;
      end  // MOV A,B (A<-B)
      7'b0000001: begin
        load_B    = 1;
        alu_op    = 4'ha;
        mux_A_sel = 0;
      end  // MOV B,A (B<-A)
      7'b0000010: begin
        load_A    = 1;
        alu_op    = 4'h9;
        mux_B_sel = 2'b10;
      end  // MOV A,Lit
      7'b0000011: begin
        load_B    = 1;
        alu_op    = 4'h9;
        mux_B_sel = 2'b10;
      end  // MOV B,Lit
      // ADD
      7'b0000100: begin
        load_A    = 1;
        alu_op    = 4'h0;
        mux_A_sel = 0;
        mux_B_sel = 2'b01;
      end  // ADD A,B (A<-A+B)
      7'b0000101: begin
        load_B    = 1;
        alu_op    = 4'h0;
        mux_A_sel = 1;
        mux_B_sel = 2'b00;
      end  // ADD B,A (B<-B+A)
      7'b0000110: begin
        load_A    = 1;
        alu_op    = 4'h0;
        mux_A_sel = 0;
        mux_B_sel = 2'b10;
      end  // ADD A,Lit
      7'b0000111: begin
        load_B    = 1;
        alu_op    = 4'h0;
        mux_A_sel = 1;
        mux_B_sel = 2'b10;
      end  // ADD B,Lit
      // SUB
      7'b0001000: begin
        load_A    = 1;
        alu_op    = 4'h1;
        mux_A_sel = 0;
        mux_B_sel = 2'b01;
      end  // SUB A,B (A<-A-B)
      7'b0001001: begin
        load_B    = 1;
        alu_op    = 4'h1;
        mux_A_sel = 1;
        mux_B_sel = 2'b00;
      end  // SUB B,A (B<-B-A)
      7'b0001010: begin
        load_A    = 1;
        alu_op    = 4'h1;
        mux_A_sel = 0;
        mux_B_sel = 2'b10;
      end  // SUB A,Lit
      7'b0001011: begin
        load_B    = 1;
        alu_op    = 4'h1;
        mux_A_sel = 1;
        mux_B_sel = 2'b10;
      end  // SUB B,Lit
      // AND
      7'b0001100: begin
        load_A    = 1;
        alu_op    = 4'h2;
        mux_A_sel = 0;
        mux_B_sel = 2'b01;
      end  // AND A,B
      7'b0001101: begin
        load_B    = 1;
        alu_op    = 4'h2;
        mux_A_sel = 1;
        mux_B_sel = 2'b00;
      end  // AND B,A
      7'b0001110: begin
        load_A    = 1;
        alu_op    = 4'h2;
        mux_A_sel = 0;
        mux_B_sel = 2'b10;
      end  // AND A,Lit
      7'b0001111: begin
        load_B    = 1;
        alu_op    = 4'h2;
        mux_A_sel = 1;
        mux_B_sel = 2'b10;
      end  // AND B,Lit
      // OR
      7'b0010000: begin
        load_A    = 1;
        alu_op    = 4'h3;
        mux_A_sel = 0;
        mux_B_sel = 2'b01;
      end  // OR A,B
      7'b0010001: begin
        load_B    = 1;
        alu_op    = 4'h3;
        mux_A_sel = 1;
        mux_B_sel = 2'b00;
      end  // OR B,A
      7'b0010010: begin
        load_A    = 1;
        alu_op    = 4'h3;
        mux_A_sel = 0;
        mux_B_sel = 2'b10;
      end  // OR A,Lit
      7'b0010011: begin
        load_B    = 1;
        alu_op    = 4'h3;
        mux_A_sel = 1;
        mux_B_sel = 2'b10;
      end  // OR B,Lit
      // NOT
      7'b0010100: begin
        load_A    = 1;
        alu_op    = 4'h5;
        mux_A_sel = 0;
      end  // NOT A,A (A<-~A)
      7'b0010101: begin
        load_A    = 1;
        alu_op    = 4'hb;
        mux_B_sel = 2'b01;
      end  // NOT A,B (A<-~B)
      7'b0010110: begin
        load_B    = 1;
        alu_op    = 4'ha;
        mux_A_sel = 0;
        alu_op    = 4'hb;
        mux_B_sel = 2'b00;
      end  // NOT B,A (B<-~A)
      7'b0010111: begin
        load_B    = 1;
        alu_op    = 4'h5;
        mux_A_sel = 1;
      end  // NOT B,B (B<-~B)
      // XOR
      7'b0011000: begin
        load_A    = 1;
        alu_op    = 4'h4;
        mux_A_sel = 0;
        mux_B_sel = 2'b01;
      end  // XOR A,B
      7'b0011001: begin
        load_B    = 1;
        alu_op    = 4'h4;
        mux_A_sel = 1;
        mux_B_sel = 2'b00;
      end  // XOR B,A
      7'b0011010: begin
        load_A    = 1;
        alu_op    = 4'h4;
        mux_A_sel = 0;
        mux_B_sel = 2'b10;
      end  // XOR A,Lit
      7'b0011011: begin
        load_B    = 1;
        alu_op    = 4'h4;
        mux_A_sel = 1;
        mux_B_sel = 2'b10;
      end  // XOR B,Lit
      // SHL
      7'b0011100: begin
        load_A    = 1;
        alu_op    = 4'h6;
        mux_A_sel = 0;
      end  // SHL A,A
      7'b0011101: begin
        load_A    = 1;
        alu_op    = 4'h6;
        mux_A_sel = 1;
      end  // SHL A,B (A<-B<<1)
      7'b0011110: begin
        load_B    = 1;
        alu_op    = 4'h6;
        mux_A_sel = 0;
      end  // SHL B,A (B<-A<<1)
      7'b0011111: begin
        load_B    = 1;
        alu_op    = 4'h6;
        mux_A_sel = 1;
      end  // SHL B,B
      // SHR
      7'b0100000: begin
        load_A    = 1;
        alu_op    = 4'h7;
        mux_A_sel = 0;
      end  // SHR A,A
      7'b0100001: begin
        load_A    = 1;
        alu_op    = 4'h7;
        mux_A_sel = 1;
      end  // SHR A,B (A<-B>>1)
      7'b0100010: begin
        load_B    = 1;
        alu_op    = 4'h7;
        mux_A_sel = 0;
      end  // SHR B,A (B<-A>>1)
      7'b0100011: begin
        load_B    = 1;
        alu_op    = 4'h7;
        mux_A_sel = 1;
      end  // SHR B,B
      // INC
      7'b0100100: begin
        load_B    = 1;
        alu_op    = 4'h8;
        mux_A_sel = 1;
      end  // INC B (B<-B+1)
      default: ;  // NOP
    endcase
  end
endmodule
