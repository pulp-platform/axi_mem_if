// Author: Florian Zaruba, ETH Zurich
// Date: 05.07.2017
// Description: Wrap of AXI to MEM adapter
//
//
// Copyright (C) 2017 ETH Zurich, University of Bologna
// All rights reserved.
//
// This code is under development and not yet released to the public.
// Until it is released, the code is under the copyright of ETH Zurich and
// the University of Bologna, and may contain confidential and/or unpublished
// work. Any reuse/redistribution is strictly forbidden without written
// permission from ETH Zurich.
//
// Bug fixes and contributions will eventually be released under the
// SolderPad open hardware license in the context of the PULP platform
// (http://www.pulp-platform.org), under the copyright of ETH Zurich and the
// University of Bologna.
//

module axi_mem_if_wrap #(
    parameter AXI4_ADDRESS_WIDTH = 64,
    parameter AXI4_RDATA_WIDTH   = 64,
    parameter AXI4_WDATA_WIDTH   = 64,
    parameter AXI4_ID_WIDTH      = 16,
    parameter AXI4_USER_WIDTH    = 10,
    parameter AXI_NUMBYTES       = AXI4_WDATA_WIDTH/8,
    parameter BUFF_DEPTH_SLAVE   = 4
)(
    input logic                            clk_i,          // Clock
    input logic                            rst_ni,         // Asynchronous reset active low
    input logic                            test_en_i,

    AXI_BUS.Slave                          slave,

    output logic                           CEN,
    output logic                           WEN,
    output logic  [AXI4_ADDRESS_WIDTH-1:0] A,
    output logic  [AXI4_WDATA_WIDTH-1:0]   D,
    output logic  [AXI_NUMBYTES-1:0]       BE,
    input  logic  [AXI4_RDATA_WIDTH-1:0]   Q
);

    axi_mem_if #(
        .AXI4_ADDRESS_WIDTH ( AXI4_ADDRESS_WIDTH ),
        .AXI4_RDATA_WIDTH   ( AXI4_RDATA_WIDTH   ),
        .AXI4_WDATA_WIDTH   ( AXI4_WDATA_WIDTH   ),
        .AXI4_ID_WIDTH      ( AXI4_ID_WIDTH      ),
        .AXI4_USER_WIDTH    ( AXI4_USER_WIDTH    ),
        .AXI_NUMBYTES       ( AXI_NUMBYTES       ),
        .BUFF_DEPTH_SLAVE   ( BUFF_DEPTH_SLAVE   )
    ) axi_mem_if_i (
        .ACLK       (  clk_i            ),
        .test_en_i  (  test_en_i        ),
        .ARESETn    (  rst_ni           ),
        .AWID_i     (  slave.aw_id      ),
        .AWADDR_i   (  slave.aw_addr    ),
        .AWLEN_i    (  slave.aw_len     ),
        .AWSIZE_i   (  slave.aw_size    ),
        .AWBURST_i  (  slave.aw_burst   ),
        .AWLOCK_i   (  slave.aw_lock    ),
        .AWCACHE_i  (  slave.aw_cache   ),
        .AWPROT_i   (  slave.aw_prot    ),
        .AWREGION_i (  slave.aw_region  ),
        .AWUSER_i   (  slave.aw_user    ),
        .AWQOS_i    (  slave.aw_qos     ),
        .AWVALID_i  (  slave.aw_valid   ),
        .AWREADY_o  (  slave.aw_ready   ),
        .WDATA_i    (  slave.w_data     ),
        .WSTRB_i    (  slave.w_strb     ),
        .WLAST_i    (  slave.w_last     ),
        .WUSER_i    (  slave.w_user     ),
        .WVALID_i   (  slave.w_valid    ),
        .WREADY_o   (  slave.w_ready    ),
        .BID_o      (  slave.b_id       ),
        .BRESP_o    (  slave.b_resp     ),
        .BVALID_o   (  slave.b_valid    ),
        .BUSER_o    (  slave.b_user     ),
        .BREADY_i   (  slave.b_ready    ),
        .ARID_i     (  slave.ar_id      ),
        .ARADDR_i   (  slave.ar_addr    ),
        .ARLEN_i    (  slave.ar_len     ),
        .ARSIZE_i   (  slave.ar_size    ),
        .ARBURST_i  (  slave.ar_burst   ),
        .ARLOCK_i   (  slave.ar_lock    ),
        .ARCACHE_i  (  slave.ar_cache   ),
        .ARPROT_i   (  slave.ar_prot    ),
        .ARREGION_i (  slave.ar_region  ),
        .ARUSER_i   (  slave.ar_user    ),
        .ARQOS_i    (  slave.ar_qos     ),
        .ARVALID_i  (  slave.ar_valid   ),
        .ARREADY_o  (  slave.ar_ready   ),
        .RID_o      (  slave.r_id       ),
        .RDATA_o    (  slave.r_data     ),
        .RRESP_o    (  slave.r_resp     ),
        .RLAST_o    (  slave.r_last     ),
        .RUSER_o    (  slave.r_user     ),
        .RVALID_o   (  slave.r_valid    ),
        .RREADY_i   (  slave.r_ready    ),
        .*
    );
endmodule