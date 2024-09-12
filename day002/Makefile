DAY = day002
TIME = $$(date + '%Y%m%d-%H%M%S')

TOOLCMD = iverilog -o sim.vvp -Wall -Winfloop -Wno-timescale -gno-shared-loop-index -g2012

compile: clean
	$(TOOLCMD) -s $(DAY) $(DAY).sv

sim: compile
	$(TOOLCMD) -s $(DAY)_tb $(DAY).sv $(DAY)_tb.sv
	vvp ./sim.vvp
	gtkwave $(DAY).vcd -r ../gtkwaverc $

build: clean
	touch synth.ys
	echo "read -sv $(DAY).sv" >> synth.ys
	echo "hierarchy -top $(DAY)" >> synth.ys
	echo "proc; opt; techmap; opt" >> synth.ys
	echo "write_verilog synth.v" >> synth.ys
	echo "show -prefix $(DAY) $(TIME)" >> synth.ys

synth: build
	yosys synth.ys

clean:
	rm -f sim.vvp $(DAY).vcd $(DAY).dot $(DAY).dot.pid synth.ys synth.v