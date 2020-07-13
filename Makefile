# Makefile 

ASM_FILE=boot.asm
BIN_FILE=boot.bin
VIRTUAL_MACHINE=PuzzleBoot
OFFSET=2097152

all:
	yasm -f bin -o $(BIN_FILE) $(ASM_FILE)
	dd bs=1 seek=$(OFFSET) if=$(BIN_FILE) of=$(VIRTUAL_MACHINE).vdi

run:
	VirtualBox --startvm $(VIRTUAL_MACHINE)
