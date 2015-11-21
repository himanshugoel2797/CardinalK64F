#ifndef _K64F_PIT_H_
#define _K64F_PIT_H_

#include <stddef.h>
#include <stdint.h>

void
PIT_Init(void);

void
PIT_Enable(void);

void
PIT_Disable(void);

#endif