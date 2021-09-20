//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Mon Sep 20 15:37:53 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_isValidCap              O     1
// wrap64_isValidCap_cap          I    91
//
// Combinational paths from inputs to outputs:
//   wrap64_isValidCap_cap -> wrap64_isValidCap
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

module module_wrap64_isValidCap(wrap64_isValidCap_cap,
				wrap64_isValidCap);
  // value method wrap64_isValidCap
  input  [90 : 0] wrap64_isValidCap_cap;
  output wrap64_isValidCap;

  // signals for module outputs
  wire wrap64_isValidCap;

  // value method wrap64_isValidCap
  assign wrap64_isValidCap = wrap64_isValidCap_cap[90] ;
endmodule  // module_wrap64_isValidCap

