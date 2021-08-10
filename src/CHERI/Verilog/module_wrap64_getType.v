//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Tue Aug 10 09:31:29 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_getType                 O     4
// wrap64_getType_cap             I    91
//
// Combinational paths from inputs to outputs:
//   wrap64_getType_cap -> wrap64_getType
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

module module_wrap64_getType(wrap64_getType_cap,
			     wrap64_getType);
  // value method wrap64_getType
  input  [90 : 0] wrap64_getType_cap;
  output [3 : 0] wrap64_getType;

  // signals for module outputs
  wire [3 : 0] wrap64_getType;

  // value method wrap64_getType
  assign wrap64_getType = wrap64_getType_cap[36:33] ;
endmodule  // module_wrap64_getType

