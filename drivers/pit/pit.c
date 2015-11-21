#include "pit.h"

#define PIT_MCR 0x40037000

void
PIT_Init(void)
{
	PIT_Enable();
	
}

void
PIT_Enable(void)
{
	uint32_t volatile *r = (uint32_t*)PIT_MCR;
	r[0] &= ~(1<<1);
}

void
PIT_Disable(void)
{
	uint32_t volatile *r = (uint32_t*)PIT_MCR;
	r[0] |= (1 << 1);
}