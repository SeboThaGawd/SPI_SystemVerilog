interface spi_intf #(
    parameter NUM_NODES = 4,
    DATA_WIDTH = 8
    ) 
    (input clk, rst);

    logic miso, mosi, en, sclk;
    logic [$clog2(NUM_NODES) - 1: 0] sel;
    logic [DATA_WIDTH-1:0] data_in, data_out;

    modport node (input data_in, mosi, en, sclk, rst, output miso, data_out);

    modport main (input miso, data_in, clk, rst output mosi, sel, data_out, sclk);

endinterface: spi_intf