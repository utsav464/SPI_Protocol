module shift_register_receiver(clk,reset,start,cnt_enable,data_in,sample_clk,bit_cnt,data_out);


input        clk;
input        reset;
input        start;
input        cnt_enable;
input        data_in;
input        sample_clk;
input  [2:0] bit_cnt;
output [7:0] data_out;


reg [7:0] mem;


always@(posedge sample_clk, negedge reset)
    begin
        if(~reset)
            begin   
                mem <= 0;
            end
        else if(cnt_enable)
            begin
                mem[bit_cnt] <= data_in;
             end
     
    end


 assign data_out = mem;  
                      
endmodule
