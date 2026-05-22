module Master_control #(parameter DATA_WIDTH = 8,
                                  ADDR_WIDTH = 3)
                                  (clk,sample_clk,reset,lsb,counter_divisor,baud_rate_cnt,bit_cnt,addr,start,start_active,SPIF,SPTEF,SS_enable,cnt_enable,SCK_enable);
input                   clk;
input                   sample_clk;
input                   reset;
input                   lsb;
input  [11:0]           counter_divisor;
input  [11:0]           baud_rate_cnt;
input  [2:0]            bit_cnt;
input  [ADDR_WIDTH-1:0] addr;
output                  start;
output                  SPIF;
output                  SPTEF;
output                  start_active;
output                  SS_enable;
output                  cnt_enable;
output                  SCK_enable;

reg                  cnt_enable_internal;
reg                  start_internal;
reg                  start_active_internal;
reg                  SPIF_internal;
reg                  SPTEF_internal;
reg                  SS_enable_internal;
reg [2:0]            state; 


localparam SPDIR = 3'd4;

localparam IDLE     = 3'd0,
           SETUP    = 3'd4,
           START    = 3'd1,
           TRANSFER = 3'd2,
           END      = 3'd3,
           LAST     = 3'd5;
           
           
always@(posedge clk,negedge reset)
    begin   
        if(~reset)
            begin
                start_internal        <= 0;
                start_active_internal <= 0;
                state                 <= IDLE;
                SPIF_internal         <= 0;
                SPTEF_internal        <= 0;
                SS_enable_internal    <= 0;
                cnt_enable_internal   <= 0;
            end
            
        else if(addr == SPDIR && state == IDLE)
            begin
                 state                   <= SETUP;
                 start_internal          <= 0;
                 cnt_enable_internal     <= 0;
                 start_active_internal   <= 0;
                 SPIF_internal           <= 0;
                 SPTEF_internal          <= 0;
                 SS_enable_internal      <= 0;
            end     
                
            
        else if(sample_clk)
            begin   
                   case(state)
                    SETUP:  begin
                                    begin
                                        state                   <= START;
                                        start_internal          <= 1;
                                        cnt_enable_internal     <= 0;
                                        start_active_internal   <= 0;
                                        SPIF_internal           <= 0;
                                        SPTEF_internal          <= 0;
                                        SS_enable_internal      <= 1;
                                    end 
                              end 
                  
                START      : begin
                                state                 <= TRANSFER;
                                start_internal        <= 0;
                                start_active_internal <= 1;
                                cnt_enable_internal   <= 1;
                                SPIF_internal         <= 0;
                                SPTEF_internal        <= 1;
                                SS_enable_internal    <= 1;
                             end   
                
                
                TRANSFER   : begin  
                                start_internal <= 0;
                                SPTEF_internal <= 0;
                                begin
                                    case(lsb)
                                        1'b0: begin
                                                if(bit_cnt == 0)
                                                    begin
                                                        state                 <= LAST;
                                                        cnt_enable_internal   <= 0;
                                                        SS_enable_internal    <= 0;
                                                    end    
                                              end
                                        
                                        1'b1: begin
                                                if(bit_cnt == 7)
                                                    begin
                                                        state                 <= LAST;
                                                        cnt_enable_internal   <= 0;
                                                        SS_enable_internal    <= 0;
                                                    end
                                              end
                                    endcase
                                end               
                             end 
                  
                  
                  LAST       : begin
                                SPIF_internal         <= 1; 
                                SS_enable_internal    <= 0; 
                                start_active_internal <= 1;
                                state                 <= END;
                             end                    
                 default   : begin
                                 start_internal        <= 0;
                                 start_active_internal <= 0;
                                 state                 <= IDLE;
                                 SPIF_internal         <= 0;
                                 SPTEF_internal        <= 0;
                                 SS_enable_internal    <= 0;
                                 cnt_enable_internal   <= 0;
                             end    
                                                      
              endcase           
            end
         
       else 
          case(state)   
             END        : begin
                                SPIF_internal         <= 1; 
                                SS_enable_internal    <= 0; 
                                if(baud_rate_cnt ==  counter_divisor - 1'b1)
                                    begin
                                        start_active_internal <= 0;
                                        state                 <= IDLE;
                                    end
                             end     
              default  : begin
                             state                   <= state;
                             start_internal          <= start_internal;
                             cnt_enable_internal     <= cnt_enable_internal;
                             start_active_internal   <= start_active_internal;
                             SPIF_internal           <= SPIF_internal;
                             SPTEF_internal          <= SPTEF_internal;
                             SS_enable_internal      <= SS_enable_internal;
                             
                        end                                        
          endcase                    
    end



assign SCK_enable   = (state == TRANSFER || state == END || state == LAST);
assign SPTEF        = SPTEF_internal; 
assign SPIF         = SPIF_internal;                                      
assign start        = start_internal;   
assign start_active = start_active_internal;  
assign SS_enable    = SS_enable_internal;      
assign cnt_enable   = cnt_enable_internal;                

endmodule
