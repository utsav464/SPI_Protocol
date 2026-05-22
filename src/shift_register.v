module shift_register #(DATA_WIDTH = 8)
(
input                   clk,
input                   system_clk,
input                   reset,
input                   sample_clk,
input                   shift_clk,
input                   lsb,
input                   start,
input                   SS_enable,
input                   cnt_enable,
input                   data_in,
input [DATA_WIDTH-1:0]  transmit_data,
output                  data_out,
output [2:0]            bit_cnt,
output [DATA_WIDTH-1:0] received_data

);

reg  [2:0] bit_cnt_internal;

    


shift_register_receiver SRR(
                            .clk(clk),
                            .reset(reset),
                            .start(start),
                            .cnt_enable(cnt_enable),
                            .data_in(data_in),
                            .sample_clk(sample_clk),
                            .bit_cnt(bit_cnt),
                            .data_out(received_data)
                            );


shift_register_transmiter SRT(
                              .clk(clk),
                              .system_clk(system_clk),
                              .reset(reset),
                              .start(start),
                              .cnt_enable(SS_enable),
                              .shift_clk(shift_clk),
                              .data(transmit_data),
                              .bit_cnt(bit_cnt),
                              .data_out(data_out)
                               );
        
 
 
                               
always@(posedge sample_clk, negedge reset)
    begin
        if(~reset)
            begin   
                bit_cnt_internal <= 0;
            end
        else if(cnt_enable)
            begin       
                if(lsb)
                    bit_cnt_internal <= bit_cnt_internal + 1;
                else 
                    bit_cnt_internal <= bit_cnt_internal - 1;
            end            
        else 
            begin 
                if(lsb)
                    bit_cnt_internal <= 0;
                else
                    bit_cnt_internal <= 7;
            end
    end             
              
   
 
assign bit_cnt   = bit_cnt_internal;

                                           
endmodule
