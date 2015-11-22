#include "drivers/wdog/wdog.h"
#include "drivers/pit/pit.h"
#include "drivers/pwm/pwm.h"

#include "managers/interrupts/interrupts.h"

void _start(void)
{
	InterruptManager_Init();
	PWM_Init();
	
	PIT_Init();
	PIT_EnableTimer(0);

	WDOG_Init();

	while(1)
	{
		uint32_t volatile *r = (uint32_t*)0xE000E200;
		if((r[(64 - 16)/32] >> ((64-16) % 32)) & 1)
		{
			r = (uint32_t*)0x400FF04C;
			r[0] |= (1 << 22);
		}
	}
}