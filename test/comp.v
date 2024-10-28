
module comp (
    input [30:0] din,
    input [30:0] din1,
    input [30:0] din2,
    input [30:0] din3,
    input [30:0] din4,
    input [30:0] din5,
    input [30:0] din6,        
    input [30:0] din7,
    input [30:0] din8,
    input [30:0] din9,
    input [30:0] din10,
    input [30:0] din11,
    input [30:0] din12,
    input in_en,
    input clk,
    output reg is_large,
    output reg out_en
);

    wire [5:0] is_large_p;
    wire [5:0] max_tone [0:5];
    wire [5:0] max_tone_n;

    assign max_tone_n[0] = &max_tone[0];
    assign max_tone_n[1] = &max_tone[1];
    assign max_tone_n[2] = &max_tone[2];
    assign max_tone_n[3] = &max_tone[3];
    assign max_tone_n[4] = &max_tone[4];
    assign max_tone_n[5] = &max_tone[5];

    assign is_large_p[0] = (din7  > 8 * (din - din7 ));
    assign is_large_p[1] = (din8  > 8 * (din - din8 ));
    assign is_large_p[2] = (din9  > 8 * (din - din9 ));
    assign is_large_p[3] = (din10 > 8 * (din - din10));
    assign is_large_p[4] = (din11 > 8 * (din - din11));
    assign is_large_p[5] = (din12 > 8 * (din - din12));

    assign max_tone[0][0] = (din7  > din1);
    assign max_tone[0][1] = (din7  > din2);
    assign max_tone[0][2] = (din7  > din3);
    assign max_tone[0][3] = (din7  > din4);
    assign max_tone[0][4] = (din7  > din5);
    assign max_tone[0][5] = (din7  > din6);    

    assign max_tone[1][0] = (din8  > din1);
    assign max_tone[1][1] = (din8  > din2);
    assign max_tone[1][2] = (din8  > din3);
    assign max_tone[1][3] = (din8  > din4);
    assign max_tone[1][4] = (din8  > din5);
    assign max_tone[1][5] = (din8  > din6); 

    assign max_tone[2][0] = (din9  > din1);
    assign max_tone[2][1] = (din9  > din2);
    assign max_tone[2][2] = (din9  > din3);
    assign max_tone[2][3] = (din9  > din4);
    assign max_tone[2][4] = (din9  > din5);
    assign max_tone[2][5] = (din9  > din6); 

    assign max_tone[3][0] = (din10 > din1);
    assign max_tone[3][1] = (din10 > din2);
    assign max_tone[3][2] = (din10 > din3);
    assign max_tone[3][3] = (din10 > din4);
    assign max_tone[3][4] = (din10 > din5);
    assign max_tone[3][5] = (din10 > din6); 

    assign max_tone[4][0] = (din11 > din1);
    assign max_tone[4][1] = (din11 > din2);
    assign max_tone[4][2] = (din11 > din3);
    assign max_tone[4][3] = (din11 > din4);
    assign max_tone[4][4] = (din11 > din5);
    assign max_tone[4][5] = (din11 > din6); 

    assign max_tone[5][0] = (din12 > din1);
    assign max_tone[5][1] = (din12 > din2);
    assign max_tone[5][2] = (din12 > din3);
    assign max_tone[5][3] = (din12 > din4);
    assign max_tone[5][4] = (din12 > din5);
    assign max_tone[5][5] = (din12 > din6); 

    always @(posedge clk) begin
        is_large <= (|is_large_p)&(|max_tone_n);
        out_en <= in_en;
    end
endmodule
