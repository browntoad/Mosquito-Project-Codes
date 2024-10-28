
module FIR (
    input signed [15:0] din,
    input in_en,
    input clk,
    input rst,
    output reg signed [15:0] dout,
    output reg out_en
);

    // Internal register to store the previous input sample
    reg signed [15:0] din_buf;
    reg in_en_buf;

    wire signed [15:0] dout_buf;
    reg out_en_buf;    

    reg signed [15:0] din_d;

    assign dout_buf = din_buf - din_d;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            din_buf <= 0;
            din_d <= 0;

            in_en_buf  <= 0;
            out_en_buf <= 0;
            out_en     <= 0;
            dout <= 0;
        end
        else begin
            din_buf <= din;
            din_d <= din_buf;

            in_en_buf  <= in_en;
            out_en_buf <= in_en_buf;
            out_en     <= out_en_buf;
            dout <= dout_buf;
        end

        
    end

endmodule
