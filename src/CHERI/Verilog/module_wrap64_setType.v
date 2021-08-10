//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Tue Aug 10 09:31:29 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_setType                 O    91
// wrap64_setType_cap             I    91
// wrap64_setType_t               I     4
//
// Combinational paths from inputs to outputs:
//   (wrap64_setType_cap, wrap64_setType_t) -> wrap64_setType
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

module module_wrap64_setType(wrap64_setType_cap,
			     wrap64_setType_t,
			     wrap64_setType);
  // value method wrap64_setType
  input  [90 : 0] wrap64_setType_cap;
  input  [3 : 0] wrap64_setType_t;
  output [90 : 0] wrap64_setType;

  // signals for module outputs
  wire [90 : 0] wrap64_setType;

  // value method wrap64_setType
  assign wrap64_setType =
	     { wrap64_setType_cap[90:37],
	       wrap64_setType_t,
	       wrap64_setType_cap[32:0] } ;
endmodule  // module_wrap64_setType

