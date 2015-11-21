#include "pwm.h"

#define SIM_CLKDIV1 0x40048044

#define CLOCK_GATE_BASE 0x40048024

void
PWM_Init(void)
{
	PWM_SetCoreClockDivider(1);
	PWM_SetBusClockDivider(1);
}

void
PWM_SetCoreClockDivider(uint8_t divider)
{
	uint32_t volatile *r = (uint32_t*)SIM_CLKDIV1;
	r[0] = (r[0] & ~0xF0000000) | ((divider - 1) << 28);
}

uint8_t
PWM_GetCoreClockDivider(void)
{
	uint32_t volatile *r = (uint32_t*)SIM_CLKDIV1;
	return (r[0] >> 28) + 1;
}

void
PWM_SetBusClockDivider(uint8_t divider)
{
	uint32_t volatile *r = (uint32_t*)SIM_CLKDIV1;
	r[0] = (r[0] & ~0x0F000000) | ((divider - 1) << 24);
}

uint8_t
PWM_GetBusClockDivider(void)
{
	uint32_t volatile *r = (uint32_t*)SIM_CLKDIV1;
	return ((r[0] >> 24) & 0x0F) + 1;
}

void
PWM_EnableClock(uint32_t device)
{
	uint32_t volatile *r = (uint32_t*)CLOCK_GATE_BASE;
	r[device >> 8] |= (1 << (device & 0xFF));
}

void
PWM_DisableClock(uint32_t device)
{
	uint32_t volatile *r = (uint32_t*)CLOCK_GATE_BASE;
	r[device >> 8] &= ~(1 << (device & 0xFF));
}