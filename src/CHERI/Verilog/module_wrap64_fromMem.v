//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Sat Sep 25 09:11:05 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_fromMem                 O    91
// wrap64_fromMem_mem_cap         I    65
//
// Combinational paths from inputs to outputs:
//   wrap64_fromMem_mem_cap -> wrap64_fromMem
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

module module_wrap64_fromMem(wrap64_fromMem_mem_cap,
			     wrap64_fromMem);
  // value method wrap64_fromMem
  input  [64 : 0] wrap64_fromMem_mem_cap;
  output [90 : 0] wrap64_fromMem;

  // signals for module outputs
  wire [90 : 0] wrap64_fromMem;

  // remaining internal signals
  wire [31 : 0] x__h384;
  wire [26 : 0] INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_CONCA_ETC___d42;
  wire [7 : 0] b_base__h609, res_addrBits__h116, x__h582, x__h602;
  wire [5 : 0] b_top__h608, topBits__h511, x__h422;
  wire [4 : 0] IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d61,
	       INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1;
  wire [2 : 0] repBound__h663,
	       tb__h660,
	       tmp_expBotHalf__h377,
	       tmp_expTopHalf__h375;
  wire [1 : 0] carry_out__h513,
	       impliedTopBits__h515,
	       len_correction__h514,
	       x__h599;
  wire IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d48,
       IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d49,
       IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51;

  // value method wrap64_fromMem
  assign wrap64_fromMem =
	     { wrap64_fromMem_mem_cap[64],
	       wrap64_fromMem_mem_cap[31:0],
	       res_addrBits__h116,
	       wrap64_fromMem_mem_cap[63:51],
	       INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_CONCA_ETC___d42,
	       repBound__h663,
	       IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d48,
	       IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d49,
	       IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d61 } ;

  // remaining internal signals
  assign IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d48 =
	     tb__h660 < repBound__h663 ;
  assign IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d49 =
	     x__h602[7:5] < repBound__h663 ;
  assign IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51 =
	     res_addrBits__h116[7:5] < repBound__h663 ;
  assign IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d61 =
	     { IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51,
	       (IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d48 ==
		IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51) ?
		 2'd0 :
		 ((IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d48 &&
		   !IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51) ?
		    2'd1 :
		    2'd3),
	       (IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d49 ==
		IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51) ?
		 2'd0 :
		 ((IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d49 &&
		   !IF_INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_BI_ETC___d51) ?
		    2'd1 :
		    2'd3) } ;
  assign INV_wrap64_fromMem_mem_cap_BITS_50_TO_46_CONCA_ETC___d42 =
	     { ~wrap64_fromMem_mem_cap[50:46],
	       INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1[0] ?
		 x__h422 :
		 6'd0,
	       x__h582,
	       x__h602 } ;
  assign INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1 =
	     ~wrap64_fromMem_mem_cap[50:46] ;
  assign b_base__h609 =
	     { wrap64_fromMem_mem_cap[39:34],
	       ~wrap64_fromMem_mem_cap[33],
	       wrap64_fromMem_mem_cap[32] } ;
  assign b_top__h608 =
	     { wrap64_fromMem_mem_cap[45:42],
	       ~wrap64_fromMem_mem_cap[41:40] } ;
  assign carry_out__h513 = (topBits__h511 < x__h602[5:0]) ? 2'b01 : 2'b0 ;
  assign impliedTopBits__h515 = x__h599 + len_correction__h514 ;
  assign len_correction__h514 =
	     INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1[0] ? 2'b01 : 2'b0 ;
  assign repBound__h663 = x__h602[7:5] - 3'b001 ;
  assign res_addrBits__h116 =
	     INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1[0] ?
	       x__h384[7:0] :
	       wrap64_fromMem_mem_cap[7:0] ;
  assign tb__h660 = { impliedTopBits__h515, topBits__h511[5] } ;
  assign tmp_expBotHalf__h377 =
	     { wrap64_fromMem_mem_cap[34],
	       ~wrap64_fromMem_mem_cap[33],
	       wrap64_fromMem_mem_cap[32] } ;
  assign tmp_expTopHalf__h375 =
	     { wrap64_fromMem_mem_cap[42], ~wrap64_fromMem_mem_cap[41:40] } ;
  assign topBits__h511 =
	     INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1[0] ?
	       { wrap64_fromMem_mem_cap[45:43], 3'd0 } :
	       b_top__h608 ;
  assign x__h384 = wrap64_fromMem_mem_cap[31:0] >> x__h422 ;
  assign x__h422 = { tmp_expTopHalf__h375, tmp_expBotHalf__h377 } ;
  assign x__h582 = { impliedTopBits__h515, topBits__h511 } ;
  assign x__h599 = x__h602[7:6] + carry_out__h513 ;
  assign x__h602 =
	     INV_wrap64_fromMem_mem_cap_BITS_50_TO_46__q1[0] ?
	       { wrap64_fromMem_mem_cap[39:35], 3'd0 } :
	       b_base__h609 ;
endmodule  // module_wrap64_fromMem

