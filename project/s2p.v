`timescale 1ns / 1ps

module s2p(
    input reclrc,
    input clk,
    input rst,
    input sin,
    output reg sout,
    output reg [15:0] pout
    );
    
    integer i;
    
    reg [9:0] counter;
    reg reclrc_d;
    reg [9:0] cnt_tone;
    
    always @(posedge clk) begin
    	reclrc_d <= reclrc;
    end    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 10'd1023;
            cnt_tone <= 0;
        end else begin
            if (reclrc & ~reclrc_d) begin
                counter <= 10'd15;
                cnt_tone <= cnt_tone + 10'd1;
			end else if (reclrc) begin
                counter <= counter - 1;    
                cnt_tone <= cnt_tone;
            end else begin
                counter <= counter;
                cnt_tone <= cnt_tone;
            end
        end
        
        if (rst) begin
			pout <= 0;
        end else if (reclrc & (counter <= 10'd15)) begin
        	for (i = 0; i <= 15; i = i + 1) begin
				if (counter == i) begin
					pout[i] <= sin;
				end else begin
					pout[i] <= pout[i];
				end
        	end
        end else begin
            pout <= pout;
        end
        
        if (rst) begin
			sout <= 0;
        end else if (reclrc) begin
			sout <= cnt_tone[2];
        end else begin
            sout <= ~cnt_tone[2];
        end      
    end
endmodule
