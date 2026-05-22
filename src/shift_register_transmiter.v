module shift_register_transmiter #(parameter DATA_WIDTH = 8)(clk,system_clk,reset,start,cnt_enable,data,shift_clk,bit_cnt,data_out);


input                   clk;
input                   system_clk;
input                   reset;
input                   start;
input                   cnt_enable;
input                   shift_clk;
input [2:0]             bit_cnt;
input  [DATA_WIDTH-1:0] data;
output                  data_out;



reg [7:0] mem;
reg       data_out_internal; 


always@(posedge shift_clk, negedge reset)
    begin
        if(~reset)
            begin
                data_out_internal <= 0;
            end
        else if(cnt_enable)
            begin
                data_out_internal <= mem[bit_cnt];
            end  
        else
            data_out_internal <= 0;          
    end
    
    
always@(posedge system_clk,negedge reset)
    begin
        if(~reset)
            begin
                mem <= 0;
            end
        else if(start)
            begin
                mem <= data;
            end
        else 
            begin
                mem <= mem;
            end        
    end                     
 
 
 assign data_out = data_out_internal;   
    
endmodule
