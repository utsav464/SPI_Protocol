`timescale 1ns/1ps

module tb;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 3;

reg clk;
reg clk2;
reg reset;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_master;
reg [DATA_WIDTH-1:0] data_slave;

wire SPI_interupt_request;

// Instantiate TOP module
top dut (
    .clk(clk),
    .clk2(clk2),
    .reset(reset),
    .addr(addr),
    .data_master(data_master),
    .data_slave(data_slave),
    .SPI_interupt_request(SPI_interupt_request)
);

// Clock generation (100 MHz)
always #20   clk = ~clk;

always #12.5  clk2 = ~clk2;

initial begin

    clk = 0;
    clk2 = 0;
    reset = 0;
    addr = 0;
    data_master = 0;
    data_slave = 8'B10101010;   // slave data example

    // Reset
    #60;
    reset = 1;
    end
    
initial begin
    // Write control register
    #80;
    addr = 3'd1;
    data_master = 8'b11110011;

    // Write status / config
    #40;
    addr = 3'd2;
    data_master = 8'b00000000;

    // BAUD rate register
    #40;
    addr = 3'd3;
    data_master = 8'b00000011;

    // Data register
    #40;
    addr = 3'd4;
    data_master = 8'b11000000;
    
    
    #80;
    addr = 3'd7;
    data_master = 8'd0;
    
    #200;

    $finish;

end

endmodule