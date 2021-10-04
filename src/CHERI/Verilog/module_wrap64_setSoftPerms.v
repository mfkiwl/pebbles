//
// Generated by Bluespec Compiler (build 14ff62d)
//
// On Mon Oct  4 13:41:46 BST 2021
//
//
// Ports:
// Name                         I/O  size props
// wrap64_setSoftPerms            O    91
// wrap64_setSoftPerms_cap        I    91
// wrap64_setSoftPerms_softperms  I    16 unused
//
// Combinational paths from inputs to outputs:
//   wrap64_setSoftPerms_cap -> wrap64_setSoftPerms
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

module module_wrap64_setSoftPerms(wrap64_setSoftPerms_cap,
				  wrap64_setSoftPerms_softperms,
				  wrap64_setSoftPerms);
  // value method wrap64_setSoftPerms
  input  [90 : 0] wrap64_setSoftPerms_cap;
  input  [15 : 0] wrap64_setSoftPerms_softperms;
  output [90 : 0] wrap64_setSoftPerms;

  // signals for module outputs
  wire [90 : 0] wrap64_setSoftPerms;

  // value method wrap64_setSoftPerms
  assign wrap64_setSoftPerms = wrap64_setSoftPerms_cap ;
endmodule  // module_wrap64_setSoftPerms

