
`timescale 1ns/1ns

module decoder_tb();
    localparam CLK_FREQ   = 100_000_000;
    localparam CLK_PERIOD = 1_000_000_000 / CLK_FREQ;
  
  	logic clk;

    initial begin
        clk = 1'b0;
    end

    always #(CLK_PERIOD / 2) begin
        clk = ~clk;
    end

    localparam NUM_NODES = 8;

    logic [2:0] dut_in;
    logic [7:0] dut_out;

    decoder #(NUM_NODES) dut (
        .in(dut_in),
        .out(dut_out)
    );

    initial begin
        $dumpfile("dump.vcd"); $dumpvars;        
        
        dut_in = 0;

        @(posedge clk);

        assert(dut_out == 8'b00000001);

        dut_in = 1;

        @(posedge clk);

        assert(dut_out == 8'b00000010);

        dut_in = 2;

        @(posedge clk);

        assert(dut_out == 8'b00000100);

        dut_in = 3;

        @(posedge clk);

        assert(dut_out == 8'b00001000);

        dut_in = 4;

        @(posedge clk);

        assert(dut_out == 8'b00010000);

        dut_in = 5;

        @(posedge clk);

        assert(dut_out == 8'b00100000);

        dut_in = 6;

        @(posedge clk);

        assert(dut_out == 8'b01000000);

        dut_in = 7;

        @(posedge clk);

        assert(dut_out == 8'b10000000);
      
      	$finish;

    end
    
endmodule