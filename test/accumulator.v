
module accumulator (
    input [30:0] din,
    input in_en,
    input clk,
    input rst,
    output reg [30:0] dout,
    output reg [30:0] dout1,
    output reg [30:0] dout2,
    output reg [30:0] dout3,    
    output reg [30:0] dout4,
    output reg [30:0] dout5,
    output reg [30:0] dout6,    
    output reg [30:0] dout7,
    output reg [30:0] dout8,
    output reg [30:0] dout9,
    output reg [30:0] dout10,
    output reg [30:0] dout11,
    output reg [30:0] dout12,
    output reg out_en
);

    reg [30:0] din_buf;
    reg        in_en_buf;

    // Internal register to store the accumulated sum
    reg [30:0] sum;
    reg [30:0] sum_next;
    reg [30:0] sum1;
    reg [30:0] sum1_next;
    reg [30:0] sum2;
    reg [30:0] sum2_next;    
    reg [30:0] sum3;
    reg [30:0] sum3_next;
    reg [30:0] sum4;
    reg [30:0] sum4_next;
    reg [30:0] sum5;
    reg [30:0] sum5_next;    
    reg [30:0] sum6;
    reg [30:0] sum6_next;        
    reg [30:0] sum7;
    reg [30:0] sum7_next;
    reg [30:0] sum8;
    reg [30:0] sum8_next;    
    reg [30:0] sum9;
    reg [30:0] sum9_next;
    reg [30:0] sum10;
    reg [30:0] sum10_next; 
    reg [30:0] sum11;
    reg [30:0] sum11_next;
    reg [30:0] sum12;
    reg [30:0] sum12_next;             
    reg [6:0]  cnt;

    always @(posedge clk) begin
        if (rst) begin
            cnt <= 0;
        end else if (in_en_buf) begin
            cnt <= cnt + 7'b1;
        end else begin
            cnt <= cnt;
        end

        if (rst) begin
            dout   <= 31'd0;
            dout1  <= 31'd0;
            dout2  <= 31'd0;
            dout3  <= 31'd0;
            dout4  <= 31'd0;
            dout5  <= 31'd0;
            dout6  <= 31'd0;                        
            dout7  <= 31'd0;
            dout8  <= 31'd0;
            dout9  <= 31'd0;
            dout10 <= 31'd0;
            dout11 <= 31'd0;
            dout12 <= 31'd0;            
            out_en <= 0;
        end else if (cnt == 7'b1110_001) begin
            dout   <= sum;
            dout1  <= sum1;
            dout2  <= sum2;
            dout3  <= sum3;
            dout4  <= sum4;
            dout5  <= sum5;
            dout6  <= sum6;                        
            dout7  <= sum7;
            dout8  <= sum8;
            dout9  <= sum9;
            dout10 <= sum10;
            dout11 <= sum11;
            dout12 <= sum12;            
            out_en <= 1;
        end else begin
            dout   <= dout;
            dout1  <= dout1;
            dout2  <= dout2;
            dout3  <= dout3;
            dout4  <= dout4;
            dout5  <= dout5;
            dout6  <= dout6;            
            dout7  <= dout7;
            dout8  <= dout8;
            dout9  <= dout9;
            dout10 <= dout10;
            dout11 <= dout11;
            dout12 <= dout12;            
            out_en <= 0;
        end

        if (rst) begin
            sum <= 0;
            sum1 <= 0;
            sum2 <= 0;
            sum3 <= 0;
            sum4 <= 0;
            sum5 <= 0;
            sum6 <= 0;                        
            sum7 <= 0;
            sum8 <= 0;
            sum9 <= 0;
            sum10 <= 0;
            sum11 <= 0;
            sum12 <= 0;                                           
        end else if (in_en_buf) begin
            sum <= sum_next;
            sum1  <= sum1_next;
            sum2  <= sum2_next;
            sum3  <= sum3_next;            
            sum4  <= sum4_next;
            sum5  <= sum5_next;
            sum6  <= sum6_next;           
            sum7  <= sum7_next;
            sum8  <= sum8_next;
            sum9  <= sum9_next;
            sum10 <= sum10_next;
            sum11 <= sum11_next;
            sum12 <= sum12_next;            
        end else begin 
            sum   <= sum  ;
            sum1  <= sum1 ;
            sum2  <= sum2 ;
            sum3  <= sum3 ;
            sum4  <= sum4 ;
            sum5  <= sum5 ;
            sum6  <= sum6 ;            
            sum7  <= sum7 ;
            sum8  <= sum8 ;
            sum9  <= sum9 ;
            sum10 <= sum10;
            sum11 <= sum11;
            sum12 <= sum12;             
        end

        din_buf <= din;
        in_en_buf <= in_en;
    end

    always @* begin
        case (cnt)
            7'b0000_000, 7'b1000_000, 7'b0100_000, 7'b1100_000, 7'b0010_000, 7'b1010_000, 7'b0110_000, 7'b1110_000, 7'b0001_000, 7'b1001_000, 7'b0101_000, 7'b1101_000, 7'b0011_000: begin
                // Accumulate input value
                sum_next = sum + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum_next = 0;
            end
            default: sum_next = sum;
        endcase

        case (cnt)
            7'b0000_000, 7'b1000_000, 7'b0100_000: begin
                // Accumulate input value
                sum1_next = sum1 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum1_next = 0;
            end
            default: sum1_next = sum1;
        endcase

        case (cnt)
            7'b1000_000, 7'b0100_000, 7'b1100_000: begin
                // Accumulate input value
                sum2_next = sum2 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum2_next = 0;
            end
            default: sum2_next = sum2;
        endcase

        case (cnt)
            7'b0100_000, 7'b1100_000, 7'b0010_000: begin
                // Accumulate input value
                sum3_next = sum3 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum3_next = 0;
            end
            default: sum3_next = sum3;
        endcase

        case (cnt)
            7'b1100_000, 7'b0010_000, 7'b1010_000: begin
                // Accumulate input value
                sum4_next = sum4 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum4_next = 0;
            end
            default: sum4_next = sum4;
        endcase

        case (cnt)
            7'b0010_000, 7'b1010_000, 7'b0110_000: begin
                // Accumulate input value
                sum5_next = sum5 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum5_next = 0;
            end
            default: sum5_next = sum5;
        endcase

        case (cnt)
            7'b1010_000, 7'b0110_000, 7'b1110_000: begin
                // Accumulate input value
                sum6_next = sum6 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum6_next = 0;
            end
            default: sum6_next = sum6;
        endcase

        case (cnt)
            7'b0110_000, 7'b1110_000, 7'b0001_000: begin
                // Accumulate input value
                sum7_next = sum7 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum7_next = 0;
            end
            default: sum7_next = sum7;
        endcase

        case (cnt)
            7'b1110_000, 7'b0001_000, 7'b1001_000: begin
                // Accumulate input value
                sum8_next = sum8 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum8_next = 0;
            end
            default: sum8_next = sum8;
        endcase   
        case (cnt)
            7'b0001_000, 7'b1001_000, 7'b0101_000: begin
                // Accumulate input value
                sum9_next = sum9 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum9_next = 0;
            end
            default: sum9_next = sum9;
        endcase

        case (cnt)
            7'b1001_000, 7'b0101_000, 7'b1101_000: begin
                // Accumulate input value
                sum10_next = sum10 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum10_next = 0;
            end
            default: sum10_next = sum10;
        endcase  

        case (cnt)
            7'b0101_000, 7'b1101_000, 7'b0011_000: begin
                // Accumulate input value
                sum11_next = sum11 + din_buf;
            end
            7'b1110_001 : begin
                // Accumulate input value
                sum11_next = 0;
            end
            default: sum11_next = sum11;
        endcase

        case (cnt)

            7'b1110_001 : begin
                // Accumulate input value
                sum12_next = 0;
            end
            default: sum12_next = sum12;
        endcase                               
    end

endmodule
