`timescale 1ns / 1ps

module buff(
    input [15:0] in,
    input clk,
    output reg [15:0] out
    );
    
    always @(posedge clk) begin
    	out <= in;
    end
endmodule
