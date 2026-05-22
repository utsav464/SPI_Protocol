module SPI_SLAVE (clk,reset,SS,SCK,MOSI,MISO,data);
input       clk;
input       reset;
input       SS;
input       SCK;
input       MOSI;
output       MISO;
input [7:0] data;


reg       MISO_internal;
reg       sck_d;
reg [2:0] bit_cnt;
reg [2:0] state;
reg [7:0] received_mem;
reg [7:0] transfer_mem;

localparam IDLE     = 0,
           TRANSFER = 1,
           END      = 2;
    
  
wire clk_internal;  


assign clk_internal = SS ? clk: SCK; 

   
           
           
           
           
always@(posedge clk_internal,negedge reset)
    begin   
        if(~reset)
            begin
                state        <= IDLE;
                transfer_mem <= 0;
            end
        else
            begin
                transfer_mem <= data;
                case(state)
                
                IDLE     :     begin
                                  if(~SS)
                                    state <= TRANSFER;
                                  else  
                                    state <= IDLE;
                               end
              
               TRANSFER  :     begin    
                                  if(bit_cnt == 0)
                                    state <= END;
                                  else 
                                    state <= TRANSFER;
                               end
               
               END       :    begin
                                  state <= IDLE;
                              end
                              
               endcase
           end
     end
    
                    
                                                                         
    
                                         
always@(posedge SCK,negedge reset)
    begin
        if(~reset)
            bit_cnt <= 7;
        else if(~SS)
            begin
                bit_cnt <= bit_cnt - 1;
            end    
   
   end    
    
    
always@(negedge clk,negedge reset)
    begin
          if(~reset)
            begin
                MISO_internal <= 0;
            end
          else if(~SS && ~SCK)
            begin   
                 MISO_internal <= transfer_mem[bit_cnt];
            end  
         
    end
    


always@(posedge SCK,negedge reset)
    begin
       if(~reset)
          begin
            received_mem <= 0;
          end
       else 
          begin
            received_mem[bit_cnt] <= MOSI;
          end
    end        
                            

assign MISO = (SS == 1'B0) ? MISO_internal : 1'b0; 



endmodule
