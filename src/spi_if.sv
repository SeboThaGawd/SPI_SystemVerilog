interface spi_intf (input clk);

    logic mosi, sclk;

    modport node (input mosi, sclk, output miso);

    modport main (input clk, output mosi, sclk);

endinterface: spi_intf