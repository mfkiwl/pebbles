//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Thu Oct  7 15:42:59 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_almightyCapMem          O    65 const
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

module module_wrap64_almightyCapMem(wrap64_almightyCapMem);
  // value method wrap64_almightyCapMem
  output [64 : 0] wrap64_almightyCapMem;

  // signals for module outputs
  wire [64 : 0] wrap64_almightyCapMem;

  // value method wrap64_almightyCapMem
  assign wrap64_almightyCapMem = 65'h1FFF0000000000000 ;
endmodule  // module_wrap64_almightyCapMem
