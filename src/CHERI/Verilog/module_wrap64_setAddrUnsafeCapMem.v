//
// Generated by Bluespec Compiler, version 2022.01-37-gaf852df5 (build af852df5)
//
// On Thu Jun 20 12:37:31 BST 2024
//
//
// Ports:
// Name                         I/O  size props
// wrap64_setAddrUnsafeCapMem     O    65
// wrap64_setAddrUnsafeCapMem_cap  I    65
// wrap64_setAddrUnsafeCapMem_addr  I    32
//
// Combinational paths from inputs to outputs:
//   (wrap64_setAddrUnsafeCapMem_cap,
//    wrap64_setAddrUnsafeCapMem_addr) -> wrap64_setAddrUnsafeCapMem
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

module module_wrap64_setAddrUnsafeCapMem(wrap64_setAddrUnsafeCapMem_cap,
					 wrap64_setAddrUnsafeCapMem_addr,
					 wrap64_setAddrUnsafeCapMem);
  // value method wrap64_setAddrUnsafeCapMem
  input  [64 : 0] wrap64_setAddrUnsafeCapMem_cap;
  input  [31 : 0] wrap64_setAddrUnsafeCapMem_addr;
  output [64 : 0] wrap64_setAddrUnsafeCapMem;

  // signals for module outputs
  wire [64 : 0] wrap64_setAddrUnsafeCapMem;

  // value method wrap64_setAddrUnsafeCapMem
  assign wrap64_setAddrUnsafeCapMem =
	     { wrap64_setAddrUnsafeCapMem_cap[64:32],
	       wrap64_setAddrUnsafeCapMem_addr } ;
endmodule  // module_wrap64_setAddrUnsafeCapMem

