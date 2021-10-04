//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Mon Oct  4 13:41:47 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_setBounds               O    92
// wrap64_setBounds_cap           I    91
// wrap64_setBounds_length        I    32
//
// Combinational paths from inputs to outputs:
//   (wrap64_setBounds_cap, wrap64_setBounds_length) -> wrap64_setBounds
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module module_wrap64_setBounds(wrap64_setBounds_cap,
			       wrap64_setBounds_length,
			       wrap64_setBounds);
  // value method wrap64_setBounds
  input  [90 : 0] wrap64_setBounds_cap;
  input  [31 : 0] wrap64_setBounds_length;
  output [91 : 0] wrap64_setBounds;

  // signals for module outputs
  wire [91 : 0] wrap64_setBounds;

  // remaining internal signals
  wire [33 : 0] base__h126,
		len__h128,
		lmaskLo__h134,
		lmaskLor__h133,
		mwLsbMask__h142,
		top__h129,
		x__h3965,
		x__h4089,
		x__h4268,
		y__h3966;
  wire [31 : 0] wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d110,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d10,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d13,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d4,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d7;
  wire [15 : 0] IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d212;
  wire [8 : 0] x__h4307;
  wire [7 : 0] _theResult_____3_fst_bounds_topBits__h4078,
	       result_cap_addrBits__h3908,
	       ret_bounds_baseBits__h4250,
	       ret_bounds_topBits__h4074,
	       ret_bounds_topBits__h4299,
	       x__h4343,
	       x__h4346;
  wire [5 : 0] IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d190,
	       _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183;
  wire [3 : 0] IF_IF_NOT_wrap64_setBounds_length_BIT_31_1_2_A_ETC___d234;
  wire [2 : 0] repBound__h4336;
  wire IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d221,
       IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d222,
       IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224,
       NOT_0_CONCAT_wrap64_setBounds_length_OR_0_CONC_ETC___d122,
       NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d191,
       NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d202,
       _0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_58__ETC___d105,
       wrap64_setBounds_cap_BITS_89_TO_58_AND_0_CONCA_ETC___d98,
       wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d123,
       wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d129,
       wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d130;

  // value method wrap64_setBounds
  assign wrap64_setBounds =
	     { wrap64_setBounds_cap_BITS_89_TO_58_AND_0_CONCA_ETC___d98 &&
	       _0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_58__ETC___d105,
	       wrap64_setBounds_cap[90:58],
	       result_cap_addrBits__h3908,
	       wrap64_setBounds_cap[49:37],
	       4'd15,
	       wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	       wrap64_setBounds_length[29] ||
	       wrap64_setBounds_length[28] ||
	       wrap64_setBounds_length[27] ||
	       wrap64_setBounds_length[26] ||
	       wrap64_setBounds_length[25] ||
	       wrap64_setBounds_length[24] ||
	       wrap64_setBounds_length[23] ||
	       wrap64_setBounds_length[22] ||
	       wrap64_setBounds_length[21] ||
	       wrap64_setBounds_length[20] ||
	       wrap64_setBounds_length[19] ||
	       wrap64_setBounds_length[18] ||
	       wrap64_setBounds_length[17] ||
	       wrap64_setBounds_length[16] ||
	       wrap64_setBounds_length[15] ||
	       wrap64_setBounds_length[14] ||
	       wrap64_setBounds_length[13] ||
	       wrap64_setBounds_length[12] ||
	       wrap64_setBounds_length[11] ||
	       wrap64_setBounds_length[10] ||
	       wrap64_setBounds_length[9] ||
	       wrap64_setBounds_length[8] ||
	       wrap64_setBounds_length[7] ||
	       wrap64_setBounds_length[6],
	       IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d190,
	       IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d212,
	       repBound__h4336,
	       IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d221,
	       IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d222,
	       IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224,
	       IF_IF_NOT_wrap64_setBounds_length_BIT_31_1_2_A_ETC___d234 } ;

  // remaining internal signals
  assign IF_IF_NOT_wrap64_setBounds_length_BIT_31_1_2_A_ETC___d234 =
	     { (IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d221 ==
		IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224) ?
		 2'd0 :
		 ((IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d221 &&
		   !IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224) ?
		    2'd1 :
		    2'd3),
	       (IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d222 ==
		IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224) ?
		 2'd0 :
		 ((IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d222 &&
		   !IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d212 =
	     (!wrap64_setBounds_length[31] && !wrap64_setBounds_length[30] &&
	      !wrap64_setBounds_length[29] &&
	      !wrap64_setBounds_length[28] &&
	      !wrap64_setBounds_length[27] &&
	      !wrap64_setBounds_length[26] &&
	      !wrap64_setBounds_length[25] &&
	      !wrap64_setBounds_length[24] &&
	      !wrap64_setBounds_length[23] &&
	      !wrap64_setBounds_length[22] &&
	      !wrap64_setBounds_length[21] &&
	      !wrap64_setBounds_length[20] &&
	      !wrap64_setBounds_length[19] &&
	      !wrap64_setBounds_length[18] &&
	      !wrap64_setBounds_length[17] &&
	      !wrap64_setBounds_length[16] &&
	      !wrap64_setBounds_length[15] &&
	      !wrap64_setBounds_length[14] &&
	      !wrap64_setBounds_length[13] &&
	      !wrap64_setBounds_length[12] &&
	      !wrap64_setBounds_length[11] &&
	      !wrap64_setBounds_length[10] &&
	      !wrap64_setBounds_length[9] &&
	      !wrap64_setBounds_length[8] &&
	      !wrap64_setBounds_length[7] &&
	      !wrap64_setBounds_length[6]) ?
	       { ret_bounds_topBits__h4299, x__h4089[7:0] } :
	       { ret_bounds_topBits__h4074[7:3],
		 3'd0,
		 ret_bounds_baseBits__h4250 } ;
  assign IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d221 =
	     x__h4346[7:5] < repBound__h4336 ;
  assign IF_NOT_wrap64_setBounds_length_BIT_31_1_2_AND__ETC___d222 =
	     x__h4343[7:5] < repBound__h4336 ;
  assign IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d190 =
	     (wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d130 &&
	      (wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	       wrap64_setBounds_length[29] ||
	       wrap64_setBounds_length[28] ||
	       wrap64_setBounds_length[27] ||
	       wrap64_setBounds_length[26] ||
	       wrap64_setBounds_length[25] ||
	       wrap64_setBounds_length[24] ||
	       wrap64_setBounds_length[23] ||
	       wrap64_setBounds_length[22] ||
	       wrap64_setBounds_length[21] ||
	       wrap64_setBounds_length[20] ||
	       wrap64_setBounds_length[19] ||
	       wrap64_setBounds_length[18] ||
	       wrap64_setBounds_length[17] ||
	       wrap64_setBounds_length[16] ||
	       wrap64_setBounds_length[15] ||
	       wrap64_setBounds_length[14] ||
	       wrap64_setBounds_length[13] ||
	       wrap64_setBounds_length[12] ||
	       wrap64_setBounds_length[11] ||
	       wrap64_setBounds_length[10] ||
	       wrap64_setBounds_length[9] ||
	       wrap64_setBounds_length[8] ||
	       wrap64_setBounds_length[7] ||
	       wrap64_setBounds_length[6])) ?
	       _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183 +
	       6'd1 :
	       _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183 ;
  assign IF_wrap64_setBounds_length_AND_15_CONCAT_INV_w_ETC___d224 =
	     result_cap_addrBits__h3908[7:5] < repBound__h4336 ;
  assign NOT_0_CONCAT_wrap64_setBounds_length_OR_0_CONC_ETC___d122 =
	     (mwLsbMask__h142 & top__h129) != (x__h3965 ^ y__h3966) ;
  assign NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d191 =
	     (top__h129 & lmaskLor__h133) != 34'd0 &&
	     (wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	      wrap64_setBounds_length[29] ||
	      wrap64_setBounds_length[28] ||
	      wrap64_setBounds_length[27] ||
	      wrap64_setBounds_length[26] ||
	      wrap64_setBounds_length[25] ||
	      wrap64_setBounds_length[24] ||
	      wrap64_setBounds_length[23] ||
	      wrap64_setBounds_length[22] ||
	      wrap64_setBounds_length[21] ||
	      wrap64_setBounds_length[20] ||
	      wrap64_setBounds_length[19] ||
	      wrap64_setBounds_length[18] ||
	      wrap64_setBounds_length[17] ||
	      wrap64_setBounds_length[16] ||
	      wrap64_setBounds_length[15] ||
	      wrap64_setBounds_length[14] ||
	      wrap64_setBounds_length[13] ||
	      wrap64_setBounds_length[12] ||
	      wrap64_setBounds_length[11] ||
	      wrap64_setBounds_length[10] ||
	      wrap64_setBounds_length[9] ||
	      wrap64_setBounds_length[8] ||
	      wrap64_setBounds_length[7] ||
	      wrap64_setBounds_length[6]) ;
  assign NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d202 =
	     (top__h129 & lmaskLo__h134) != 34'd0 &&
	     (wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	      wrap64_setBounds_length[29] ||
	      wrap64_setBounds_length[28] ||
	      wrap64_setBounds_length[27] ||
	      wrap64_setBounds_length[26] ||
	      wrap64_setBounds_length[25] ||
	      wrap64_setBounds_length[24] ||
	      wrap64_setBounds_length[23] ||
	      wrap64_setBounds_length[22] ||
	      wrap64_setBounds_length[21] ||
	      wrap64_setBounds_length[20] ||
	      wrap64_setBounds_length[19] ||
	      wrap64_setBounds_length[18] ||
	      wrap64_setBounds_length[17] ||
	      wrap64_setBounds_length[16] ||
	      wrap64_setBounds_length[15] ||
	      wrap64_setBounds_length[14] ||
	      wrap64_setBounds_length[13] ||
	      wrap64_setBounds_length[12] ||
	      wrap64_setBounds_length[11] ||
	      wrap64_setBounds_length[10] ||
	      wrap64_setBounds_length[9] ||
	      wrap64_setBounds_length[8] ||
	      wrap64_setBounds_length[7] ||
	      wrap64_setBounds_length[6]) ;
  assign _0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_58__ETC___d105 =
	     (top__h129 & lmaskLor__h133) == 34'd0 ||
	     !wrap64_setBounds_length[31] && !wrap64_setBounds_length[30] &&
	     !wrap64_setBounds_length[29] &&
	     !wrap64_setBounds_length[28] &&
	     !wrap64_setBounds_length[27] &&
	     !wrap64_setBounds_length[26] &&
	     !wrap64_setBounds_length[25] &&
	     !wrap64_setBounds_length[24] &&
	     !wrap64_setBounds_length[23] &&
	     !wrap64_setBounds_length[22] &&
	     !wrap64_setBounds_length[21] &&
	     !wrap64_setBounds_length[20] &&
	     !wrap64_setBounds_length[19] &&
	     !wrap64_setBounds_length[18] &&
	     !wrap64_setBounds_length[17] &&
	     !wrap64_setBounds_length[16] &&
	     !wrap64_setBounds_length[15] &&
	     !wrap64_setBounds_length[14] &&
	     !wrap64_setBounds_length[13] &&
	     !wrap64_setBounds_length[12] &&
	     !wrap64_setBounds_length[11] &&
	     !wrap64_setBounds_length[10] &&
	     !wrap64_setBounds_length[9] &&
	     !wrap64_setBounds_length[8] &&
	     !wrap64_setBounds_length[7] &&
	     !wrap64_setBounds_length[6] ;
  assign _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183 =
	     6'd25 -
	     { 1'd0,
	       wrap64_setBounds_length[31] ?
		 5'd0 :
		 (wrap64_setBounds_length[30] ?
		    5'd1 :
		    (wrap64_setBounds_length[29] ?
		       5'd2 :
		       (wrap64_setBounds_length[28] ?
			  5'd3 :
			  (wrap64_setBounds_length[27] ?
			     5'd4 :
			     (wrap64_setBounds_length[26] ?
				5'd5 :
				(wrap64_setBounds_length[25] ?
				   5'd6 :
				   (wrap64_setBounds_length[24] ?
				      5'd7 :
				      (wrap64_setBounds_length[23] ?
					 5'd8 :
					 (wrap64_setBounds_length[22] ?
					    5'd9 :
					    (wrap64_setBounds_length[21] ?
					       5'd10 :
					       (wrap64_setBounds_length[20] ?
						  5'd11 :
						  (wrap64_setBounds_length[19] ?
						     5'd12 :
						     (wrap64_setBounds_length[18] ?
							5'd13 :
							(wrap64_setBounds_length[17] ?
							   5'd14 :
							   (wrap64_setBounds_length[16] ?
							      5'd15 :
							      (wrap64_setBounds_length[15] ?
								 5'd16 :
								 (wrap64_setBounds_length[14] ?
								    5'd17 :
								    (wrap64_setBounds_length[13] ?
								       5'd18 :
								       (wrap64_setBounds_length[12] ?
									  5'd19 :
									  (wrap64_setBounds_length[11] ?
									     5'd20 :
									     (wrap64_setBounds_length[10] ?
										5'd21 :
										(wrap64_setBounds_length[9] ?
										   5'd22 :
										   (wrap64_setBounds_length[8] ?
										      5'd23 :
										      (wrap64_setBounds_length[7] ?
											 5'd24 :
											 5'd25)))))))))))))))))))))))) } ;
  assign _theResult_____3_fst_bounds_topBits__h4078 =
	     NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d202 ?
	       x__h4268[8:1] + 8'b00001000 :
	       x__h4268[8:1] ;
  assign base__h126 = { 2'b0, wrap64_setBounds_cap[89:58] } ;
  assign len__h128 = { 2'b0, wrap64_setBounds_length } ;
  assign lmaskLo__h134 =
	     { 5'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:3] } ;
  assign lmaskLor__h133 =
	     { 6'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:4] } ;
  assign mwLsbMask__h142 = lmaskLor__h133 ^ lmaskLo__h134 ;
  assign repBound__h4336 = x__h4343[7:5] - 3'b001 ;
  assign result_cap_addrBits__h3908 =
	     (wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d130 &&
	      (wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	       wrap64_setBounds_length[29] ||
	       wrap64_setBounds_length[28] ||
	       wrap64_setBounds_length[27] ||
	       wrap64_setBounds_length[26] ||
	       wrap64_setBounds_length[25] ||
	       wrap64_setBounds_length[24] ||
	       wrap64_setBounds_length[23] ||
	       wrap64_setBounds_length[22] ||
	       wrap64_setBounds_length[21] ||
	       wrap64_setBounds_length[20] ||
	       wrap64_setBounds_length[19] ||
	       wrap64_setBounds_length[18] ||
	       wrap64_setBounds_length[17] ||
	       wrap64_setBounds_length[16] ||
	       wrap64_setBounds_length[15] ||
	       wrap64_setBounds_length[14] ||
	       wrap64_setBounds_length[13] ||
	       wrap64_setBounds_length[12] ||
	       wrap64_setBounds_length[11] ||
	       wrap64_setBounds_length[10] ||
	       wrap64_setBounds_length[9] ||
	       wrap64_setBounds_length[8] ||
	       wrap64_setBounds_length[7] ||
	       wrap64_setBounds_length[6])) ?
	       x__h4089[8:1] :
	       x__h4089[7:0] ;
  assign ret_bounds_baseBits__h4250 =
	     { result_cap_addrBits__h3908[7:3], 3'd0 } ;
  assign ret_bounds_topBits__h4074 =
	     (wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d130 &&
	      (wrap64_setBounds_length[31] || wrap64_setBounds_length[30] ||
	       wrap64_setBounds_length[29] ||
	       wrap64_setBounds_length[28] ||
	       wrap64_setBounds_length[27] ||
	       wrap64_setBounds_length[26] ||
	       wrap64_setBounds_length[25] ||
	       wrap64_setBounds_length[24] ||
	       wrap64_setBounds_length[23] ||
	       wrap64_setBounds_length[22] ||
	       wrap64_setBounds_length[21] ||
	       wrap64_setBounds_length[20] ||
	       wrap64_setBounds_length[19] ||
	       wrap64_setBounds_length[18] ||
	       wrap64_setBounds_length[17] ||
	       wrap64_setBounds_length[16] ||
	       wrap64_setBounds_length[15] ||
	       wrap64_setBounds_length[14] ||
	       wrap64_setBounds_length[13] ||
	       wrap64_setBounds_length[12] ||
	       wrap64_setBounds_length[11] ||
	       wrap64_setBounds_length[10] ||
	       wrap64_setBounds_length[9] ||
	       wrap64_setBounds_length[8] ||
	       wrap64_setBounds_length[7] ||
	       wrap64_setBounds_length[6])) ?
	       _theResult_____3_fst_bounds_topBits__h4078 :
	       ret_bounds_topBits__h4299 ;
  assign ret_bounds_topBits__h4299 =
	     NOT_0b0_CONCAT_wrap64_setBounds_cap_BITS_89_TO_ETC___d191 ?
	       x__h4307[7:0] :
	       x__h4268[7:0] ;
  assign top__h129 = base__h126 + len__h128 ;
  assign wrap64_setBounds_cap_BITS_89_TO_58_AND_0_CONCA_ETC___d98 =
	     (wrap64_setBounds_cap[89:58] &
	      { 4'd0,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:4] }) ==
	     32'd0 ||
	     !wrap64_setBounds_length[31] && !wrap64_setBounds_length[30] &&
	     !wrap64_setBounds_length[29] &&
	     !wrap64_setBounds_length[28] &&
	     !wrap64_setBounds_length[27] &&
	     !wrap64_setBounds_length[26] &&
	     !wrap64_setBounds_length[25] &&
	     !wrap64_setBounds_length[24] &&
	     !wrap64_setBounds_length[23] &&
	     !wrap64_setBounds_length[22] &&
	     !wrap64_setBounds_length[21] &&
	     !wrap64_setBounds_length[20] &&
	     !wrap64_setBounds_length[19] &&
	     !wrap64_setBounds_length[18] &&
	     !wrap64_setBounds_length[17] &&
	     !wrap64_setBounds_length[16] &&
	     !wrap64_setBounds_length[15] &&
	     !wrap64_setBounds_length[14] &&
	     !wrap64_setBounds_length[13] &&
	     !wrap64_setBounds_length[12] &&
	     !wrap64_setBounds_length[11] &&
	     !wrap64_setBounds_length[10] &&
	     !wrap64_setBounds_length[9] &&
	     !wrap64_setBounds_length[8] &&
	     !wrap64_setBounds_length[7] &&
	     !wrap64_setBounds_length[6] ;
  assign wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d110 =
	     wrap64_setBounds_length &
	     { 4'd15,
	       ~wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:4] } ;
  assign wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d123 =
	     wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d110 ==
	     (wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16 ^
	      { 3'd0,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:3] }) &&
	     NOT_0_CONCAT_wrap64_setBounds_length_OR_0_CONC_ETC___d122 ;
  assign wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d129 =
	     wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d110 ==
	     (wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16 ^
	      { 4'd0,
		wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16[31:4] }) &&
	     (NOT_0_CONCAT_wrap64_setBounds_length_OR_0_CONC_ETC___d122 ||
	      (top__h129 & lmaskLor__h133) != 34'd0) ;
  assign wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d130 =
	     wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d123 &&
	     (top__h129 & lmaskLor__h133) != 34'd0 ||
	     wrap64_setBounds_length_AND_15_CONCAT_INV_wrap_ETC___d129 ;
  assign wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d10 =
	     wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d7 |
	     { 4'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d7[31:4] } ;
  assign wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d13 =
	     wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d10 |
	     { 8'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d10[31:8] } ;
  assign wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d16 =
	     wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d13 |
	     { 16'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d13[31:16] } ;
  assign wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d4 =
	     wrap64_setBounds_length |
	     { 1'd0, wrap64_setBounds_length[31:1] } ;
  assign wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d7 =
	     wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d4 |
	     { 2'd0,
	       wrap64_setBounds_length_OR_0_CONCAT_wrap64_set_ETC___d4[31:2] } ;
  assign x__h3965 = mwLsbMask__h142 & base__h126 ;
  assign x__h4089 =
	     base__h126 >>
	     _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183 ;
  assign x__h4268 =
	     top__h129 >>
	     _25_MINUS_0_CONCAT_IF_wrap64_setBounds_length_B_ETC___d183 ;
  assign x__h4307 = x__h4268[8:0] + 9'b000001000 ;
  assign x__h4343 =
	     (!wrap64_setBounds_length[31] && !wrap64_setBounds_length[30] &&
	      !wrap64_setBounds_length[29] &&
	      !wrap64_setBounds_length[28] &&
	      !wrap64_setBounds_length[27] &&
	      !wrap64_setBounds_length[26] &&
	      !wrap64_setBounds_length[25] &&
	      !wrap64_setBounds_length[24] &&
	      !wrap64_setBounds_length[23] &&
	      !wrap64_setBounds_length[22] &&
	      !wrap64_setBounds_length[21] &&
	      !wrap64_setBounds_length[20] &&
	      !wrap64_setBounds_length[19] &&
	      !wrap64_setBounds_length[18] &&
	      !wrap64_setBounds_length[17] &&
	      !wrap64_setBounds_length[16] &&
	      !wrap64_setBounds_length[15] &&
	      !wrap64_setBounds_length[14] &&
	      !wrap64_setBounds_length[13] &&
	      !wrap64_setBounds_length[12] &&
	      !wrap64_setBounds_length[11] &&
	      !wrap64_setBounds_length[10] &&
	      !wrap64_setBounds_length[9] &&
	      !wrap64_setBounds_length[8] &&
	      !wrap64_setBounds_length[7] &&
	      !wrap64_setBounds_length[6]) ?
	       result_cap_addrBits__h3908 :
	       ret_bounds_baseBits__h4250 ;
  assign x__h4346 =
	     (!wrap64_setBounds_length[31] && !wrap64_setBounds_length[30] &&
	      !wrap64_setBounds_length[29] &&
	      !wrap64_setBounds_length[28] &&
	      !wrap64_setBounds_length[27] &&
	      !wrap64_setBounds_length[26] &&
	      !wrap64_setBounds_length[25] &&
	      !wrap64_setBounds_length[24] &&
	      !wrap64_setBounds_length[23] &&
	      !wrap64_setBounds_length[22] &&
	      !wrap64_setBounds_length[21] &&
	      !wrap64_setBounds_length[20] &&
	      !wrap64_setBounds_length[19] &&
	      !wrap64_setBounds_length[18] &&
	      !wrap64_setBounds_length[17] &&
	      !wrap64_setBounds_length[16] &&
	      !wrap64_setBounds_length[15] &&
	      !wrap64_setBounds_length[14] &&
	      !wrap64_setBounds_length[13] &&
	      !wrap64_setBounds_length[12] &&
	      !wrap64_setBounds_length[11] &&
	      !wrap64_setBounds_length[10] &&
	      !wrap64_setBounds_length[9] &&
	      !wrap64_setBounds_length[8] &&
	      !wrap64_setBounds_length[7] &&
	      !wrap64_setBounds_length[6]) ?
	       ret_bounds_topBits__h4074 :
	       { ret_bounds_topBits__h4074[7:3], 3'd0 } ;
  assign y__h3966 = mwLsbMask__h142 & len__h128 ;
endmodule  // module_wrap64_setBounds

