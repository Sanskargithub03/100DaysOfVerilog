// 8:1 Multiplexer using 2:1 muxes
module mux_8_1(
  output o,
  input  [7:0] i,
  input  [2:0] s
);
  wire [6:1] k;

  // Stage 1 (controlled by s[0])
  mux_case vas1(k[1], i[1:0], s[0]);
  mux_case vas2(k[2], i[3:2], s[0]);
  mux_case vas3(k[3], i[5:4], s[0]);
  mux_case vas4(k[4], i[7:6], s[0]);

  // Stage 2 (controlled by s[1])
  mux_case vas5(k[5], {k[2], k[1]}, s[1]);
  mux_case vas6(k[6], {k[4], k[3]}, s[1]);

  // Stage 3 (controlled by s[2])
  mux_case vas7(o, {k[6], k[5]}, s[2]);

endmodule


// 2:1 MUX
module mux_case(
  output reg out,
  input  [1:0] in,
  input  sel          
);
  always @(*) begin
    case(sel)
      1'b0: out = in[0];
      1'b1: out = in[1];
      default: out = 1'bx;
    endcase
  end
endmodule
