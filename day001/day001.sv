// Day 001 of 100 Days of RTL
module day001 #(parameter int WIDTH = 8) (
    input wire [WIDTH-1:0] a_i,   // First leg of the 2:1 mux
    input wire [WIDTH-1:0] b_i,   // Second leg of the 2:1 mux
    input wire sel,             // Select signal
    output reg [WIDTH-1:0] y_o   // Output of the 2:1 mux
);
    // Always block for output assignment
    always_comb begin
        if (sel)
            y_o = a_i;
        else
            y_o = b_i;
    end
endmodule
