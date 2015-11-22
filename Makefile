TARGET=os.bin

CC=arm-none-eabi-gcc

AS=arm-none-eabi-gcc

CFLAGS=-Werror -Wno-unused-function -Wall -mthumb -O0 -std=c11 -I. -mcpu=cortex-m4
ASFLAGS=$(CFLAGS)

OBJS=main.o boot.o drivers/wdog/wdog.o drivers/pit/pit.o managers/interrupts/interrupts.o drivers/pwm/pwm.o

all: $(TARGET)

$(TARGET): $(OBJS)
	arm-none-eabi-ld -T linker.ld --cref -O0 -o $(TARGET).elf $(OBJS)
	arm-none-eabi-objcopy -O binary $(TARGET).elf $(TARGET)

clean:
	rm -rf $(OBJS) $(TARGET) $(TARGET).elf