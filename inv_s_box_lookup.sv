// $Id: $
// File name:   inv_s_box_lookup.sv
// Created:     4/11/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the inverse s-box lookup table
module inv_s_box_lookup
(
  input wire [7:0] input_word,
  output reg [7:0] substituted_word
);

always_comb begin :INVSBOX
  case(input_word)
	0 : substituted_word = 82;
	1 : substituted_word = 9;
	2 : substituted_word = 106;
	3 : substituted_word = 213;
	4 : substituted_word = 48;
	5 : substituted_word = 54;
	6 : substituted_word = 165;
	7 : substituted_word = 56;
	8 : substituted_word = 191;
	9 : substituted_word = 64;
	10 : substituted_word = 163;
	11 : substituted_word = 158;
	12 : substituted_word = 129;
	13 : substituted_word = 243;
	14 : substituted_word = 215;
	15 : substituted_word = 251;
	16 : substituted_word = 124;
	17 : substituted_word = 227;
	18 : substituted_word = 57;
	19 : substituted_word = 130;
	20 : substituted_word = 155;
	21 : substituted_word = 47;
	22 : substituted_word = 255;
	23 : substituted_word = 135;
	24 : substituted_word = 52;
	25 : substituted_word = 142;
	26 : substituted_word = 67;
	27 : substituted_word = 68;
	28 : substituted_word = 196;
	29 : substituted_word = 222;
	30 : substituted_word = 233;
	31 : substituted_word = 203;
	32 : substituted_word = 84;
	33 : substituted_word = 123;
	34 : substituted_word = 148;
	35 : substituted_word = 50;
	36 : substituted_word = 166;
	37 : substituted_word = 194;
	38 : substituted_word = 35;
	39 : substituted_word = 61;
	40 : substituted_word = 238;
	41 : substituted_word = 76;
	42 : substituted_word = 149;
	43 : substituted_word = 11;
	44 : substituted_word = 66;
	45 : substituted_word = 250;
	46 : substituted_word = 195;
	47 : substituted_word = 78;
	48 : substituted_word = 8;
	49 : substituted_word = 46;
	50 : substituted_word = 161;
	51 : substituted_word = 102;
	52 : substituted_word = 40;
	53 : substituted_word = 217;
	54 : substituted_word = 36;
	55 : substituted_word = 178;
	56 : substituted_word = 118;
	57 : substituted_word = 91;
	58 : substituted_word = 162;
	59 : substituted_word = 73;
	60 : substituted_word = 109;
	61 : substituted_word = 139;
	62 : substituted_word = 209;
	63 : substituted_word = 37;
	64 : substituted_word = 114;
	65 : substituted_word = 248;
	66 : substituted_word = 246;
	67 : substituted_word = 100;
	68 : substituted_word = 134;
	69 : substituted_word = 104;
	70 : substituted_word = 152;
	71 : substituted_word = 22;
	72 : substituted_word = 212;
	73 : substituted_word = 164;
	74 : substituted_word = 92;
	75 : substituted_word = 204;
	76 : substituted_word = 93;
	77 : substituted_word = 101;
	78 : substituted_word = 182;
	79 : substituted_word = 146;
	80 : substituted_word = 108;
	81 : substituted_word = 112;
	82 : substituted_word = 72;
	83 : substituted_word = 80;
	84 : substituted_word = 253;
	85 : substituted_word = 237;
	86 : substituted_word = 185;
	87 : substituted_word = 218;
	88 : substituted_word = 94;
	89 : substituted_word = 21;
	90 : substituted_word = 70;
	91 : substituted_word = 87;
	92 : substituted_word = 167;
	93 : substituted_word = 141;
	94 : substituted_word = 157;
	95 : substituted_word = 132;
	96 : substituted_word = 144;
	97 : substituted_word = 216;
	98 : substituted_word = 171;
	99 : substituted_word = 0;
	100 : substituted_word = 140;
	101 : substituted_word = 188;
	102 : substituted_word = 211;
	103 : substituted_word = 10;
	104 : substituted_word = 247;
	105 : substituted_word = 228;
	106 : substituted_word = 88;
	107 : substituted_word = 5;
	108 : substituted_word = 184;
	109 : substituted_word = 179;
	110 : substituted_word = 69;
	111 : substituted_word = 6;
	112 : substituted_word = 208;
	113 : substituted_word = 44;
	114 : substituted_word = 30;
	115 : substituted_word = 143;
	116 : substituted_word = 202;
	117 : substituted_word = 63;
	118 : substituted_word = 15;
	119 : substituted_word = 2;
	120 : substituted_word = 193;
	121 : substituted_word = 175;
	122 : substituted_word = 189;
	123 : substituted_word = 3;
	124 : substituted_word = 1;
	125 : substituted_word = 19;
	126 : substituted_word = 138;
	127 : substituted_word = 107;
	128 : substituted_word = 58;
	129 : substituted_word = 145;
	130 : substituted_word = 17;
	131 : substituted_word = 65;
	132 : substituted_word = 79;
	133 : substituted_word = 103;
	134 : substituted_word = 220;
	135 : substituted_word = 234;
	136 : substituted_word = 151;
	137 : substituted_word = 242;
	138 : substituted_word = 207;
	139 : substituted_word = 206;
	140 : substituted_word = 240;
	141 : substituted_word = 180;
	142 : substituted_word = 230;
	143 : substituted_word = 115;
	144 : substituted_word = 150;
	145 : substituted_word = 172;
	146 : substituted_word = 116;
	147 : substituted_word = 34;
	148 : substituted_word = 231;
	149 : substituted_word = 173;
	150 : substituted_word = 53;
	151 : substituted_word = 133;
	152 : substituted_word = 226;
	153 : substituted_word = 249;
	154 : substituted_word = 55;
	155 : substituted_word = 232;
	156 : substituted_word = 28;
	157 : substituted_word = 117;
	158 : substituted_word = 223;
	159 : substituted_word = 110;
	160 : substituted_word = 71;
	161 : substituted_word = 241;
	162 : substituted_word = 26;
	163 : substituted_word = 113;
	164 : substituted_word = 29;
	165 : substituted_word = 41;
	166 : substituted_word = 197;
	167 : substituted_word = 137;
	168 : substituted_word = 111;
	169 : substituted_word = 183;
	170 : substituted_word = 98;
	171 : substituted_word = 14;
	172 : substituted_word = 170;
	173 : substituted_word = 24;
	174 : substituted_word = 190;
	175 : substituted_word = 27;
	176 : substituted_word = 252;
	177 : substituted_word = 86;
	178 : substituted_word = 62;
	179 : substituted_word = 75;
	180 : substituted_word = 198;
	181 : substituted_word = 210;
	182 : substituted_word = 121;
	183 : substituted_word = 32;
	184 : substituted_word = 154;
	185 : substituted_word = 219;
	186 : substituted_word = 192;
	187 : substituted_word = 254;
	188 : substituted_word = 120;
	189 : substituted_word = 205;
	190 : substituted_word = 90;
	191 : substituted_word = 244;
	192 : substituted_word = 31;
	193 : substituted_word = 221;
	194 : substituted_word = 168;
	195 : substituted_word = 51;
	196 : substituted_word = 136;
	197 : substituted_word = 7;
	198 : substituted_word = 199;
	199 : substituted_word = 49;
	200 : substituted_word = 177;
	201 : substituted_word = 18;
	202 : substituted_word = 16;
	203 : substituted_word = 89;
	204 : substituted_word = 39;
	205 : substituted_word = 128;
	206 : substituted_word = 236;
	207 : substituted_word = 95;
	208 : substituted_word = 96;
	209 : substituted_word = 81;
	210 : substituted_word = 127;
	211 : substituted_word = 169;
	212 : substituted_word = 25;
	213 : substituted_word = 181;
	214 : substituted_word = 74;
	215 : substituted_word = 13;
	216 : substituted_word = 45;
	217 : substituted_word = 229;
	218 : substituted_word = 122;
	219 : substituted_word = 159;
	220 : substituted_word = 147;
	221 : substituted_word = 201;
	222 : substituted_word = 156;
	223 : substituted_word = 239;
	224 : substituted_word = 160;
	225 : substituted_word = 224;
	226 : substituted_word = 59;
	227 : substituted_word = 77;
	228 : substituted_word = 174;
	229 : substituted_word = 42;
	230 : substituted_word = 245;
	231 : substituted_word = 176;
	232 : substituted_word = 200;
	233 : substituted_word = 235;
	234 : substituted_word = 187;
	235 : substituted_word = 60;
	236 : substituted_word = 131;
	237 : substituted_word = 83;
	238 : substituted_word = 153;
	239 : substituted_word = 97;
	240 : substituted_word = 23;
	241 : substituted_word = 43;
	242 : substituted_word = 4;
	243 : substituted_word = 126;
	244 : substituted_word = 186;
	245 : substituted_word = 119;
	246 : substituted_word = 214;
	247 : substituted_word = 38;
	248 : substituted_word = 225;
	249 : substituted_word = 105;
	250 : substituted_word = 20;
	251 : substituted_word = 99;
	252 : substituted_word = 85;
	253 : substituted_word = 33;
	254 : substituted_word = 12;
	255 : substituted_word = 125;

  endcase
end

endmodule

