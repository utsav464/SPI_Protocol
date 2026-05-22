module status_register #(parameter DATA_WIDTH = 8,
                                   ADDR_WIDTH = 3)
                                      (clk,reset,SPIF,SPTEF,SPI_interupt_request);

input    clk;
input    reset;
input    SPIF;
input    SPTEF;
output   SPI_interupt_request;


reg [DATA_WIDTH-1:0] mem;    


always@(posedge clk,negedge reset)
    begin
        if(~reset)
            begin
                mem <= 0;
            end
        else 
            begin
                mem[7] <= SPIF;
                mem[5] <= SPTEF;
            end
     end

assign SPI_interupt_request = mem[7]| mem[5];
     
endmodule          