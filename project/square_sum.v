module square_sum (
    input signed [15:0] re,
    input signed [15:0] im,
    input in_en,
    input clk,
    input rst,
    output reg [30:0] power,
    output reg out_en
);
    reg signed [15:0] re_buf;
    reg signed [15:0] im_buf;
    reg in_en_buf;

    wire [30:0] power_buf;
    reg out_en_buf;

    wire signed [31:0] re_sq_next;
    wire signed [31:0] im_sq_next;

    reg [30:0] re_sq;
    reg [30:0] im_sq;

    // Calculate squares of real and imaginary parts
    assign re_sq_next = re_buf * re_buf;
    assign im_sq_next = im_buf * im_buf;

    // Calculate the sum of the squares
    assign power_buf = re_sq + im_sq;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            in_en_buf  <= 0;
            out_en_buf <= 0;
            out_en     <= 0;
        end
        else begin
            in_en_buf  <= in_en;
            out_en_buf <= in_en_buf;
            out_en     <= out_en_buf;
        end
    end
    
    always @(posedge clk) begin
        re_sq <= re_sq_next;
        im_sq <= im_sq_next;

        re_buf <= re;
        im_buf <= im;

        power <= power_buf;
    end
endmodule
