module alu (
    a,
    b,
    s,
    out
);
  input [7:0] a, b;
  input [3:0] s;
  output [7:0] out;
  reg [7:0] out;

  always @(a, b, s) begin
    case (s)
      4'h0:    out = a + b;  // ADD
      4'h1:    out = a - b;  // SUB
      4'h2:    out = a & b;  // AND
      4'h3:    out = a | b;  // OR
      4'h4:    out = a ^ b;  // XOR
      4'h5:    out = ~a;  // NOT_A
      4'h6:    out = a << 1;  // SHL_A
      4'h7:    out = a >> 1;  // SHR_A
      4'h8:    out = a + 1;  // INC_A
      4'h9:    out = b;  // PASS_B (for MOV)
      4'ha:    out = a;  // PASS_A (for MOV)
      4'hb:    out = ~b;  // NOT_B
      default: out = 8'h00;
    endcase
  end
endmodule
