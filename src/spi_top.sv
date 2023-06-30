
module spi_top #(parameter NUM_NODES = 4, DATA_WIDTH = 8, CPOL = 0, CPHA = 0) (
    input logic clk;
    input logic rst;
    input logic [DATA_WIDTH-1:0] n_shft_in [NUM_NODES],
    input logic [DATA_WIDTH-1:0] m_shft_in
    );

    logic miso_out, miso_in;
    logic 

    spi_if spi_main_intf_inst #(.NUM_NODES(NUM_NODES), .DATA_WIDTH(DATA_WIDTH)) (
        .miso(miso_in),
        .data_in(m_shift_in),
        //out
        .mosi(),
        .sel(),
        .data_out(),
        .sclk()
    );

    logic [NUM_NODES-1:0] node_sel;

    spi_main main #(NUM_NODES = NUM_NODES, DATA_WIDTH = DATA_WIDTH)  (
        .intf(spi_main_intf_inst)
    );

    assign main.intf.mosi = m_shft_in 

    decoder decoder #(NUM_NODES = NUM_NODES) ( 
        .in(main.intf.sel)
        .out(node_sel)
    );
    
    genvar i;
    generate;
        for (i = 0; i < NUM_NODES; i = i + 1) begin : gen_nodes
            spi_node node #(NUM_NODES = 4, DATA_WIDTH = 8) (
                .intf(intf.node)
                .clk(clk)
                .rst(rst)
            );
            assign node.intf.en = node_sel[i];
            assign node.intf.miso = n_shft_in[i];
            assign node.intf.mosi = 
        end
    endgenerate

endmodule