//
// Generated by Bluespec Compiler, version 2022.01-37-gaf852df5 (build af852df5)
//
// On Thu Jun 20 12:37:31 BST 2024
//
//
// Ports:
// Name                         I/O  size props
// wrap64_isSentryCapMem          O     1
// wrap64_isSentryCapMem_cap      I    65
//
// Combinational paths from inputs to outputs:
//   wrap64_isSentryCapMem_cap -> wrap64_isSentryCapMem
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

module module_wrap64_isSentryCapMem(wrap64_isSentryCapMem_cap,
				    wrap64_isSentryCapMem);
  // value method wrap64_isSentryCapMem
  input  [64 : 0] wrap64_isSentryCapMem_cap;
  output wrap64_isSentryCapMem;

  // signals for module outputs
  wire wrap64_isSentryCapMem;

  // value method wrap64_isSentryCapMem
  assign wrap64_isSentryCapMem = ~wrap64_isSentryCapMem_cap[50:47] == 4'd14 ;
endmodule  // module_wrap64_isSentryCapMem
