module status_register (clk,
                        load_flags,
                        Z_in,
                        N_in,
                        C_in,
                        V_in,
                        Z_out,
                        N_out,
                        C_out,
                        V_out);
    input clk, load_flags;
    input Z_in, N_in, C_in, V_in;
    output reg Z_out, N_out, C_out, V_out;
    
    initial begin
        Z_out = 0;
        N_out = 0;
        C_out = 0;
        V_out = 0;
    end
    
    always @(posedge clk) begin
        if (load_flags) begin
            Z_out <= Z_in;
            N_out <= N_in;
            C_out <= C_in;
            V_out <= V_in;
        end
    end
    
endmodule
