#include "drivers/wdog/wdog.h"
#include "drivers/pit/pit.h"
#include "drivers/pwm/pwm.h"

#include "managers/interrupts/interrupts.h"

void _start(void)
{
	InterruptManager_Init();
	PWM_Init();
	PIT_Init();
	PIT_SetTimerFrequency(0, 1000);
	PIT_EnableTimer(0);

	WDOG_Init();
}