module data_memory (
    clk,
    address,
    write_data,
    write_enable,
    read_data
);
  input clk;
  input [7:0] address;
  input [7:0] write_data;
  input write_enable;
  output [7:0] read_data;

  reg [7:0] mem [0:255];

  assign read_data = mem[address];

  always @(posedge clk) begin
    if (write_enable) begin
      mem[address] <= write_data;
    end
  end
endmodule
