
module Counter (
    input is_large,
    input in_en,
    input clk,
    input rst,
    output reg is_mosq
);

    reg [4:0] cnt;
    reg [8:0] cnt2;    

    always @(posedge clk) begin
        if (rst) begin
            cnt <= 0;
        end else if (in_en) begin
            if (is_large) begin
                cnt <= cnt + 5'd1;
            end else begin
                cnt <= 0;
            end
        end else begin
            cnt <= cnt;
        end

        if (rst) begin
            cnt2 <= 0;
        end else if (in_en) begin
            if (is_mosq) begin
                cnt2 <= cnt2 + 9'd1;
            end else begin
                cnt2 <= 0;
            end
        end else begin
            cnt2 <= cnt2;
        end

        if (rst) begin
            is_mosq <= 0;
        end else if (cnt >= 5'd10) begin
            is_mosq <= 1;
        end else if (cnt2 >= 9'd500) begin
            is_mosq <= 0;            
        end else begin
            is_mosq <= is_mosq;
        end

    end
endmodule
