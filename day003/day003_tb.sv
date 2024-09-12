// Day 003 Rising and falling edge detector

module day003_tb();
    // Parameters
    parameter int CLK_PERIOD = 10;

    // Testbench signals
    logic clk;
    logic rst;
    logic a_i;
    logic rising_edge_o;
    logic falling_edge_o;

    // Instantiate the UUT
    day003 uut (
        .clk(clk),
        .rst(rst),
        .a_i(a_i),
        .rising_edge_o(rising_edge_o),
        .falling_edge_o(falling_edge_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Stimulus generation
    initial begin
        rst = 1;
        a_i = 0;

        // Apply reset
        @(posedge clk);
        rst = 0;

        // Test: Random stimulus for `a_i`
        repeat (10) begin
            a_i = $urandom() % 2;
            @(posedge clk);
        end

        // Final test case: Check known edge
        a_i = 1; @(posedge clk); // Rising edge
        a_i = 0; @(posedge clk); // Falling edge

        // End the simulation
        $finish;
    end

    // Dump waveform to VCD
    initial begin
        $dumpfile("day003.vcd");
        $dumpvars(0, day003_tb);
    end
endmodule
