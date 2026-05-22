module baud_rate_generator(clk,reset,SPPR,SPR,counter_divisor,Baud_rate,baud_rate_cnt);
input         clk;
input         reset;
input [2:0]   SPPR;
input [2:0]   SPR;
output        Baud_rate;
output [11:0] counter_divisor;
output [11:0] baud_rate_cnt;

reg  [11:0] count;
wire [11:0] divisor;
reg         baud_rate;

assign divisor = (SPPR + 3'd1)*(1 << SPR+3'd1);
wire [11:0] counter;
assign counter = divisor/2 ;

always@(posedge clk,negedge reset)
    begin   
        if(~reset)
            begin
                count     <= 0;
                baud_rate <= 0;
                
            end
        else
            begin
                count <= count + 1;  
                if(count == (counter - 1)) 
                    begin
                        count     <= 0;
                        baud_rate <= ~baud_rate;
                    end
            end
    end
    
                 
assign Baud_rate       = baud_rate;  
assign baud_rate_cnt   = count;                  
assign counter_divisor = counter;               
                
endmodule
