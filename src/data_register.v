module data_register #(parameter DATA_WIDTH = 8,
                                 ADDR_WIDTH = 3)
(
input                   clk,
input                   reset,
input                   SPIF,
input  [ADDR_WIDTH-1:0] addr,
input  [DATA_WIDTH-1:0] data,
input  [DATA_WIDTH-1:0] received_data,
output [DATA_WIDTH-1:0] data_out

    );
    
reg [DATA_WIDTH-1:0] mem;    

localparam SPDIR = 3'd4;

always@(posedge clk,negedge reset)
    begin
        if(~reset)
            begin
                mem <= 0;
            end
         
        else
            begin
                if(SPIF)
                     begin   
                         mem <= received_data;
                     end  
            
                else if(addr == SPDIR)
                     begin
                         mem <= data;
                     end    
            end            
     end
     
     
 assign data_out = mem;                          
    
endmodule
