module top(clk,clk2,reset,addr,data_master,SPI_interupt_request,data_slave);

input       clk;
input       clk2;
input       reset;
input [2:0] addr;      
input [7:0] data_master;
input [7:0] data_slave;
output      SPI_interupt_request;


wire   SS;
wire   MISO;
wire   MOSI;
wire   SCK;


SPI_MASTER SPI_MASTER(
                       .clk(clk),
                       .reset(reset),
                       .data(data_master),
                       .addr(addr),
                       .SPI_interupt_request(SPI_interupt_request),
                       .MOSI(MOSI),
                       .MISO(MISO),
                       .SS(SS),
                       .SCK(SCK)
                       );
                       
                       
                       
SPI_SLAVE SPI_SLAVE (
                       .clk(clk2),
                       .reset(reset),
                       .SS(SS),
                       .SCK(SCK),
                       .MOSI(MOSI),
                       .MISO(MISO),
                       .data(data_slave)
                        
                        );                       

endmodule
