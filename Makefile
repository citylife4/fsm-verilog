BUILD_DIR = build
TOP = fsm

sim:
	mkdir $(BUILD_DIR) -p
	iverilog -s testBench -o $(BUILD_DIR)/$(TOP).vvp $(TOP).v testbench.v
	vvp $(BUILD_DIR)/$(TOP).vvp

wave:
	gtkwave $(BUILD_DIR)/$(TOP).vcd

check:
	mkdir $(BUILD_DIR) -p
	yosys -p "proc; check" $(TOP).v

synth: $(TOP).v $(TOP).pcf
	mkdir $(BUILD_DIR) -p
	yosys -p "synth_ice40 -blif $(BUILD_DIR)/$(TOP).blif" $(TOP).v
	arachne-pnr -d 1k -p $(TOP).pcf $(BUILD_DIR)/$(TOP).blif -o $(BUILD_DIR)/$(TOP).txt
	icepack $(BUILD_DIR)/$(TOP).txt $(BUILD_DIR)/$(TOP).bin

send:
	iceprog $(BUILD_DIR)/$(TOP).bin

clean:
	rm -rf $(BUILD_DIR)
