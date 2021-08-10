//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Tue Aug 10 09:31:29 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_getBase                 O    32
// wrap64_getBase_cap             I    91
//
// Combinational paths from inputs to outputs:
//   wrap64_getBase_cap -> wrap64_getBase
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

module module_wrap64_getBase(wrap64_getBase_cap,
			     wrap64_getBase);
  // value method wrap64_getBase
  input  [90 : 0] wrap64_getBase_cap;
  output [31 : 0] wrap64_getBase;

  // signals for module outputs
  wire [31 : 0] wrap64_getBase;

  // remaining internal signals
  wire [31 : 0] addBase__h56;
  wire [23 : 0] mask__h57;
  wire [9 : 0] x__h155;

  // value method wrap64_getBase
  assign wrap64_getBase =
	     { wrap64_getBase_cap[89:66] & mask__h57, 8'd0 } + addBase__h56 ;

  // remaining internal signals
  assign addBase__h56 =
	     { {22{x__h155[9]}}, x__h155 } << wrap64_getBase_cap[31:26] ;
  assign mask__h57 = 24'd16777215 << wrap64_getBase_cap[31:26] ;
  assign x__h155 = { wrap64_getBase_cap[1:0], wrap64_getBase_cap[17:10] } ;
endmodule  // module_wrap64_getBase

