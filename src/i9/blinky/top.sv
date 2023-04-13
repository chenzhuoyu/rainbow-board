module top (
    input  wire       osc_clk_in,
    output wire       led_1,
    output wire [2:0] mux_sel,
);
    reg [24:0] ctr;

    assign led_1   = ctr[24];
    assign mux_sel = 3'd0;

    always @(posedge osc_clk_in) begin
        ctr <= ctr + 1;
    end
endmodule