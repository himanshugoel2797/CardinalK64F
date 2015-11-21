#include "drivers/wdog/wdog.h"

#include "managers/interrupts/interrupts.h"

void _start(void)
{
	InterruptManager_Init();

	WDOG_Init();
}