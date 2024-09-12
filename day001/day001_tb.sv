// Testbench for parameterized 2:1 mux

module day001_tb();
    parameter int WIDTH = 8;
    // Signals
    logic [WIDTH-1:0] a_i;
    logic [WIDTH-1:0] b_i;
    logic sel;
    logic [WIDTH-1:0] y_o;

    // Instantiate the mux
    day001 #(.WIDTH(WIDTH)) uut (
        .a_i(a_i),
        .b_i(b_i),
        .sel(sel),
        .y_o(y_o)
    );

    // Random test case
    initial begin
        for (int i = 0; i < 10; i++) begin
            a_i = $urandom_range(0, $urandom_range(0, 8'hFF));
            b_i = $urandom_range(0, $urandom_range(0, 8'hFF));
            sel = $urandom() % 2;
            #5;
        end
    end

    // Directed test cases
    initial begin
        // Test 1: a_i = 0x00, b_i = 0xFF, sel = 0
        a_i = 8'h00; b_i = 8'hFF; sel = 0; #5;
        // Test 2: a_i = 0xFF, b_i = 0x00, sel = 1
        a_i = 8'hFF; b_i = 8'h00; sel = 1; #5;
        // Test 3: a_i = 0xAA, b_i = 0x55, sel = 0
        a_i = 8'hAA; b_i = 8'h55; sel = 0; #5;
        // Test 4: a_i = 0x55, b_i = 0xAA, sel = 1
        a_i = 8'h55; b_i = 8'hAA; sel = 1; #5;
    end

    // Assertion to check correctness
    always @(a_i or b_i or sel) begin
        assert (y_o === (sel ? a_i : b_i)) else
        $error("Mismatch at time %t: y_o = %h, expected = %h", $time, y_o, (sel ? a_i : b_i));
    end

    // Dumb the waveform for debugging
    initial begin
        $dumpfile("day001.vcd");
        $dumpvars(0, day001_tb);
    end
endmodule
