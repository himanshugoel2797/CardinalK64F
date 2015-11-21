TARGET=os.bin

CC=arm-none-eabi-gcc

AS=arm-none-eabi-as

CFLAGS=-Werror -Wall -mcpu=cortex-m4 -mthumb -O0 -std=c11 -I.
ASFLAGS=$(CFLAGS)

OBJS=main.o boot.o drivers/wdog/wdog.o drivers/pit/pit.o managers/interrupts/interrupts.o drivers/pwm/pwm.o

all: $(TARGET)

$(TARGET): $(OBJS)
	arm-none-eabi-ld -T linker.ld --cref -O0 -o $(TARGET).elf $(OBJS)
	arm-none-eabi-objcopy -O binary $(TARGET).elf $(TARGET)

clean:
	rm -rf $(OBJS) $(TARGET) $(TARGET).elf