TOP        = top
SRC        = top.sv
LPF        = board.lpf

SPEED      = 6
MODEL      = 45k
PACKAGE    = CABGA381

FREQ       = 30000000
CABLE      = ft2232
SRAM_OPTS  = --status-pin 4 --invert-read-edge
FLASH_OPTS = --status-pin 4 --invert-read-edge --unprotect-flash

.PHONY: all clean sram flash

all:
	@echo "usage: make <sram|flash>"

clean:
	rm -vrf hardware.{bit,config,json}

sram: hardware.bit
	openFPGALoader -c $(CABLE) --freq $(FREQ) $(SRAM_OPTS) hardware.bit

flash: hardware.bit
	openFPGALoader -c $(CABLE) --freq $(FREQ) -f $(FLASH_OPTS) hardware.bit

hardware.bit: hardware.config
	ecppack --compress $< $@

hardware.config: hardware.json $(LPF)
	nextpnr-ecp5 --$(MODEL) --package $(PACKAGE) --speed $(SPEED) --top $(TOP) --lpf $(LPF) --json $< --textcfg $@

hardware.json: $(SRC)
	yosys -p 'synth_ecp5 -top $(TOP) -json hardware.json' $(SRC)
