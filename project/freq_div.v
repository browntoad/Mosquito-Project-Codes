`timescale 1ns / 1ps

module freq_div(
    input clk,          // 125 MHz input clock
    input rst,          // Reset signal
    output reg bclk,     
    output reg reclrc,        // fs 8 kHz
    output reg mclk,
    output reg in_en
);

    // Calculate the division factors
    localparam MCLK_DIVISOR = 10;
    localparam BCLK_DIVISOR = 40;
    localparam RECLRC_DIVISOR = 15360;

    // Registers to hold the counters
    reg [15:0] mclk_counter;
    reg [15:0] bclk_counter;
    reg [15:0] reclrc_counter;
	reg [15:0] in_en_counter;
	reg reclrc_d;

    always @(posedge clk) begin
    	reclrc_d <= reclrc;
    end    	
    
    always @(posedge clk or posedge rst) begin   
        if (rst) begin
            mclk_counter <= 0;
            mclk <= 0;
        end else begin
            if (mclk_counter == (MCLK_DIVISOR / 2 - 1)) begin
                mclk <= ~mclk;
                mclk_counter <= 0;
            end else begin
                mclk_counter <= mclk_counter + 1;
            end
        end     
        	
        if (rst) begin
            bclk_counter <= 0;
            bclk <= 0;
        end else begin
            if (bclk_counter == (BCLK_DIVISOR / 2 - 1)) begin
                bclk <= ~bclk;
                bclk_counter <= 0;
            end else begin
                bclk_counter <= bclk_counter + 1;
            end
        end

        if (rst) begin
            reclrc_counter <= 0;
            reclrc <= 0;
        end else begin
            if (reclrc_counter == (RECLRC_DIVISOR / 2 - 1)) begin
                reclrc <= ~reclrc;
                reclrc_counter <= 0;
            end else begin
                reclrc_counter <= reclrc_counter + 1;
            end
        end
        
        if (rst) begin
            in_en_counter <= 0;
            in_en <= 0;
        end else begin
            if (~reclrc_d & reclrc) begin
                in_en_counter <= in_en_counter + 1;
            end else begin
                in_en_counter <= in_en_counter;
            end
        	
            if (in_en_counter == 8000) begin
                in_en <= 1;
            end else begin
                in_en <= in_en;
            end
        end
    end
    

endmodule
