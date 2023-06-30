
module decoder #(parameter int NUM_NODES = 4) (
    input logic [$clog2(NUM_NODES)-1:0] in,
    output logic [NUM_NODES-1:0] out
);

genvar i;
generate;
    for (i = 0; i < NUM_NODES; i = i + 1) begin : gen_dec
        assign out[i] = in == i ? 1 : 0;
    end
endgenerate

endmodule