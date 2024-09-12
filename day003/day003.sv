// Day 003 Falling edge detector

module day003 (
    input wire clk,
    input wire rst,
    input wire a_i,
    output wire rising_edge_o,
    output wire falling_edge_o
);

    logic a_ff;

    // Synchronous process with reset
    always_ff @(posedge clk) begin
        if (rst)
            a_ff <= 1'b0;
        else
            a_ff <= a_i;
    end

    // Rising edge detection: previous value is 0, current is 1
    assign rising_edge_o = ~a_ff & a_i;

    // Falling edge detection: previous value is 1, current is 0
    assign falling_edge_o = a_ff & ~a_i;

endmodule
