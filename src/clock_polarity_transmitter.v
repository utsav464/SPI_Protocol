module clock_polarity_transmiter(system_clk,clk,reset,CPOL,CPHA,start,SCK_enable,SCK,sample_clk,shift_clk);
input  system_clk;
input  clk;
input  reset;
input  CPOL;
input  CPHA;
input  start;
input  SCK_enable;
output SCK;
output sample_clk;
output shift_clk;


wire  SCK_internal;    
wire  rising_edge;
wire  falling_edge;
reg   sck_d;



   always@(posedge system_clk,negedge reset)
    begin
        if(~reset)
            begin   
                sck_d <= 0;
            end
        else 
            begin
                sck_d <= clk;
            end    
    end            




assign SCK_internal = SCK_enable ? (clk ^ CPOL) : CPOL;

assign rising_edge  = clk && ~sck_d;
assign falling_edge = ~clk && sck_d;                     
   

assign shift_clk  = CPHA ? rising_edge  : falling_edge;
assign sample_clk = CPHA ? falling_edge : rising_edge; 

assign SCK = SCK_internal;
        
endmodule
