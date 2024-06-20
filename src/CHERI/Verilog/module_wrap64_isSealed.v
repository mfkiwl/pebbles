//
// Generated by Bluespec Compiler, version 2022.01-37-gaf852df5 (build af852df5)
//
// On Thu Jun 20 12:37:29 BST 2024
//
//
// Ports:
// Name                         I/O  size props
// wrap64_isSealed                O     1
// wrap64_isSealed_cap            I    91
//
// Combinational paths from inputs to outputs:
//   wrap64_isSealed_cap -> wrap64_isSealed
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

module module_wrap64_isSealed(wrap64_isSealed_cap,
			      wrap64_isSealed);
  // value method wrap64_isSealed
  input  [90 : 0] wrap64_isSealed_cap;
  output wrap64_isSealed;

  // signals for module outputs
  wire wrap64_isSealed;

  // value method wrap64_isSealed
  assign wrap64_isSealed = wrap64_isSealed_cap[36:33] != 4'd15 ;
endmodule  // module_wrap64_isSealed

