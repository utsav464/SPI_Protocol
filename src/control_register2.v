module control_register2 #(parameter DATA_WIDTH = 8,
                                     ADDR_WIDTH = 3)
                                      (clk,reset,data,addr,data_out);

input                   clk;
input                   reset;
input  [ADDR_WIDTH-1:0] addr;
input  [DATA_WIDTH-1:0] data;
output [DATA_WIDTH-1:0] data_out;
        

reg [DATA_WIDTH-1:0] mem;    

localparam SPICR1 = 3'D2;

always@(posedge clk,negedge reset)
    begin
        if(~reset)
            begin
                mem <= 0;
            end
        else if(addr == SPICR1)
            begin
                mem <= data;
            end
     end

assign data_out = mem;
     
endmodule                        