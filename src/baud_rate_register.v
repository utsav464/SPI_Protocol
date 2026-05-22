module baud_rate_register #(parameter DATA_WIDTH = 8,
                                      ADDR_WIDTH = 3)
                                     (clk,reset,addr,data,data_out);
                                     
input                   clk;
input                   reset;
input  [ADDR_WIDTH-1:0] addr;
input  [DATA_WIDTH-1:0] data;
output [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] mem;    

localparam SPBR = 3'd3;

always@(posedge clk,negedge reset)
    begin
        if(~reset)
            begin
                mem <=  0;
            end
        else if(addr == SPBR)
            begin
                mem <= data;
            end
            
    end
    
    
assign data_out = mem;                         


endmodule
