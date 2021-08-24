//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Tue Aug 10 09:31:29 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_incOffset               O    92
// wrap64_incOffset_cap           I    91
// wrap64_incOffset_inc           I    32
//
// Combinational paths from inputs to outputs:
//   (wrap64_incOffset_cap, wrap64_incOffset_inc) -> wrap64_incOffset
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

module module_wrap64_incOffset(wrap64_incOffset_cap,
			       wrap64_incOffset_inc,
			       wrap64_incOffset);
  // value method wrap64_incOffset
  input  [90 : 0] wrap64_incOffset_cap;
  input  [31 : 0] wrap64_incOffset_inc;
  output [91 : 0] wrap64_incOffset;

  // signals for module outputs
  wire [91 : 0] wrap64_incOffset;

  // remaining internal signals
  wire [31 : 0] result_d_address__h561, x__h476, x__h582;
  wire [23 : 0] highBitsfilter__h71,
		highOffsetBits__h72,
		signBits__h69,
		x__h99;
  wire [7 : 0] repBoundBits__h78, toBoundsM1__h82, toBounds__h81;
  wire [3 : 0] IF_wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wr_ETC___d53;
  wire [2 : 0] repBound__h722;
  wire IF_wrap64_incOffset_inc_BIT_31_THEN_NOT_wrap64_ETC___d23,
       wrap64_incOffset_cap_BITS_17_TO_15_7_ULT_wrap6_ETC___d41,
       wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wrap6_ETC___d40,
       wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43;

  // value method wrap64_incOffset
  assign wrap64_incOffset =
	     { highOffsetBits__h72 == 24'd0 &&
	       IF_wrap64_incOffset_inc_BIT_31_THEN_NOT_wrap64_ETC___d23 ||
	       wrap64_incOffset_cap[31:26] >= 6'd24,
	       (highOffsetBits__h72 == 24'd0 &&
		IF_wrap64_incOffset_inc_BIT_31_THEN_NOT_wrap64_ETC___d23 ||
		wrap64_incOffset_cap[31:26] >= 6'd24) &&
	       wrap64_incOffset_cap[90],
	       result_d_address__h561,
	       x__h582[7:0],
	       wrap64_incOffset_cap[49:10],
	       repBound__h722,
	       wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wrap6_ETC___d40,
	       wrap64_incOffset_cap_BITS_17_TO_15_7_ULT_wrap6_ETC___d41,
	       wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43,
	       IF_wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wr_ETC___d53 } ;

  // remaining internal signals
  assign IF_wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wr_ETC___d53 =
	     { (wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wrap6_ETC___d40 ==
		wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43) ?
		 2'd0 :
		 ((wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wrap6_ETC___d40 &&
		   !wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43) ?
		    2'd1 :
		    2'd3),
	       (wrap64_incOffset_cap_BITS_17_TO_15_7_ULT_wrap6_ETC___d41 ==
		wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43) ?
		 2'd0 :
		 ((wrap64_incOffset_cap_BITS_17_TO_15_7_ULT_wrap6_ETC___d41 &&
		   !wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_wrap64_incOffset_inc_BIT_31_THEN_NOT_wrap64_ETC___d23 =
	     wrap64_incOffset_inc[31] ?
	       x__h476[7:0] >= toBounds__h81 &&
	       repBoundBits__h78 != wrap64_incOffset_cap[57:50] :
	       x__h476[7:0] < toBoundsM1__h82 ;
  assign highBitsfilter__h71 = 24'd16777215 << wrap64_incOffset_cap[31:26] ;
  assign highOffsetBits__h72 = x__h99 & highBitsfilter__h71 ;
  assign repBoundBits__h78 = { wrap64_incOffset_cap[9:7], 5'd0 } ;
  assign repBound__h722 = wrap64_incOffset_cap[17:15] - 3'b001 ;
  assign result_d_address__h561 =
	     wrap64_incOffset_cap[89:58] + wrap64_incOffset_inc ;
  assign signBits__h69 = {24{wrap64_incOffset_inc[31]}} ;
  assign toBoundsM1__h82 = repBoundBits__h78 + ~wrap64_incOffset_cap[57:50] ;
  assign toBounds__h81 = repBoundBits__h78 - wrap64_incOffset_cap[57:50] ;
  assign wrap64_incOffset_cap_BITS_17_TO_15_7_ULT_wrap6_ETC___d41 =
	     wrap64_incOffset_cap[17:15] < repBound__h722 ;
  assign wrap64_incOffset_cap_BITS_25_TO_23_9_ULT_wrap6_ETC___d40 =
	     wrap64_incOffset_cap[25:23] < repBound__h722 ;
  assign wrap64_incOffset_cap_BITS_89_TO_58_0_PLUS_wrap_ETC___d43 =
	     x__h582[7:5] < repBound__h722 ;
  assign x__h476 = wrap64_incOffset_inc >> wrap64_incOffset_cap[31:26] ;
  assign x__h582 = result_d_address__h561 >> wrap64_incOffset_cap[31:26] ;
  assign x__h99 = wrap64_incOffset_inc[31:8] ^ signBits__h69 ;
endmodule  // module_wrap64_incOffset
