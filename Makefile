##########################################################################
#                    Stellaris Project Template Makefile                 #
#                         fzahn, ollo, Version 1.0                       #
#                             mail@florianzahn.de                        #
##########################################################################


CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCPY=arm-none-eabi-objcopy
FLASH=~/Development/lm4tools/lm4flash/lm4flash


#objects to be created:
OBJ = main.o startup_gcc.o

#Target
BIN = main.bin



#INCLUDEs
INCLUDE=inc -I ~/Development/stellarisware

vpath %.c src

SRC = $(OBJ:.o=.c)



CFLAGS = -g -mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -Os -ffunction-sections -fdata-sections -MD -std=c99 -Wall -pedantic -DPART_LM4F120H5QR -c -I$(INCLUDE) -DTARGET_IS_BLIZZARD_RA1
LDFLAGS= -T main.ld --entry ResetISR





$(BIN): $(OBJ)

	$(LD) $(LDFLAGS) -o a.out $(OBJ) --gc-sections
	$(OBJCPY) -O binary a.out $(BIN)
	
%.o: %.c
		$(CC) $(SRC) $(CFLAGS)



flash: $(BIN)
	 $(FLASH) $(BIN)

.PHONY: clean

clean:
	rm -f a.out
	rm -f *.o
	rm -f *.bin
	rm -f *.d
