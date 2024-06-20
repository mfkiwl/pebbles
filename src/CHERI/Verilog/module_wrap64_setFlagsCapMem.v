//
// Generated by Bluespec Compiler, version 2022.01-37-gaf852df5 (build af852df5)
//
// On Thu Jun 20 12:37:31 BST 2024
//
//
// Ports:
// Name                         I/O  size props
// wrap64_setFlagsCapMem          O    65
// wrap64_setFlagsCapMem_capMem   I    65
// wrap64_setFlagsCapMem_f        I     1
//
// Combinational paths from inputs to outputs:
//   (wrap64_setFlagsCapMem_capMem,
//    wrap64_setFlagsCapMem_f) -> wrap64_setFlagsCapMem
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

module module_wrap64_setFlagsCapMem(wrap64_setFlagsCapMem_capMem,
				    wrap64_setFlagsCapMem_f,
				    wrap64_setFlagsCapMem);
  // value method wrap64_setFlagsCapMem
  input  [64 : 0] wrap64_setFlagsCapMem_capMem;
  input  wrap64_setFlagsCapMem_f;
  output [64 : 0] wrap64_setFlagsCapMem;

  // signals for module outputs
  wire [64 : 0] wrap64_setFlagsCapMem;

  // value method wrap64_setFlagsCapMem
  assign wrap64_setFlagsCapMem =
	     { wrap64_setFlagsCapMem_capMem[64:52],
	       wrap64_setFlagsCapMem_f,
	       wrap64_setFlagsCapMem_capMem[50:0] } ;
endmodule  // module_wrap64_setFlagsCapMem

