
module spi_top #(parameter NUM_NODES = 4, DATA_WIDTH = 8, CPOL = 0, CPHA = 0) (
    input logic clk;
    input logic rst;
    input logic [DATA_WIDTH-1:0] n_shft_in [NUM_NODES],
    input logic [DATA_WIDTH-1:0] m_shft_in
    );

    logic sclk, mosi;

    logic [NUM_NODES-1:0] miso;

    logic [$clog2(NUM_NODES)-1:0] sel; 

    logic [NUM_NODES-1:0] node_sel;

// MAIN INSTANTIATION -------------------------------------------

    spi_if spi_intf_inst (
        .clk(clk)
    );

    spi_main main #(.NUM_NODES(NUM_NODES), .DATA_WIDTH(DATA_WIDTH), .CPOL(CPOL), .CPHA(CPHA))(
        spi_intf_inst.main,
        //in 
        .data_in(m_shift_in),
        .miso(miso),
        //out
        .sel(sel)
    );

// --------------------------------------------------------------

// NODE INSTANTIATION -------------------------------------------
    
    genvar i;
    generate for (i = 0; i < NUM_NODES; i = i + 1) begin : gen_node 

        spi_node node #(.NUM_NODES(NUM_NODES), .DATA_WIDTH(DATA_WIDTH), .CPOL(CPOL), .CPHA(CPHA)) (
            spi_intf_inst.node,
            //in
            .data_in(n_shift_in[i]),
            .sel(node_sel[i]),
            //out
            .miso(miso[i])
        );

    end
    endgenerate

// --------------------------------------------------------------

// DECODER INSTANTIATION ----------------------------------------

    decoder decoder #(.NUM_NODES(NUM_NODES)) ( 
        .in(main.intf.sel)
        .out(node_sel)
    );

// --------------------------------------------------------------


endmodule