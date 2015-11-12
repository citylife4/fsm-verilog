module fsm (input clk, input a, b, c, output k, m, l);
  localparam
    STATE_IDLE = 3'b000,
    STATE_K = 3'b001,
    STATE_M = 3'b010,
    STATE_L = 3'b100,
    STATE_ML = 3'b110;

  reg [2:0] state;

  // next state
  always @(posedge clk) begin
    case (state)
      STATE_IDLE: begin
        if (a && b) begin
          state <= STATE_ML;
        end else if (b) begin
          state <= STATE_K;
        end
      end
      STATE_ML: begin
        if (a && b && c) begin
          state <= STATE_L;
        end else if (b && c) begin
          state <= STATE_M;
        end
      end
    endcase
  end

  // reset
  always @(posedge clk) begin
    if (!a && !b && !c)
      state <= STATE_IDLE;
  end

  // output logic
  assign k = state[0] & ~state[1] & ~state[2];
  assign m = ~state[0] & state[1] & ~state[2];
  assign l = ~state[0] & ~state[1] & state[2];
endmodule
