DAY = day001
TIME = $$(date + '%Y%m%d-%H%M%S')

TOOLCMD = iverilog -o sim.vvp -Wall -Winfloop -Wno-timescale -gno-shared-loop-index -g2012

# Compile target
compile: clean
	$(TOOLCMD) -s $(DAY) $(DAY).sv

# Simulate target
sim: compile
	$(TOOLCMD) -s $(DAY)_tb $(DAY).sv $(DAY)_tb.sv
	vvp ./sim.vvp
	gtkwave $(DAY).vcd -r ./gtkwaverc &

# Build synthesis script
build: clean
	touch synth.ys
	echo "read_verilog $(DAY).sv" >> synth.ys
	echo "hierarchy -top $(DAY)" >> synth.ys
	echo "proc; opt; techmap; opt" >> synth.ys
	echo "write_verilog synth.v" >> synth.ys
	echo "show -prefix $(DAY) -colors $(TIME)" >> synth.ys

# Run Yosys synthesis
synth: build
	yosys synth.ys

# Clean up intermediate files
clean:
	rm -f sim.vvp synth.ys synth.v $(DAY).dot $(DAY).dot.pid $(DAY).vcd