// Day 002 DFF testbench

module day002_tb();
    logic clk;
    logic rst;
    logic d_i;
    logic q_norst_o;
    logic q_syncrst_o;
    logic q_asyncrst_o;

    // Instantiate the UUT
    day002 uut (
        .clk(clk),
        .rst(rst),
        .d_i(d_i),
        .q_norst_o(q_norst_o),
        .q_syncrst_o(q_syncrst_o),
        .q_asyncrst_o(q_asyncrst_o)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    task automatic apply_reset();
        begin
            rst = 1'b1;
            #10;
            rst = 1'b0;
        end
    endtask

    // Stimulus
    initial begin
        d_i = 1'b0;

        // Apply asynchronous reset
        apply_reset();

        // Check non-resetabble flip-flop behavior
        @(posedge clk);
        d_i = 1'b1;
        @(posedge clk);

        // Apply synchronous reset and verify behavior
        d_i = 1'b0;
        apply_reset();

        // Test random input sequences
        repeat (10) begin
            d_i = $urandom() % 2;
            @(posedge clk);
        end

        // Apply asynchronous reset
        @(negedge clk);
        rst = 1'b1;
        #1;
        rst = 1'b0;
        @(posedge clk);

        $finish;
    end

    // Dump waveforms
    initial begin
        $dumpfile("day002.vcd");
        $dumpvars(0, day002_tb);
    end
endmodule
