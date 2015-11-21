#include "interrupts.h"

#define ISE_BASE 0xE000E100
#define ICPR_BASE 0xE000E280

static InterruptHandler handlers[INTERRUPT_COUNT];

void
InterruptManager_Init(void)
{
	for(int i = 0; i < INTERRUPT_COUNT; i++)
		handlers[i] = NULL;

	__asm__ volatile("cpsie i");
}

void
InterruptManager_Register(uint16_t			int_no,
						  InterruptHandler  handler)
{
	handlers[int_no] = handler;
	if(int_no < 16)return;

	int_no -= 16;
	uint32_t volatile *r = (uint32_t*)ICPR_BASE;
	r[int_no / 32] |= (1 << (int_no % 32));	//Clear the pending status
	
	r = (uint32_t*)ISE_BASE;
	r[int_no / 32] |= (1 << (int_no % 32));	//Enable the interrupt
}

void
Interrupt_default_handler(Registers *regs)
{
	uint32_t int_no = 0;
	__asm__ volatile("ldr %0, =0xE000ED04\n\t"
					 "ldr %0, [%0]"
						:: "l"(int_no));

	int_no &= 0xFF;
	
	if(int_no > 5){
	uint32_t volatile *r2 = (uint32_t*)0x400FF04C;
	r2[0] |= (1 << 21);
	}

	if(int_no >= 16)
	{
		int_no -= 16;
		uint32_t volatile *r = (uint32_t*)ICPR_BASE;
		r[int_no / 32] |= (1 << (int_no % 32));	//Clear the pending status
		int_no += 16;	
	}

	if(handlers[int_no] != NULL)handlers[int_no](regs);
}