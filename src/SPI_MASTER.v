module SPI_MASTER #(parameter DATA_WIDTH = 8,
                       ADDR_WIDTH = 3)
                       (clk,reset,data,addr,SPI_interupt_request,MOSI,MISO,SS,SCK);

input                   clk;
input                   reset;
input [DATA_WIDTH-1:0]  data;
input [ADDR_WIDTH-1:0]  addr;
inout                   MOSI;
input                   MISO;
output                  SS;
output                  SCK;
output                  SPI_interupt_request;

wire   [11:0]         baud_rate_cnt;
wire   [11:0]         counter_divisor;
wire                  Baud_rate;
wire                  start;
wire                  start_active;
wire                  SPIF;
wire                  SPTEF;
wire                  shift_clk;
wire                  sample_clk;
wire                  data_in;
wire                  data_out; 
wire                  SCK_out;
wire                  SPI_interupt_request_i;
wire                  SS_enable;
wire                  cnt_enable;
wire                  SCK_enable;
wire [2:0]            bit_cnt; 
wire [DATA_WIDTH-1:0] received_data;
wire [DATA_WIDTH-1:0] mem;  
wire [DATA_WIDTH-1:0] control_reg_1;
wire [DATA_WIDTH-1:0] control_reg_2; 
wire [DATA_WIDTH-1:0] baud_rate_reg;      
wire [DATA_WIDTH-1:0] data_reg;                               





Master_control MASTER_CONTROL (
                                .clk(clk),
                                .sample_clk(shift_clk),
                                .reset(reset),
                                .lsb(control_reg_1[0]),
                                .baud_rate_cnt(baud_rate_cnt),
                                .counter_divisor(counter_divisor),
                                .bit_cnt(bit_cnt),
                                .addr(addr),
                                .start(start),
                                .start_active(start_active),
                                .SPIF(SPIF),
                                .SPTEF(SPTEF),
                                .SS_enable(SS_enable),
                                .cnt_enable(cnt_enable),
                                .SCK_enable(SCK_enable)
                                 );
                                 
status_register status_reg (
                               .clk(clk),
                               .reset(reset),
                               .SPIF(SPIF),
                               .SPTEF(SPTEF),
                               .SPI_interupt_request(SPI_interupt_request_i)
                               
                               );



shift_register SHIFT_REGISTER(
                                .clk(Baud_rate),
                                .system_clk(clk),
                                .reset(reset),
                                .sample_clk(sample_clk),
                                .shift_clk(shift_clk),
                                .lsb(control_reg_1[0]),
                                .start(start),
                                .SS_enable(SS_enable),
                                .cnt_enable(cnt_enable),
                                .data_in(data_in),
                                .transmit_data(data_reg),
                                .bit_cnt(bit_cnt),
                                .data_out(data_out),
                                .received_data(received_data)
                 
                               );
                               
                             
 baud_rate_generator BAUD_RATE_GENERATOR(
                                           .clk(clk),
                                           .reset(reset),
                                           .SPPR(baud_rate_reg[6:4]),
                                           .SPR(baud_rate_reg[2:0]),
                                           .Baud_rate(Baud_rate),
                                           .counter_divisor(counter_divisor),
                                           .baud_rate_cnt(baud_rate_cnt)
                                           
                                           );         

clock_polarity_transmiter CLOCK_POLARITY_CONTEROL(
                                                  .system_clk(clk),
                                                  .clk(Baud_rate),
                                                  .reset(reset),
                                                  .CPOL(control_reg_1[3]),
                                                  .CPHA(control_reg_1[2]),
                                                  .start(start_active),
                                                  .SCK_enable(SCK_enable),
                                                  .SCK(SCK_out),
                                                  .sample_clk(sample_clk),
                                                  .shift_clk(shift_clk)
                                                   );                                                               
                     
                             
control_register1 CR1 (
                        .clk(clk),
                        .reset(reset),
                        .data(data),
                        .addr(addr),
                        .data_out(control_reg_1)
                        );  
                        
control_register2 CR2 (
                         .clk(clk),
                         .reset(reset),
                         .data(data),
                         .addr(addr),
                         .data_out(control_reg_2)
                         
                         );       
                         
baud_rate_register  BRR (
                          .clk(clk),
                          .reset(reset),
                          .addr(addr),
                          .data(data),
                          .data_out(baud_rate_reg)
                          );    
                          
data_register DR     (
                        .clk(clk),
                        .reset(reset),
                        .addr(addr),
                        .SPIF(SPIF),
                        .received_data(received_data),
                        .data(data),
                        .data_out(data_reg)
                        
                      );             
                      
                      
port_logic PL (
                .shift_clk(shift_clk),
                .reset(reset),
                .SCK(SCK_out),
                .MOSI(MOSI),
                .MISO(MISO),
                .SS(SS),
                .SS_enable(start_active),
                .BIDIROE(control_reg_2[3]),
                .MSTR(control_reg_1[4]),
                .SPC0(control_reg_2[0]),
                .data_out(data_out),
                .SCK_out(SCK),
                .data_in(data_in)
                 );   
                 
                 
assign SPI_interupt_request =  SPI_interupt_request_i;


                                                                                                                      
endmodule
