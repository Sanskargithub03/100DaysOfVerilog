module mux_case_test;
  reg  [1:0] in;
  reg  sel;
  wire out;

  // Instantiate the Unit Under Test (UUT)
  mux_case uut(
    .in(in),
    .sel(sel),
    .out(out)
  );

  // Dump for GTKWave
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mux_case_test);
  end

  // Apply stimulus
  initial begin
    in = 2'b00; sel = 0;

    // Try all combinations
    repeat (8) begin
      #2;   // wait 2 time units
      in = in + 1;
      sel = ~sel;
    end

    #5 $finish;
  end
endmodule
