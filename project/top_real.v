`timescale 1ns / 1ps

module top(
    input clk,  // 125MHz
    input rst,
    input ac_recdat,
    output ac_mclk,
    output ac_bclk,
    output ac_reclrc, // fs 8kHz
	output ac_muten,
	output ac_pbdat,
	output ac_pblrc,
    output is_mosq,
    output led_test,
    output led_test2,
    output led_test3,
    output buzz
    );
    
    wire signed [15:0] din, din_buff;
    wire in_en, ac_pbdat0;
    
    assign ac_muten = 1;
    assign buzz = is_mosq;
    assign ac_pblrc = ac_reclrc;
    assign ac_pbdat = ac_pbdat0 & is_mosq;
    assign led_test = (din_buff > 4'h6fff)|(din_buff < 4'h9000);
    assign led_test3 = (din_buff > 4'h7eff)&(din_buff < 4'h8100);
    
    top_core top_core (
		.din(din),
		.in_en(in_en),
		.clk(ac_reclrc),
		.rst(rst),
		.is_mosq(is_mosq),
		.led_test2(led_test2)
    );
    
    s2p s2p (
		.reclrc(ac_reclrc),
		.clk(ac_bclk),
		.rst(rst),
		.sin(ac_recdat),
		.sout(ac_pbdat0),
		.pout(din)
    );
    
    buff buff (
    	.in(din),
    	.clk(ac_reclrc),
    	.out(din_buff)
    );
    
    freq_div freq_div (
		.clk(clk),          // 125 MHz input clock
		.rst(rst),          // Reset signal
		.bclk(ac_bclk),
		.reclrc(ac_reclrc),	// fs 8kHz
		.mclk(ac_mclk),
		.in_en(in_en)
	);
		
endmodule
