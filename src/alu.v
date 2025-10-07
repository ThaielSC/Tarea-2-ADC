module alu (a,
            b,
            s,
            out,
            zero_flag,
            negative_flag,
            carry_flag,
            overflow_flag);
    input [7:0] a, b;
    input [3:0] s;
    output reg [7:0] out;
    output reg zero_flag, negative_flag, carry_flag, overflow_flag;
    
    reg co;  // Internal carry_out
    
    always @(a, b, s) begin
        // Default flag values for logical operations
        carry_flag    = 1'b0;
        overflow_flag = 1'b0;
        
        case (s)
            4'h0: begin  // ADD
                {co, out}  = a + b;
                carry_flag = co;
                overflow_flag = ($signed(a) > 0 && $signed(b) > 0 && $signed(out) < 0) ||
                ($signed(a) < 0 && $signed(b) < 0 && $signed(out) > 0);
            end
            4'h1: begin  // SUB
                {co, out}  = $signed(a) - $signed(b);
                carry_flag = ~co;
                overflow_flag = ($signed(a) > 0 && $signed(b) < 0 && $signed(out) < 0) ||
                ($signed(a) < 0 && $signed(b) > 0 && $signed(out) > 0);
            end
            4'h2: out = a & b;    // AND
            4'h3: out = a | b;    // OR
            4'h4: out = a ^ b;    // XOR
            4'h5: out = ~a;       // NOT_A
            4'h6: out = a << 1;   // SHL_A
            4'h7: out = a >> 1;   // SHR_A
            4'h8: begin  // INC_A
                {co, out}     = a + 1;
                carry_flag    = co;
                overflow_flag = (a == 8'h7F);
            end
            4'h9: out    = b;        // PASS_B (for MOV)
            4'ha: out    = a;        // PASS_A (for MOV)
            4'hb: out    = ~b;       // NOT_B
            default: out = 8'h00;
        endcase
        
        // Z and N flags are calculated based on the final result of any operation
        zero_flag     = (out == 8'h00);
        negative_flag = out[7];
    end
endmodule
