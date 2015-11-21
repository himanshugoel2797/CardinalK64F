#ifndef _K64F_PIT_H_
#define _K64F_PIT_H_

#include <stddef.h>
#include <stdint.h>

#include "managers/interrupts/interrupts.h"


#define TIMER_COUNT 4

void
PIT_Init(void);

void
PIT_Enable(void);

void
PIT_Disable(void);

void
PIT_FreezeOnDebug(uint8_t freeze);

void
PIT_EnableTimer(uint8_t timer);

void
PIT_DisableTimer(uint8_t timer);

uint32_t
PIT_GetTimerCount(uint8_t timer);

void
PIT_SetTimerFrequency(uint8_t  timer,
					  uint32_t frequency);

void
PIT_RegisterHandler(uint8_t          timer, 
					InterruptHandler handler);

#endif