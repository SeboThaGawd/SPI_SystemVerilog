
module spi_top #(parameter NUM_NODES = 4, DATA_WIDTH = 8) (
    input logic clk;
    input logic rst;
    input logic [DATA_WIDTH-1:0] n_shft_in [NUM_NODES],
    input logic [DATA_WIDTH-1:0] m_shft_in
    );

    spi_if #(.NUM_NODES(NUM_NODES)) intf();

    logic [NUM_NODES-1:0] node_sel;

    spi_main main (
        .intf(intf.main)
        .clk(clk)
        .rst(rst)
    );

    assign main.intf.mosi = m_shft_in 

    decoder decoder (
        .in(intf.main.ns)
        .out(node_sel)
    );
    
    genvar i;
    generate;
        for (i = 0; i < NUM_NODES; i = i + 1) begin : gen_nodes
            spi_node node (
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