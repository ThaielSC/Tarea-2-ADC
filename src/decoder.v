module decoder (opcode,
                Z_in,
                N_in,
                C_in,
                V_in,              // Flag inputs
                load_A,
                load_B,
                mux_A_sel,
                mux_B_sel,
                alu_op,
                mem_write,
                dm_write_data_sel,
                dm_addr_sel,
                load_flags,        // New control output
                load_pc);          // New control output
    input [6:0] opcode;
    input Z_in, N_in, C_in, V_in;
    
    output reg load_A, load_B, mem_write, load_flags, load_pc;
    output reg [1:0] mux_A_sel;
    output reg [1:0] mux_B_sel;
    output reg [1:0] dm_addr_sel;
    output reg [1:0] dm_write_data_sel;
    output reg [3:0] alu_op;
    
    always @(*) begin
        // Default values (NOP)
        load_A            = 0;
        load_B            = 0;
        mux_A_sel         = 2'b00;
        mux_B_sel         = 2'b00;
        alu_op            = 4'hF;
        mem_write         = 0;
        dm_write_data_sel = 2'b00;
        dm_addr_sel       = 2'b00;
        load_flags        = 0;
        load_pc           = 0;
        
        case (opcode)
            
            // --- Existing Instructions ---
            
            // MOV
            7'b0000000: begin // MOV A,B (A<-B)
                load_A    = 1;
                alu_op    = 4'h9;
                mux_B_sel = 2'b01;
            end
            7'b0000001: begin // MOV B,A (B<-A)
                load_B = 1;
                alu_op = 4'ha;
            end
            7'b0000010: begin // MOV A,Lit
                load_A    = 1;
                alu_op    = 4'h9;
                mux_B_sel = 2'b10;
            end
            7'b0000011: begin // MOV B,Lit
                load_B    = 1;
                alu_op    = 4'h9;
                mux_B_sel = 2'b10;
            end
            
            // ADD
            7'b0000100: begin // ADD A,B (A<-A+B)
                load_A    = 1;
                alu_op    = 4'h0;
                mux_B_sel = 2'b01;
            end
            7'b0000101: begin // ADD B,A (B<-B+A)
                load_B    = 1;
                alu_op    = 4'h0;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b00;
            end
            7'b0000110: begin // ADD A,Lit
                load_A    = 1;
                alu_op    = 4'h0;
                mux_B_sel = 2'b10;
            end
            7'b0000111: begin // ADD B,Lit
                load_B    = 1;
                alu_op    = 4'h0;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b10;
            end
            
            // SUB
            7'b0001000: begin // SUB A,B (A<-A-B)
                load_A    = 1;
                alu_op    = 4'h1;
                mux_B_sel = 2'b01;
            end
            7'b0001001: begin // SUB B,A (B<-A-B)
                load_B    = 1;
                alu_op    = 4'h1;
                mux_A_sel = 2'b00;
                mux_B_sel = 2'b01;
            end
            7'b0001010: begin // SUB A,Lit
                load_A    = 1;
                alu_op    = 4'h1;
                mux_B_sel = 2'b10;
            end
            7'b0001011: begin // SUB B,Lit
                load_B    = 1;
                alu_op    = 4'h1;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b10;
            end
            
            // AND
            7'b0001100: begin // AND A,B
                load_A    = 1;
                alu_op    = 4'h2;
                mux_B_sel = 2'b01;
            end
            7'b0001101: begin // AND B,A
                load_B    = 1;
                alu_op    = 4'h2;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b00;
            end
            7'b0001110: begin // AND A,Lit
                load_A    = 1;
                alu_op    = 4'h2;
                mux_B_sel = 2'b10;
            end
            7'b0001111: begin // AND B,Lit
                load_B    = 1;
                alu_op    = 4'h2;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b10;
            end
            
            // OR
            7'b0010000: begin // OR A,B
                load_A    = 1;
                alu_op    = 4'h3;
                mux_B_sel = 2'b01;
            end
            7'b0010001: begin // OR B,A
                load_B    = 1;
                alu_op    = 4'h3;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b00;
            end
            7'b0010010: begin // OR A,Lit
                load_A    = 1;
                alu_op    = 4'h3;
                mux_B_sel = 2'b10;
            end
            7'b0010011: begin // OR B,Lit
                load_B    = 1;
                alu_op    = 4'h3;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b10;
            end
            
            // NOT
            7'b0010100: begin // NOT A,A (A<-~A)
                load_A = 1;
                alu_op = 4'h5;
            end
            7'b0010101: begin // NOT A,B (A<-~B)
                load_A    = 1;
                alu_op    = 4'hb;
                mux_B_sel = 2'b01;
            end
            7'b0010110: begin // NOT B,A (B<-~A)
                load_B = 1;
                alu_op = 4'h5;
            end
            7'b0010111: begin // NOT B,B (B<-~B)
                load_B    = 1;
                alu_op    = 4'h5;
                mux_A_sel = 2'b01;
            end
            
            // XOR
            7'b0011000: begin // XOR A,B
                load_A    = 1;
                alu_op    = 4'h4;
                mux_B_sel = 2'b01;
            end
            7'b0011001: begin // XOR B,A
                load_B    = 1;
                alu_op    = 4'h4;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b00;
            end
            7'b0011010: begin // XOR A,Lit
                load_A    = 1;
                alu_op    = 4'h4;
                mux_B_sel = 2'b10;
            end
            7'b0011011: begin // XOR B,Lit
                load_B    = 1;
                alu_op    = 4'h4;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b10;
            end
            
            // SHL
            7'b0011100: begin // SHL A,A
                load_A = 1;
                alu_op = 4'h6;
            end
            7'b0011101: begin // SHL A,B (A<-B<<1)
                load_A    = 1;
                alu_op    = 4'h6;
                mux_A_sel = 2'b01;
            end
            7'b0011110: begin // SHL B,A (B<-A<<1)
                load_B = 1;
                alu_op = 4'h6;
            end
            7'b0011111: begin // SHL B,B
                load_B    = 1;
                alu_op    = 4'h6;
                mux_A_sel = 2'b01;
            end
            
            // SHR
            7'b0100000: begin // SHR A,A
                load_A = 1;
                alu_op = 4'h7;
            end
            7'b0100001: begin // SHR A,B (A<-B>>1)
                load_A    = 1;
                alu_op    = 4'h7;
                mux_A_sel = 2'b01;
            end
            7'b0100010: begin // SHR B,A (B<-A>>1)
                load_B = 1;
                alu_op = 4'h7;
            end
            7'b0100011: begin // SHR B,B
                load_B    = 1;
                alu_op    = 4'h7;
                mux_A_sel = 2'b01;
            end
            
            // INC
            7'b0100100: begin // INC B (B<-B+1)
                load_B    = 1;
                alu_op    = 4'h8;
                mux_A_sel = 2'b01;
            end
            
            // Memory MOV
            7'b0100101: begin // MOV A,(Dir)
                load_A    = 1;
                mux_B_sel = 2'b11;
                alu_op    = 4'h9; // PASS_B
            end
            7'b0100110: begin // MOV B,(Dir)
                load_B    = 1;
                mux_B_sel = 2'b11;
                alu_op    = 4'h9; // PASS_B
            end
            7'b0100111: begin // MOV (Dir),A
                mem_write = 1;
            end
            7'b0101000: begin // MOV (Dir),B
                mem_write         = 1;
                dm_write_data_sel = 2'b01;
            end
            7'b0101001: begin // MOV A,(B)
                load_A      = 1;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
                alu_op      = 4'h9;
            end
            7'b0101010: begin // MOV B,(A)
                load_B      = 1;
                dm_addr_sel = 2'b01;
                mux_B_sel   = 2'b11;
                alu_op      = 4'h9;
            end
            7'b0101011: begin // MOV (B),A
                mem_write   = 1;
                dm_addr_sel = 2'b10;
            end
            
            // Memory ADD
            7'b0101100: begin // ADD A,(Dir)
                load_A    = 1;
                alu_op    = 4'h0;
                mux_B_sel = 2'b11;
            end
            7'b0101101: begin // ADD B,(Dir)
                load_B    = 1;
                alu_op    = 4'h0;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b11;
            end
            7'b0101110: begin // ADD A,(B)
                load_A      = 1;
                alu_op      = 4'h0;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
            end
            7'b0101111: begin // ADD (Dir)
                mem_write         = 1;
                alu_op            = 4'h0;
                mux_B_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory SUB
            7'b0110000: begin // SUB A,(Dir)
                load_A    = 1;
                alu_op    = 4'h1;
                mux_B_sel = 2'b11;
            end
            7'b0110001: begin // SUB B,(Dir)
                load_B    = 1;
                alu_op    = 4'h1;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b11;
            end
            7'b0110010: begin // SUB A,(B)
                load_A      = 1;
                alu_op      = 4'h1;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
            end
            7'b0110011: begin // SUB (Dir)
                mem_write         = 1;
                alu_op            = 4'h1;
                mux_B_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory AND
            7'b0110100: begin // AND A,(Dir)
                load_A    = 1;
                alu_op    = 4'h2;
                mux_B_sel = 2'b11;
            end
            7'b0110101: begin // AND B,(Dir)
                load_B    = 1;
                alu_op    = 4'h2;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b11;
            end
            7'b0110110: begin // AND A,(B)
                load_A      = 1;
                alu_op      = 4'h2;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
            end
            7'b0110111: begin // AND (Dir)
                mem_write         = 1;
                alu_op            = 4'h2;
                mux_B_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory OR
            7'b0111000: begin // OR A,(Dir)
                load_A    = 1;
                alu_op    = 4'h3;
                mux_B_sel = 2'b11;
            end
            7'b0111001: begin // OR B,(Dir)
                load_B    = 1;
                alu_op    = 4'h3;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b11;
            end
            7'b0111010: begin // OR A,(B)
                load_A      = 1;
                alu_op      = 4'h3;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
            end
            7'b0111011: begin // OR (Dir)
                mem_write         = 1;
                alu_op            = 4'h3;
                mux_B_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory NOT
            7'b0111100: begin // NOT (Dir),A
                mem_write         = 1;
                alu_op            = 4'h5;
                dm_write_data_sel = 2'b10;
            end
            7'b0111101: begin // NOT (Dir),B
                mem_write         = 1;
                alu_op            = 4'h5;
                mux_A_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            7'b0111110: begin // NOT (B)
                mem_write         = 1;
                dm_addr_sel       = 2'b10;
                alu_op            = 4'h5;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory XOR
            7'b0111111: begin // XOR A,(Dir)
                load_A    = 1;
                alu_op    = 4'h4;
                mux_B_sel = 2'b11;
            end
            7'b1000000: begin // XOR B,(Dir)
                load_B    = 1;
                alu_op    = 4'h4;
                mux_A_sel = 2'b01;
                mux_B_sel = 2'b11;
            end
            7'b1000001: begin // XOR A,(B)
                load_A      = 1;
                alu_op      = 4'h4;
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
            end
            7'b1000010: begin // XOR (Dir)
                mem_write         = 1;
                alu_op            = 4'h4;
                mux_B_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory SHL
            7'b1000011: begin // SHL (Dir),A
                mem_write         = 1;
                alu_op            = 4'h6;
                dm_write_data_sel = 2'b10;
            end
            7'b1000100: begin // SHL (Dir),B
                mem_write         = 1;
                alu_op            = 4'h6;
                mux_A_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            7'b1000101: begin // SHL (B)
                mem_write         = 1;
                dm_addr_sel       = 2'b10;
                alu_op            = 4'h6;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory SHR
            7'b1000110: begin // SHR (Dir),A
                mem_write         = 1;
                alu_op            = 4'h7;
                dm_write_data_sel = 2'b10;
            end
            7'b1000111: begin // SHR (Dir),B
                mem_write         = 1;
                alu_op            = 4'h7;
                mux_A_sel         = 2'b01;
                dm_write_data_sel = 2'b10;
            end
            7'b1001000: begin // SHR (B)
                mem_write         = 1;
                dm_addr_sel       = 2'b10;
                alu_op            = 4'h7;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory INC
            7'b1001001: begin // INC (Dir)
                mem_write         = 1;
                alu_op            = 4'h8;
                mux_A_sel         = 2'b10;
                dm_write_data_sel = 2'b10;
            end
            7'b1001010: begin // INC (B)
                mem_write         = 1;
                dm_addr_sel       = 2'b10;
                alu_op            = 4'h8;
                mux_A_sel         = 2'b10;
                dm_write_data_sel = 2'b10;
            end
            
            // Memory RST
            7'b1001011: begin // RST (Dir)
                mem_write         = 1;
                alu_op            = 4'h4;
                mux_B_sel         = 2'b00;
                dm_write_data_sel = 2'b10;
            end
            7'b1001100: begin // RST (B)
                mem_write         = 1;
                dm_addr_sel       = 2'b10;
                alu_op            = 4'h4;
                mux_B_sel         = 2'b00;
                dm_write_data_sel = 2'b10;
            end
            
            // --- New Jump and Compare Instructions ---
            
            // CMP
            7'b1001101: begin // CMP A,B
                alu_op     = 4'h1; // SUB
                mux_B_sel  = 2'b01;
                load_flags = 1;
            end
            7'b1001110: begin // CMP A,Lit
                alu_op     = 4'h1; // SUB
                mux_B_sel  = 2'b10;
                load_flags = 1;
            end
            7'b1001111: begin // CMP B,Lit
                alu_op     = 4'h1; // SUB
                mux_A_sel  = 2'b01;
                mux_B_sel  = 2'b10;
                load_flags = 1;
            end
            7'b1010000: begin // CMP A,(Dir)
                alu_op     = 4'h1; // SUB
                mux_B_sel  = 2'b11;
                load_flags = 1;
            end
            7'b1010001: begin // CMP B,(Dir)
                alu_op     = 4'h1; // SUB
                mux_A_sel  = 2'b01;
                mux_B_sel  = 2'b11;
                load_flags = 1;
            end
            7'b1010010: begin // CMP A,(B)
                alu_op      = 4'h1; // SUB
                dm_addr_sel = 2'b10;
                mux_B_sel   = 2'b11;
                load_flags  = 1;
            end
            
            // JUMPS
            7'b1010011: load_pc                     = 1; // JMP
            7'b1010100: if (Z_in) load_pc           = 1; // JEQ
            7'b1010101: if (!Z_in) load_pc          = 1; // JNE
            7'b1010110: if (!N_in && !Z_in) load_pc = 1; // JGT
            7'b1010111: if (N_in) load_pc           = 1; // JLT
            7'b1011000: if (!N_in) load_pc          = 1; // JGE
            7'b1011001: if (N_in || Z_in) load_pc   = 1; // JLE
            7'b1011010: if (C_in) load_pc           = 1; // JCR
            7'b1011011: if (V_in) load_pc           = 1; // JOV
            
            default: ;  // NOP
        endcase
    end
endmodule
