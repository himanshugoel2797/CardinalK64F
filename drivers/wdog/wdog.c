#include "wdog.h"

#define WDOG_STCTRLH 0x40052000
#define WDOG_REFRESH 0x4005200C
#define WDOG_TIMEOUT_HI 0x40052004
#define WDOG_TIMEOUT_LO 0x40052006
#define WDOG_UNLOCK 0x4005200e

void
WDOG_Init(void)
{
	WDOG_Unlock();

	uint16_t volatile *r = (uint16_t*)WDOG_STCTRLH;
	r[0] = (uint16_t)0x12;

	WDOG_Enable();
	WDOG_SetTimeout(0xFFFFFFFF);
	WDOG_Refresh();
}

void
WDOG_Unlock(void)
{
	uint16_t volatile *r = (uint16_t*)WDOG_UNLOCK;
	r[0] = (uint16_t)0xC520;
	r[0] = (uint16_t)0xD928;
}

void 
WDOG_SetTimeout(uint32_t timeout)
{
	uint16_t volatile *r = (uint16_t*)WDOG_TIMEOUT_HI;
	r[0] = (uint16_t)(timeout >> 16);
	r[1] = (uint16_t)timeout;
}

void
WDOG_Refresh(void)
{
	uint16_t volatile *r = (uint16_t*)WDOG_REFRESH;
	r[0] = (uint16_t)0xA602;
	r[0] = (uint16_t)0xB480;
}

void
WDOG_Disable(void)
{
	uint16_t volatile *r = (uint16_t*)WDOG_STCTRLH;
	r[0] &= ~1;
}

void
WDOG_Enable(void)
{
	uint16_t volatile *r = (uint16_t*)WDOG_STCTRLH;
	r[0] |= 1;
}