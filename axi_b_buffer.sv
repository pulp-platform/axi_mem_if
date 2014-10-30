module axi_b_buffer
  #(
    parameter ID_WIDTH = 4,
    parameter USER_WIDTH = 6,
    parameter BUFFER_DEPTH = 8
    )
  (
   
   input logic                   clk_i,
   input logic                   rst_ni,
   
   input logic                   slave_valid_i,
   input logic  [1:0]            slave_resp_i,
   input logic  [ID_WIDTH-1:0]   slave_id_i,
   input logic  [USER_WIDTH-1:0] slave_user_i,
   output logic                  slave_ready_o,
   
   output logic                  master_valid_o,
   output logic [1:0]            master_resp_o,
   output logic [ID_WIDTH-1:0]   master_id_o,
   output logic [USER_WIDTH-1:0] master_user_o,
   input  logic                  master_ready_i
   
   );
   
   logic [2+USER_WIDTH+ID_WIDTH-1:0] s_data_in;
   logic [2+USER_WIDTH+ID_WIDTH-1:0] s_data_out;

   assign s_data_in = {slave_id_i,  slave_user_i,  slave_resp_i};
   assign             {master_id_o, master_user_o, master_resp_o} = s_data_out; 
   

   
   axi_buffer
     #(
       .DATA_WIDTH(2+USER_WIDTH+ID_WIDTH),
       .BUFFER_DEPTH(BUFFER_DEPTH)
       )
   buffer_i
     (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .valid_o(master_valid_o),
      .data_o(s_data_out),
      .ready_i(master_ready_i),
      .valid_i(slave_valid_i),
      .data_i(s_data_in),
      .ready_o(slave_ready_o)
      );
   
endmodule
