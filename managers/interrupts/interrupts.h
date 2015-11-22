#ifndef _INTERRUPT_MANAGER_H_
#define _INTERRUPT_MANAGER_H_

#include <stddef.h>
#include <stdint.h>

#define INTERRUPT_COUNT 0x100

typedef void(*InterruptHandler)(void);

void
InterruptManager_Init(void);

void
InterruptManager_Register(uint16_t 		    int_no,
						  InterruptHandler  handler);

#endif