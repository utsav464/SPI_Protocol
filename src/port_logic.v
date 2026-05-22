module port_logic(shift_clk,reset,SCK,MOSI,MISO,SS,SS_enable,BIDIROE,MSTR,SPC0,data_out,SCK_out,SCK_in,data_in);

input   shift_clk;
input   reset;
input   SCK;
inout   MOSI;
input   MISO;   
input   SS_enable;
input   BIDIROE;
input   MSTR;
input   SPC0;
input   data_out;
output  SCK_out;
output  SCK_in;
output  data_in;
output  SS; 



                    
                        
assign MOSI    = (BIDIROE && SPC0 && MSTR) ? data_out:
                 (~SPC0 && MSTR)           ? data_out: 1'bz;

//assign MISO    = (BIDIROE && SPC0 && ~MSTR)? data_out:
//                 (~SPC0 && ~MSTR)          ? data_out: 1'bz;       
      
                
assign data_in = MSTR? MISO:MOSI;
             
assign SCK_out = MSTR ? SCK : 1'bz;
assign SCK_in  = (MSTR == 0) ? SCK : 1'bz; 
assign SS      = SS_enable ? 1'b0 : 1'b1; 
         

endmodule
