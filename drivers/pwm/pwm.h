#ifndef _K64F_PowerManagement_H_
#define _K64F_PowerManagement_H_

#include <stddef.h>
#include <stdint.h>

#define CORE_CLOCK_MHZ 120
#define BUS_CLOCK_MHZ 60

void
PWM_Init(void);

void
PWM_SetCoreClockDivider(uint8_t divider);

void
PWM_SetBusClockDivider(uint8_t divider);

uint8_t
PWM_GetBusClockDivider(void);

uint8_t
PWM_GetCoreClockDivider(void);

typedef enum{
	DEVICE_PIT = 0x0617	//Register 6, bit 23
}Devices;

void
PWM_EnableClock(uint32_t device);

void
PWM_DisableClock(uint32_t device);

#endif