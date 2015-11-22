#include "interrupts.h"

#define ISE_BASE 0xE000E100
#define ICPR_BASE 0xE000E280
#define IPRE_BASE 0xE000E400

static InterruptHandler handlers[INTERRUPT_COUNT] __attribute__((aligned(1024)));

extern void _default_handler(void);

void
InterruptManager_Init(void)
{
	for(int i = 0; i < INTERRUPT_COUNT; i++)
		handlers[i] = (InterruptHandler)_default_handler;

	handlers[0] = (InterruptHandler)*(uint32_t*)0;
	handlers[1] = (InterruptHandler)*(uint32_t*)4;

	uint8_t volatile *r = (uint8_t*)IPRE_BASE;
	for(int i = 0; i < 240; i++)
		r[i] = 0x00;

	__asm__ volatile("ldr r0,=0xE000ED08\n\t"
					 "str %0, [r0]"
					 :
					 : "l"(handlers)
					 : "r0");

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
_default_handler(void)
{
	return;
}