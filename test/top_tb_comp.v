`timescale	1ns/1ns
module top_tb;

    //	Internal Regs and Nets
    reg	 clk;
    reg	 rst;
    reg [15:0] din;
    wire in_en;
    wire is_mosq;

    // localparam N = 5000;
    localparam N = 24000;    
    integer fp;

    reg signed [15:0] in_mem[0:N-1];

    assign in_en = ~rst;

    top DUT (
        .din(din),
        .in_en(in_en),
        .clk(clk),
        .rst(rst),
        .is_mosq(is_mosq)
    );

//----------------------------------------------------------------------
//	Clock and Reset
//----------------------------------------------------------------------
    initial begin
        clk <= 1;
        rst <= 1;
        forever #5 clk <= ~clk;
    end

    // initial begin
    //     $fsdbDumpfile("top.fsdb");
    //     $fsdbDumpvars("+mda");
    // end

//----------------------------------------------------------------------
//	Tasks
//----------------------------------------------------------------------

    task GenerateInputWave;
        input[80*8:1] filename;
        input[63:0] case_idx;
        integer n;
    begin
        $readmemh(filename, in_mem);

        @(posedge clk);
        rst <= 0;

        for (n = 0; n < N; n = n + 1) begin
            din <= (in_mem[n]/16);
            @(posedge clk);
        end
        
        din <= 0;

        repeat(500) @(posedge clk);
        $display("Test case %d: is_mosq = %d", case_idx, is_mosq);
        rst <= 1;
        fp = fp + is_mosq;
        repeat(10) @(posedge clk);
    end
    endtask

    initial begin
        repeat(10) @(posedge clk);
        fp = 0;
        GenerateInputWave("../pat/comp/comp_001.txt", 000);
        GenerateInputWave("../pat/comp/comp_002.txt", 001);    
        GenerateInputWave("../pat/comp/comp_003.txt", 002);             
        GenerateInputWave("../pat/comp/comp_004.txt", 003);
        GenerateInputWave("../pat/comp/comp_005.txt", 004);    
        GenerateInputWave("../pat/comp/comp_006.txt", 005);
        GenerateInputWave("../pat/comp/comp_007.txt", 006);
        GenerateInputWave("../pat/comp/comp_008.txt", 007);    
        GenerateInputWave("../pat/comp/comp_009.txt", 008);             
        GenerateInputWave("../pat/comp/comp_010.txt", 009);
        GenerateInputWave("../pat/comp/comp_011.txt", 010);    
        GenerateInputWave("../pat/comp/comp_012.txt", 011);
        GenerateInputWave("../pat/comp/comp_013.txt", 012);
        GenerateInputWave("../pat/comp/comp_014.txt", 013);    
        GenerateInputWave("../pat/comp/comp_015.txt", 014);             
        GenerateInputWave("../pat/comp/comp_016.txt", 015);
        GenerateInputWave("../pat/comp/comp_017.txt", 016);    
        GenerateInputWave("../pat/comp/comp_018.txt", 017);
        GenerateInputWave("../pat/comp/comp_019.txt", 018);
        GenerateInputWave("../pat/comp/comp_020.txt", 019);    
        GenerateInputWave("../pat/comp/comp_021.txt", 020);             
        GenerateInputWave("../pat/comp/comp_022.txt", 021);
        GenerateInputWave("../pat/comp/comp_023.txt", 022);    
        GenerateInputWave("../pat/comp/comp_024.txt", 023);
        GenerateInputWave("../pat/comp/comp_025.txt", 024);
        GenerateInputWave("../pat/comp/comp_026.txt", 025);    
        GenerateInputWave("../pat/comp/comp_027.txt", 026);             
        GenerateInputWave("../pat/comp/comp_028.txt", 027);
        GenerateInputWave("../pat/comp/comp_029.txt", 028);    
        GenerateInputWave("../pat/comp/comp_030.txt", 029);
        GenerateInputWave("../pat/comp/comp_031.txt", 030);
        GenerateInputWave("../pat/comp/comp_032.txt", 031);    
        GenerateInputWave("../pat/comp/comp_033.txt", 032);             
        GenerateInputWave("../pat/comp/comp_034.txt", 033);
        GenerateInputWave("../pat/comp/comp_035.txt", 034);    
        GenerateInputWave("../pat/comp/comp_036.txt", 035);
        GenerateInputWave("../pat/comp/comp_037.txt", 036);
        GenerateInputWave("../pat/comp/comp_038.txt", 037);    
        GenerateInputWave("../pat/comp/comp_039.txt", 038);             
        GenerateInputWave("../pat/comp/comp_040.txt", 039);
        GenerateInputWave("../pat/comp/comp_041.txt", 040);    
        GenerateInputWave("../pat/comp/comp_042.txt", 041);
        GenerateInputWave("../pat/comp/comp_043.txt", 042);
        GenerateInputWave("../pat/comp/comp_044.txt", 043);    
        GenerateInputWave("../pat/comp/comp_045.txt", 044);             
        GenerateInputWave("../pat/comp/comp_046.txt", 045);
        GenerateInputWave("../pat/comp/comp_047.txt", 046);    
        GenerateInputWave("../pat/comp/comp_048.txt", 047);
        GenerateInputWave("../pat/comp/comp_049.txt", 048);
        GenerateInputWave("../pat/comp/comp_050.txt", 049);    
        GenerateInputWave("../pat/comp/comp_051.txt", 050);
        GenerateInputWave("../pat/comp/comp_052.txt", 051);    
        GenerateInputWave("../pat/comp/comp_053.txt", 052);             
        GenerateInputWave("../pat/comp/comp_054.txt", 053);
        GenerateInputWave("../pat/comp/comp_055.txt", 054);    
        GenerateInputWave("../pat/comp/comp_056.txt", 055);
        GenerateInputWave("../pat/comp/comp_057.txt", 056);
        GenerateInputWave("../pat/comp/comp_058.txt", 057);    
        GenerateInputWave("../pat/comp/comp_059.txt", 058);             
        GenerateInputWave("../pat/comp/comp_060.txt", 059);
        GenerateInputWave("../pat/comp/comp_061.txt", 060);    
        GenerateInputWave("../pat/comp/comp_062.txt", 061);
        GenerateInputWave("../pat/comp/comp_063.txt", 062);
        GenerateInputWave("../pat/comp/comp_064.txt", 063);    
        GenerateInputWave("../pat/comp/comp_065.txt", 064);             
        GenerateInputWave("../pat/comp/comp_066.txt", 065);
        GenerateInputWave("../pat/comp/comp_067.txt", 066);    
        GenerateInputWave("../pat/comp/comp_068.txt", 067);
        GenerateInputWave("../pat/comp/comp_069.txt", 068);
        GenerateInputWave("../pat/comp/comp_070.txt", 069);    
        GenerateInputWave("../pat/comp/comp_071.txt", 070);             
        GenerateInputWave("../pat/comp/comp_072.txt", 071);
        GenerateInputWave("../pat/comp/comp_073.txt", 072);    
        GenerateInputWave("../pat/comp/comp_074.txt", 073);
        GenerateInputWave("../pat/comp/comp_075.txt", 074);
        GenerateInputWave("../pat/comp/comp_076.txt", 075);    
        GenerateInputWave("../pat/comp/comp_077.txt", 076);             
        GenerateInputWave("../pat/comp/comp_078.txt", 077);
        GenerateInputWave("../pat/comp/comp_079.txt", 078);    
        GenerateInputWave("../pat/comp/comp_080.txt", 079);
        GenerateInputWave("../pat/comp/comp_081.txt", 080);
        GenerateInputWave("../pat/comp/comp_082.txt", 081);    
        GenerateInputWave("../pat/comp/comp_083.txt", 082);             
        GenerateInputWave("../pat/comp/comp_084.txt", 083);
        GenerateInputWave("../pat/comp/comp_085.txt", 084);    
        GenerateInputWave("../pat/comp/comp_086.txt", 085);
        GenerateInputWave("../pat/comp/comp_087.txt", 086);
        GenerateInputWave("../pat/comp/comp_088.txt", 087);    
        GenerateInputWave("../pat/comp/comp_089.txt", 088);             
        GenerateInputWave("../pat/comp/comp_090.txt", 089);
        GenerateInputWave("../pat/comp/comp_091.txt", 090);    
        GenerateInputWave("../pat/comp/comp_092.txt", 091);
        GenerateInputWave("../pat/comp/comp_093.txt", 092);
        GenerateInputWave("../pat/comp/comp_094.txt", 093);    
        GenerateInputWave("../pat/comp/comp_095.txt", 094);             
        GenerateInputWave("../pat/comp/comp_096.txt", 095);
        GenerateInputWave("../pat/comp/comp_097.txt", 096);    
        GenerateInputWave("../pat/comp/comp_098.txt", 097);
        GenerateInputWave("../pat/comp/comp_099.txt", 098);
        GenerateInputWave("../pat/comp/comp_100.txt", 099); 
        GenerateInputWave("../pat/comp/comp_101.txt", 100);
        GenerateInputWave("../pat/comp/comp_102.txt", 101);    
        GenerateInputWave("../pat/comp/comp_103.txt", 102);             
        GenerateInputWave("../pat/comp/comp_104.txt", 103);
        GenerateInputWave("../pat/comp/comp_105.txt", 104);    
        GenerateInputWave("../pat/comp/comp_106.txt", 105);
        GenerateInputWave("../pat/comp/comp_107.txt", 106);
        GenerateInputWave("../pat/comp/comp_108.txt", 107);    
        GenerateInputWave("../pat/comp/comp_109.txt", 108);             
        GenerateInputWave("../pat/comp/comp_110.txt", 109);
        GenerateInputWave("../pat/comp/comp_111.txt", 110);    
        GenerateInputWave("../pat/comp/comp_112.txt", 111);
        GenerateInputWave("../pat/comp/comp_113.txt", 112);
        GenerateInputWave("../pat/comp/comp_114.txt", 113);    
        GenerateInputWave("../pat/comp/comp_115.txt", 114);             
        GenerateInputWave("../pat/comp/comp_116.txt", 115);
        GenerateInputWave("../pat/comp/comp_117.txt", 116);    
        GenerateInputWave("../pat/comp/comp_118.txt", 117);
        GenerateInputWave("../pat/comp/comp_119.txt", 118);
        GenerateInputWave("../pat/comp/comp_120.txt", 119);    
        GenerateInputWave("../pat/comp/comp_121.txt", 120);             
        GenerateInputWave("../pat/comp/comp_122.txt", 121);
        GenerateInputWave("../pat/comp/comp_123.txt", 122);    
        GenerateInputWave("../pat/comp/comp_124.txt", 123);
        GenerateInputWave("../pat/comp/comp_125.txt", 124);
        GenerateInputWave("../pat/comp/comp_126.txt", 125);    
        GenerateInputWave("../pat/comp/comp_127.txt", 126);             
        GenerateInputWave("../pat/comp/comp_128.txt", 127);
        GenerateInputWave("../pat/comp/comp_129.txt", 128);    
        GenerateInputWave("../pat/comp/comp_130.txt", 129);
        GenerateInputWave("../pat/comp/comp_131.txt", 130);
        GenerateInputWave("../pat/comp/comp_132.txt", 131);    
        GenerateInputWave("../pat/comp/comp_133.txt", 132);             
        GenerateInputWave("../pat/comp/comp_134.txt", 133);
        GenerateInputWave("../pat/comp/comp_135.txt", 134);    
        GenerateInputWave("../pat/comp/comp_136.txt", 135);
        GenerateInputWave("../pat/comp/comp_137.txt", 136);
        GenerateInputWave("../pat/comp/comp_138.txt", 137);    
        GenerateInputWave("../pat/comp/comp_139.txt", 138);             
        GenerateInputWave("../pat/comp/comp_140.txt", 139);
        GenerateInputWave("../pat/comp/comp_141.txt", 140);    
        GenerateInputWave("../pat/comp/comp_142.txt", 141);
        GenerateInputWave("../pat/comp/comp_143.txt", 142);
        GenerateInputWave("../pat/comp/comp_144.txt", 143);    
        GenerateInputWave("../pat/comp/comp_145.txt", 144);             
        GenerateInputWave("../pat/comp/comp_146.txt", 145);
        GenerateInputWave("../pat/comp/comp_147.txt", 146);    
        GenerateInputWave("../pat/comp/comp_148.txt", 147);
        GenerateInputWave("../pat/comp/comp_149.txt", 148);
        GenerateInputWave("../pat/comp/comp_150.txt", 149); 
        GenerateInputWave("../pat/comp/comp_151.txt", 150);
        GenerateInputWave("../pat/comp/comp_152.txt", 151);    
        GenerateInputWave("../pat/comp/comp_153.txt", 152);             
        GenerateInputWave("../pat/comp/comp_154.txt", 153);
        GenerateInputWave("../pat/comp/comp_155.txt", 154);    
        GenerateInputWave("../pat/comp/comp_156.txt", 155);
        GenerateInputWave("../pat/comp/comp_157.txt", 156);
        GenerateInputWave("../pat/comp/comp_158.txt", 157);    
        GenerateInputWave("../pat/comp/comp_159.txt", 158);             
        GenerateInputWave("../pat/comp/comp_160.txt", 159);
        GenerateInputWave("../pat/comp/comp_161.txt", 160);    
        GenerateInputWave("../pat/comp/comp_162.txt", 161);
        GenerateInputWave("../pat/comp/comp_163.txt", 162);
        GenerateInputWave("../pat/comp/comp_164.txt", 163);    
        GenerateInputWave("../pat/comp/comp_165.txt", 164);             
        GenerateInputWave("../pat/comp/comp_166.txt", 165);
        GenerateInputWave("../pat/comp/comp_167.txt", 166);    
        GenerateInputWave("../pat/comp/comp_168.txt", 167);
        GenerateInputWave("../pat/comp/comp_169.txt", 168);
        GenerateInputWave("../pat/comp/comp_170.txt", 169);    
        GenerateInputWave("../pat/comp/comp_171.txt", 170);             
        GenerateInputWave("../pat/comp/comp_172.txt", 171);
        GenerateInputWave("../pat/comp/comp_173.txt", 172);    
        GenerateInputWave("../pat/comp/comp_174.txt", 173);
        GenerateInputWave("../pat/comp/comp_175.txt", 174);
        GenerateInputWave("../pat/comp/comp_176.txt", 175);    
        GenerateInputWave("../pat/comp/comp_177.txt", 176);             
        GenerateInputWave("../pat/comp/comp_178.txt", 177);
        GenerateInputWave("../pat/comp/comp_179.txt", 178);    
        GenerateInputWave("../pat/comp/comp_180.txt", 179);
        GenerateInputWave("../pat/comp/comp_181.txt", 180);
        GenerateInputWave("../pat/comp/comp_182.txt", 181);    
        GenerateInputWave("../pat/comp/comp_183.txt", 182);             
        GenerateInputWave("../pat/comp/comp_184.txt", 183);
        GenerateInputWave("../pat/comp/comp_185.txt", 184);    
        GenerateInputWave("../pat/comp/comp_186.txt", 185);
        GenerateInputWave("../pat/comp/comp_187.txt", 186);
        GenerateInputWave("../pat/comp/comp_188.txt", 187);    
        GenerateInputWave("../pat/comp/comp_189.txt", 188);             
        GenerateInputWave("../pat/comp/comp_190.txt", 189);
        GenerateInputWave("../pat/comp/comp_191.txt", 190);    
        GenerateInputWave("../pat/comp/comp_192.txt", 191);
        GenerateInputWave("../pat/comp/comp_193.txt", 192);
        GenerateInputWave("../pat/comp/comp_194.txt", 193);    
        GenerateInputWave("../pat/comp/comp_195.txt", 194);             
        GenerateInputWave("../pat/comp/comp_196.txt", 195);
        GenerateInputWave("../pat/comp/comp_197.txt", 196);    
        GenerateInputWave("../pat/comp/comp_198.txt", 197);
        GenerateInputWave("../pat/comp/comp_199.txt", 198);
        GenerateInputWave("../pat/comp/comp_200.txt", 199); 
        GenerateInputWave("../pat/comp/comp_201.txt", 200);
        GenerateInputWave("../pat/comp/comp_202.txt", 201);    
        GenerateInputWave("../pat/comp/comp_203.txt", 202);             
        GenerateInputWave("../pat/comp/comp_204.txt", 203);
        GenerateInputWave("../pat/comp/comp_205.txt", 204);    
        GenerateInputWave("../pat/comp/comp_206.txt", 205);
        GenerateInputWave("../pat/comp/comp_207.txt", 206);
        GenerateInputWave("../pat/comp/comp_208.txt", 207);    
        GenerateInputWave("../pat/comp/comp_209.txt", 208);             
        GenerateInputWave("../pat/comp/comp_210.txt", 209);
        GenerateInputWave("../pat/comp/comp_211.txt", 210);    
        GenerateInputWave("../pat/comp/comp_212.txt", 211);
        GenerateInputWave("../pat/comp/comp_213.txt", 212);
        GenerateInputWave("../pat/comp/comp_214.txt", 213);    
        GenerateInputWave("../pat/comp/comp_215.txt", 214);             
        GenerateInputWave("../pat/comp/comp_216.txt", 215);
        GenerateInputWave("../pat/comp/comp_217.txt", 216);    
        GenerateInputWave("../pat/comp/comp_218.txt", 217);
        GenerateInputWave("../pat/comp/comp_219.txt", 218);
        GenerateInputWave("../pat/comp/comp_220.txt", 219);    
        GenerateInputWave("../pat/comp/comp_221.txt", 220);             
        GenerateInputWave("../pat/comp/comp_222.txt", 221);
        GenerateInputWave("../pat/comp/comp_223.txt", 222);    
        GenerateInputWave("../pat/comp/comp_224.txt", 223);
        GenerateInputWave("../pat/comp/comp_225.txt", 224);
        GenerateInputWave("../pat/comp/comp_226.txt", 225);    
        GenerateInputWave("../pat/comp/comp_227.txt", 226);             
        GenerateInputWave("../pat/comp/comp_228.txt", 227);
        GenerateInputWave("../pat/comp/comp_229.txt", 228);    
        GenerateInputWave("../pat/comp/comp_230.txt", 229);
        GenerateInputWave("../pat/comp/comp_231.txt", 230);
        GenerateInputWave("../pat/comp/comp_232.txt", 231);    
        GenerateInputWave("../pat/comp/comp_233.txt", 232);             
        GenerateInputWave("../pat/comp/comp_234.txt", 233);
        GenerateInputWave("../pat/comp/comp_235.txt", 234);    
        GenerateInputWave("../pat/comp/comp_236.txt", 235);
        GenerateInputWave("../pat/comp/comp_237.txt", 236);
        GenerateInputWave("../pat/comp/comp_238.txt", 237);    
        GenerateInputWave("../pat/comp/comp_239.txt", 238);             
        GenerateInputWave("../pat/comp/comp_240.txt", 239);
        GenerateInputWave("../pat/comp/comp_241.txt", 240);    
        GenerateInputWave("../pat/comp/comp_242.txt", 241);
        GenerateInputWave("../pat/comp/comp_243.txt", 242);
        GenerateInputWave("../pat/comp/comp_244.txt", 243);    
        GenerateInputWave("../pat/comp/comp_245.txt", 244);             
        GenerateInputWave("../pat/comp/comp_246.txt", 245);
        GenerateInputWave("../pat/comp/comp_247.txt", 246);    
        GenerateInputWave("../pat/comp/comp_248.txt", 247);
        GenerateInputWave("../pat/comp/comp_249.txt", 248);
        GenerateInputWave("../pat/comp/comp_250.txt", 249); 
        GenerateInputWave("../pat/comp/comp_251.txt", 250);
        GenerateInputWave("../pat/comp/comp_252.txt", 251);    
        GenerateInputWave("../pat/comp/comp_253.txt", 252);             
        GenerateInputWave("../pat/comp/comp_254.txt", 253);
        GenerateInputWave("../pat/comp/comp_255.txt", 254);    
        GenerateInputWave("../pat/comp/comp_256.txt", 255);
        GenerateInputWave("../pat/comp/comp_257.txt", 256);
        GenerateInputWave("../pat/comp/comp_258.txt", 257);    
        GenerateInputWave("../pat/comp/comp_259.txt", 258);             
        GenerateInputWave("../pat/comp/comp_260.txt", 259);
        GenerateInputWave("../pat/comp/comp_261.txt", 260);    
        GenerateInputWave("../pat/comp/comp_262.txt", 261);
        GenerateInputWave("../pat/comp/comp_263.txt", 262);
        GenerateInputWave("../pat/comp/comp_264.txt", 263);    
        GenerateInputWave("../pat/comp/comp_265.txt", 264);             
        GenerateInputWave("../pat/comp/comp_266.txt", 265);
        GenerateInputWave("../pat/comp/comp_267.txt", 266);    
        GenerateInputWave("../pat/comp/comp_268.txt", 267);
        GenerateInputWave("../pat/comp/comp_269.txt", 268);
        GenerateInputWave("../pat/comp/comp_270.txt", 269);    
        GenerateInputWave("../pat/comp/comp_271.txt", 270);             
        GenerateInputWave("../pat/comp/comp_272.txt", 271);
        GenerateInputWave("../pat/comp/comp_273.txt", 272);    
        GenerateInputWave("../pat/comp/comp_274.txt", 273);
        GenerateInputWave("../pat/comp/comp_275.txt", 274);
        GenerateInputWave("../pat/comp/comp_276.txt", 275);    
        GenerateInputWave("../pat/comp/comp_277.txt", 276);             
        GenerateInputWave("../pat/comp/comp_278.txt", 277);
        GenerateInputWave("../pat/comp/comp_279.txt", 278);    
        GenerateInputWave("../pat/comp/comp_280.txt", 279);
        GenerateInputWave("../pat/comp/comp_281.txt", 280);
        GenerateInputWave("../pat/comp/comp_282.txt", 281);    
        GenerateInputWave("../pat/comp/comp_283.txt", 282);             
        GenerateInputWave("../pat/comp/comp_284.txt", 283);
        GenerateInputWave("../pat/comp/comp_285.txt", 284);    
        GenerateInputWave("../pat/comp/comp_286.txt", 285);
        GenerateInputWave("../pat/comp/comp_287.txt", 286);
        GenerateInputWave("../pat/comp/comp_288.txt", 287);    
        GenerateInputWave("../pat/comp/comp_289.txt", 288);             
        GenerateInputWave("../pat/comp/comp_290.txt", 289);
        GenerateInputWave("../pat/comp/comp_291.txt", 290);    
        GenerateInputWave("../pat/comp/comp_292.txt", 291);
        GenerateInputWave("../pat/comp/comp_293.txt", 292);
        GenerateInputWave("../pat/comp/comp_294.txt", 293);    
        GenerateInputWave("../pat/comp/comp_295.txt", 294);             
        GenerateInputWave("../pat/comp/comp_296.txt", 295);
        GenerateInputWave("../pat/comp/comp_297.txt", 296);    
        GenerateInputWave("../pat/comp/comp_298.txt", 297);
        GenerateInputWave("../pat/comp/comp_299.txt", 298);
        GenerateInputWave("../pat/comp/comp_300.txt", 299); 
        GenerateInputWave("../pat/comp/comp_301.txt", 300);
        GenerateInputWave("../pat/comp/comp_302.txt", 301);    
        GenerateInputWave("../pat/comp/comp_303.txt", 302);             
        GenerateInputWave("../pat/comp/comp_304.txt", 303);
        GenerateInputWave("../pat/comp/comp_305.txt", 304);    
        GenerateInputWave("../pat/comp/comp_306.txt", 305);
        GenerateInputWave("../pat/comp/comp_307.txt", 306);
        GenerateInputWave("../pat/comp/comp_308.txt", 307);    
        GenerateInputWave("../pat/comp/comp_309.txt", 308);             
        GenerateInputWave("../pat/comp/comp_310.txt", 309);
        GenerateInputWave("../pat/comp/comp_311.txt", 310);    
        GenerateInputWave("../pat/comp/comp_312.txt", 311);
        GenerateInputWave("../pat/comp/comp_313.txt", 312);
        GenerateInputWave("../pat/comp/comp_314.txt", 313);    
        GenerateInputWave("../pat/comp/comp_315.txt", 314);             
        GenerateInputWave("../pat/comp/comp_316.txt", 315);
        GenerateInputWave("../pat/comp/comp_317.txt", 316);    
        GenerateInputWave("../pat/comp/comp_318.txt", 317);
        GenerateInputWave("../pat/comp/comp_319.txt", 318);
        GenerateInputWave("../pat/comp/comp_320.txt", 319);    
        GenerateInputWave("../pat/comp/comp_321.txt", 320);             
        GenerateInputWave("../pat/comp/comp_322.txt", 321);
        GenerateInputWave("../pat/comp/comp_323.txt", 322);    
        GenerateInputWave("../pat/comp/comp_324.txt", 323);
        GenerateInputWave("../pat/comp/comp_325.txt", 324);
        GenerateInputWave("../pat/comp/comp_326.txt", 325);    
        GenerateInputWave("../pat/comp/comp_327.txt", 326);             
        GenerateInputWave("../pat/comp/comp_328.txt", 327);
        GenerateInputWave("../pat/comp/comp_329.txt", 328);    
        GenerateInputWave("../pat/comp/comp_330.txt", 329);
        GenerateInputWave("../pat/comp/comp_331.txt", 330);
        GenerateInputWave("../pat/comp/comp_332.txt", 331);    
        GenerateInputWave("../pat/comp/comp_333.txt", 332);             
        GenerateInputWave("../pat/comp/comp_334.txt", 333);
        GenerateInputWave("../pat/comp/comp_335.txt", 334);    
        GenerateInputWave("../pat/comp/comp_336.txt", 335);
        GenerateInputWave("../pat/comp/comp_337.txt", 336);
        GenerateInputWave("../pat/comp/comp_338.txt", 337);    
        GenerateInputWave("../pat/comp/comp_339.txt", 338);             
        GenerateInputWave("../pat/comp/comp_340.txt", 339);
        GenerateInputWave("../pat/comp/comp_341.txt", 340);    
        GenerateInputWave("../pat/comp/comp_342.txt", 341);
        GenerateInputWave("../pat/comp/comp_343.txt", 342);
        GenerateInputWave("../pat/comp/comp_344.txt", 343);    
        GenerateInputWave("../pat/comp/comp_345.txt", 344);             
        GenerateInputWave("../pat/comp/comp_346.txt", 345);
        GenerateInputWave("../pat/comp/comp_347.txt", 346);    
        GenerateInputWave("../pat/comp/comp_348.txt", 347);
        GenerateInputWave("../pat/comp/comp_349.txt", 348);
        GenerateInputWave("../pat/comp/comp_350.txt", 349); 
        GenerateInputWave("../pat/comp/comp_351.txt", 350);
        GenerateInputWave("../pat/comp/comp_352.txt", 351);    
        GenerateInputWave("../pat/comp/comp_353.txt", 352);             
        GenerateInputWave("../pat/comp/comp_354.txt", 353);
        GenerateInputWave("../pat/comp/comp_355.txt", 354);    
        GenerateInputWave("../pat/comp/comp_356.txt", 355);
        GenerateInputWave("../pat/comp/comp_357.txt", 356);
        GenerateInputWave("../pat/comp/comp_358.txt", 357);    
        GenerateInputWave("../pat/comp/comp_359.txt", 358);             
        GenerateInputWave("../pat/comp/comp_360.txt", 359);
        GenerateInputWave("../pat/comp/comp_361.txt", 360);    
        GenerateInputWave("../pat/comp/comp_362.txt", 361);
        GenerateInputWave("../pat/comp/comp_363.txt", 362);
        GenerateInputWave("../pat/comp/comp_364.txt", 363);    
        GenerateInputWave("../pat/comp/comp_365.txt", 364);             
        GenerateInputWave("../pat/comp/comp_366.txt", 365);
        GenerateInputWave("../pat/comp/comp_367.txt", 366);    
        GenerateInputWave("../pat/comp/comp_368.txt", 367);
        GenerateInputWave("../pat/comp/comp_369.txt", 368);
        GenerateInputWave("../pat/comp/comp_370.txt", 369);    
        GenerateInputWave("../pat/comp/comp_371.txt", 370);             
        GenerateInputWave("../pat/comp/comp_372.txt", 371);
        GenerateInputWave("../pat/comp/comp_373.txt", 372);    
        GenerateInputWave("../pat/comp/comp_374.txt", 373);
        GenerateInputWave("../pat/comp/comp_375.txt", 374);
        GenerateInputWave("../pat/comp/comp_376.txt", 375);    
        GenerateInputWave("../pat/comp/comp_377.txt", 376);             
        GenerateInputWave("../pat/comp/comp_378.txt", 377);
        GenerateInputWave("../pat/comp/comp_379.txt", 378);    
        GenerateInputWave("../pat/comp/comp_380.txt", 379);
        GenerateInputWave("../pat/comp/comp_381.txt", 380);
        $display("fp = %d", fp);
        $display("fn = %d", (381-fp));

        repeat(10) @(posedge clk);
        $finish;
    end

    initial begin
        repeat(20000000) @(posedge clk);
        $display("[FAILED] Simulation timed out.");
        $finish;
    end

endmodule