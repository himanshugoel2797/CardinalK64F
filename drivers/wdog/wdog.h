#ifndef _K64_WDOG_DRIVER_H_
#define _K64_WDOG_DRIVER_H_

#include <stddef.h>
#include <stdint.h>

void
WDOG_Init(void);

void
WDOG_Unlock(void);

void 
WDOG_SetTimeout(uint32_t timeout);

void
WDOG_Refresh(void);

void
WDOG_Disable(void);

void
WDOG_Enable(void);

#endif