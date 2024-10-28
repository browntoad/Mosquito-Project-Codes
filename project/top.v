module top_core (
    input [15:0] din,
    input in_en,
    input clk,
    input rst,
    output is_mosq,
    output led_test2
);

    wire [15:0] dout_FIR;
    wire [15:0] dout_FFTr;
    wire [15:0] dout_FFTi;
    wire [30:0] dout_SS;  
    wire [30:0] dout_ACC; 
    wire [30:0] dout_ACC1;
    wire [30:0] dout_ACC2;
    wire [30:0] dout_ACC3;
    wire [30:0] dout_ACC4;
    wire [30:0] dout_ACC5;
    wire [30:0] dout_ACC6;          
    wire [30:0] dout_ACC7;
    wire [30:0] dout_ACC8;
    wire [30:0] dout_ACC9;               
    wire [30:0] dout_ACC10;
    wire [30:0] dout_ACC11;
    wire [30:0] dout_ACC12; 
    wire is_large;

    wire out_en_FIR;
    wire out_en_FFT;  
    wire out_en_SS;   
    wire out_en_ACC;   
    wire out_en_comp;        
    
	assign led_test2 = is_large;

    FIR FIR0 (
        .din(din),
        .in_en(in_en),
        .clk(clk),
        .rst(rst),
        .dout(dout_FIR),
        .out_en(out_en_FIR)
    );

    FFT FFT0 (
        .clock	(clk	   ),
        .reset	(rst	   ),
        .di_en	(out_en_FIR),
        .di_re	(dout_FIR  ),
        .di_im	(16'd0	   ),
        .do_en	(out_en_FFT),
        .do_re	(dout_FFTr ),
        .do_im	(dout_FFTi )
    );

    square_sum SS0 (
        .re(dout_FFTr),
        .im(dout_FFTi),
        .in_en(out_en_FFT),
        .clk(clk),
        .rst(rst),
        .power(dout_SS),
        .out_en(out_en_SS)
    );

    accumulator ACC0 (
        .din(dout_SS),
        .in_en(out_en_SS),
        .clk(clk),
        .rst(rst),
        .dout(dout_ACC),
        .dout1(dout_ACC1),
        .dout2(dout_ACC2),  
        .dout3(dout_ACC3),
        .dout4(dout_ACC4),
        .dout5(dout_ACC5),  
        .dout6(dout_ACC6),                
        .dout7(dout_ACC7),
        .dout8(dout_ACC8),  
        .dout9(dout_ACC9),
        .dout10(dout_ACC10), 
        .dout11(dout_ACC11),
        .dout12(dout_ACC12),                               
        .out_en(out_en_ACC)
    );

    comp comp0 (
        .din  (dout_ACC),
        .din1 (dout_ACC1),
        .din2 (dout_ACC2),  
        .din3 (dout_ACC3),
        .din4 (dout_ACC4),
        .din5 (dout_ACC5),  
        .din6 (dout_ACC6),        
        .din7 (dout_ACC7),
        .din8 (dout_ACC8),
        .din9 (dout_ACC9),
        .din10(dout_ACC10),
        .din11(dout_ACC11),
        .din12(dout_ACC12),
        .in_en(out_en_ACC),
        .clk(clk),
        .is_large(is_large),
        .out_en(out_en_comp)
    );

    Counter CNT0 (
        .is_large(is_large),
        .in_en(out_en_comp),
        .clk(clk),
        .rst(rst),
        .is_mosq(is_mosq)
    );

endmodule