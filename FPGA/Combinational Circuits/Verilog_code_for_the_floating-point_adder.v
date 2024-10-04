module fp_adder 
(
    input wire sign1, sign2,               // Input signs for two floating-point numbers
    input wire [3:0] exp1, exp2,           // 4-bit exponents for the two numbers
    input wire [7:0] frac1, frac2,         // 8-bit fractional parts (mantissas) of the two numbers
    output reg sign_out,                   // Output sign of the result
    output reg [3:0] exp_out,              // 4-bit exponent output
    output reg [7:0] frac_out              // 8-bit fractional part output
);

    // Internal signal declarations
    reg signb, signs;                      // Holds the larger and smaller signs
    reg [3:0] expb, exps, expn, exp_diff;  // Exponents for larger, smaller, normalized numbers
    reg [7:0] fracb, fracs, fraca, fracn, sum_norm;  // Fractional parts
    reg [8:0] sum;                         // 9-bit sum result
    reg [2:0] lead0;                       // To count leading zeros during normalization

    // Always block for performing floating-point addition/subtraction
    always @* begin
        // 1st stage: Sort to find the larger number
        if ({exp1, frac1} > {exp2, frac2}) begin
            // exp1 and frac1 form a larger number
            signb = sign1;
            signs = sign2;
            expb = exp1;
            exps = exp2;
            fracb = frac1;
            fracs = frac2;
        end else begin
            // exp2 and frac2 form a larger number
            signb = sign2;
            signs = sign1;
            expb = exp2;
            exps = exp1;
            fracb = frac2;
            fracs = frac1;
        end

        // 2nd stage: Align the smaller number by shifting its fractional part
        exp_diff = expb - exps;             // Calculate the exponent difference
        fraca = fracs >> exp_diff;          // Align the smaller number by shifting right

        // 3rd stage: Add or subtract the fractional parts based on the sign
        if (signb == signs)
            sum = {1'b0, fracb} + {1'b0, fraca};  // If signs are the same, add
        else
            sum = {1'b0, fracb} - {1'b0, fraca};  // If signs are different, subtract

        // 4th stage: Normalize the result
        // Count leading zeros in the sum to normalize
        if (sum[7]) lead0 = 3'b000;
        else if (sum[6]) lead0 = 3'b001;
        else if (sum[5]) lead0 = 3'b010;
        else if (sum[4]) lead0 = 3'b011;
        else if (sum[3]) lead0 = 3'b100;
        else if (sum[2]) lead0 = 3'b101;
        else if (sum[1]) lead0 = 3'b110;
        else lead0 = 3'b111;

        // Shift the result to remove leading zeros
        sum_norm = sum << lead0;

        // Handle special cases for normalization and final output
        if (sum[8]) begin                   // Handle carry-out by shifting right
            expn = expb + 1;
            fracn = sum[8:1];               // Take the most significant 8 bits
        end else if (lead0 > expb) begin    // If the result is too small to normalize
            expn = 0;
            fracn = 0;
        end else begin                      // Normal case: adjust exponent and fraction
            expn = expb - lead0;
            fracn = sum_norm;
        end

        // Output the result
        sign_out = signb;                   // The result's sign is the same as the larger number
        exp_out = expn;                     // Output the normalized exponent
        frac_out = fracn;                   // Output the normalized fractional part
    end
endmodule
