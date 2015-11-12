module testFsm (input clk, output reg a, b, c, input k, m, l);
  integer length = 0;
  integer position = 0;

  initial begin
    $display("Testcase for K (length < 10)");
    {a, b, c} = 3'b000;
    length = 9;
    position = -14;
    #50

    $display("Testcase for M (10 <= length < 12)");
    {a, b, c} = 3'b000;
    length = 11;
    position = -14;
    #50

    $display("Testcase for L (12 <= length)");
    {a, b, c} = 3'b000;
    length = 12;
    position = -14;
    #50

    $finish;
  end

  initial begin
    //$monitor($time,,,, "A=%d B=%d C=%d", a, b, c);
    $monitor($time,,,, "K=%d M=%d L=%d", k, m, l);
  end

  always @(posedge clk) begin
    position += 1;
    a <= (position + length >= 0 && position <= 0) ? 1 : 0;
    b <= (position + length >= 10 && position <= 10) ? 1 : 0;
    c <= (position + length >= 12 && position <= 12) ? 1 : 0;
  end
endmodule

module testBench;
  reg clk;

  fsm dut(clk, a, b, c, k, m, l);
  testFsm testDut(clk, a, b, c, k, m, l);

  initial begin
    clk <= 0;
    $dumpfile("build/fsm.vcd");
    $dumpvars(0);
  end

  always begin
    #1 clk <= ~clk;
  end
endmodule
