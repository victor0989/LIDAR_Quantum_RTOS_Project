// Universal Counter - Sequential Circuit Template

// Function Table:
// | syn-clr | load | en | Operation          |
// |---------|------|----|--------------------|
// |   1     |  -   | -  | Synchronous clear  |
// |   0     |  1   | -  | Parallel load      |
// |   0     |  0   | 1  | Count up           |
// |   0     |  0   | 0  | Pause              |

module bin_counter
#(
    parameter N = 8  // Default width of the counter (8 bits)
)
(
    input wire clk,           // Clock signal
    input wire reset,         // Reset signal (asynchronous)
    input wire syn_clr,       // Synchronous clear signal
    input wire load,          // Load enable signal
    input wire en,            // Count enable signal
    input wire [N-1:0] d,     // Input data for parallel load
    output wire max_tick,     // Output flag for maximum count (overflow)
    output wire [N-1:0] q     // Output current counter value
);

    // Constant declaration
    localparam MAX = 2**N - 1;  // Maximum count value for N-bit counter

    // Signal declaration
    reg [N-1:0] r_reg, r_next;  // Register and next-state variables

    // Sequential register process (with asynchronous reset)
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            r_reg <= 0;  // Asynchronous reset: set the counter to 0
        else
            r_reg <= r_next;  // Update the register with the next-state value
    end

    // Next-state logic
    always @*
    begin
        if (syn_clr)
            r_next = 0;  // Synchronous clear: set the counter to 0
        else if (load)
            r_next = d;  // Load operation: load the input value `d`
        else if (en)
            r_next = r_reg + 1;  // Counting up
        else
            r_next = r_reg;  // Pause: maintain the current count
    end

    // Output logic
    assign q = r_reg;  // Output the current value of the register
    assign max_tick = (r_reg == MAX) ? 1'b1 : 1'b0;  // Maximum tick flag

endmodule
