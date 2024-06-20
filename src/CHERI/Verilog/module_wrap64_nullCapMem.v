//
// Generated by Bluespec Compiler, version 2022.01-37-gaf852df5 (build af852df5)
//
// On Thu Jun 20 12:37:31 BST 2024
//
//
// Ports:
// Name                         I/O  size props
// wrap64_nullCapMem              O    65 const
//
// No combinational paths from inputs to outputs
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

module module_wrap64_nullCapMem(wrap64_nullCapMem);
  // value method wrap64_nullCapMem
  output [64 : 0] wrap64_nullCapMem;

  // signals for module outputs
  wire [64 : 0] wrap64_nullCapMem;

  // value method wrap64_nullCapMem
  assign wrap64_nullCapMem = 65'd0 ;
endmodule  // module_wrap64_nullCapMem

