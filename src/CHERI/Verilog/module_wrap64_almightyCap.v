//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Mon Sep 20 15:37:54 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_almightyCap             O    91 const
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

module module_wrap64_almightyCap(wrap64_almightyCap);
  // value method wrap64_almightyCap
  output [90 : 0] wrap64_almightyCap;

  // signals for module outputs
  wire [90 : 0] wrap64_almightyCap;

  // value method wrap64_almightyCap
  assign wrap64_almightyCap = 91'h40000000003FFDF690003F0 ;
endmodule  // module_wrap64_almightyCap

