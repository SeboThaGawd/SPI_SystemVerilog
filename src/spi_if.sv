interface spi_if #(int NUM_NODES)
(input clk);

    logic miso;
    logic mosi;
    logic [$clog2(NUM_NODES) - 1: 0] sel;
    logic en;

    modport node (
        output miso;
        input mosi;
        input en;
    );

    modport main (
        input miso;
        output mosi;
        input sel;
    );

endinterface