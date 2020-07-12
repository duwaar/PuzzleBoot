# Makefile

ASM_FILE=boot.asm
BIN_FILE=boot.bin
VIRTUAL_DRIVE=EmptyBoot.vdi
OFFSET=2097152

all:
	yasm -f bin -o $(BIN_FILE) $(ASM_FILE)
	dd bs=1 seek=$(OFFSET) if=$(BIN_FILE) of=$(VIRTUAL_DRIVE)