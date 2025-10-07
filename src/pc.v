module pc (clk,
           load_pc,
           data_in,
           pc);
    input clk, load_pc;
    input [7:0] data_in;
    output [7:0] pc;
    
    reg  [7:0] pc;
    
    initial begin
        pc = 0;
    end
    
    always @(posedge clk) begin
        if (load_pc) begin
            pc <= data_in;
            end else begin
            pc <= pc + 1;
        end
    end
endmodule
