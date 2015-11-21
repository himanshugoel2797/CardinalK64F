#include "interrupts.h"

InterruptHandler handlers[INTERRUPT_COUNT];

void
InterruptManager_Init(void)
{
	for(int i = 0; i < INTERRUPT_COUNT; i++)
	{
		handlers[i] = NULL;
	}

	__asm__ volatile("cpsie i");
}

void
InterruptManager_Register(uint16_t			int_no,
						  InterruptHandler  handler)
{
	handlers[int_no] = handler;
}

void
Interrupt_default_handler(Registers *regs)
{
	uint32_t int_no = 0;
	__asm__ volatile("mrs %0, ipsr":: "l"(int_no));

	if(handlers[int_no] != NULL)handlers[int_no](regs);
}