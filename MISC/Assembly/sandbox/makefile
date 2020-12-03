all: sandbox run
sandbox: sandbox.o
	@ld -m elf_i386 -o sandbox sandbox.o
	@echo "Done."
sandbox.o: sandbox.asm
	@nasm -f elf -g -F stabs sandbox.asm
run: 
	./sandbox
.PHONY: clean
clean: 
	@rm sandbox sandbox.o
