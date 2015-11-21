#include "pit.h"
#include "drivers/pwm/pwm.h"

#define PIT_MCR 0x40037000
#define PIT_BASE 0x40037100
#define LOAD_VAL_32_OFF 0x0
#define CUR_VAL_32_OFF 0x1
#define CTRL_32_OFF 0x2
#define FLAG_32_OFF 0x3

#define TIMER_MULTIPLIER_32 0x4

static InterruptHandler handlers[TIMER_COUNT];

static void
PIT_Interrupt0Handler(Registers *regs)
{
	if(handlers[0] != NULL)handlers[0](regs);
	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	if(r[TIMER_MULTIPLIER_32 * 0 + FLAG_32_OFF])
		r[TIMER_MULTIPLIER_32 * 0 + FLAG_32_OFF] = 1;
}

static void
PIT_Interrupt1Handler(Registers *regs)
{
	if(handlers[1] != NULL)handlers[1](regs);
	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	if(r[TIMER_MULTIPLIER_32 * 1 + FLAG_32_OFF])
		r[TIMER_MULTIPLIER_32 * 1 + FLAG_32_OFF] = 1;
}

static void
PIT_Interrupt2Handler(Registers *regs)
{
	if(handlers[2] != NULL)handlers[2](regs);
	uint32_t volatile *r = (uint32_t*)PIT_BASE;

	if(r[TIMER_MULTIPLIER_32 * 2 + FLAG_32_OFF])
		r[TIMER_MULTIPLIER_32 * 2 + FLAG_32_OFF] = 1;
}

static void
PIT_Interrupt3Handler(Registers *regs)
{
	if(handlers[3] != NULL)handlers[3](regs);
	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	if(r[TIMER_MULTIPLIER_32 * 3 + FLAG_32_OFF])
		r[TIMER_MULTIPLIER_32 * 3 + FLAG_32_OFF] = 1;
}

void
PIT_Init(void)
{
	PWM_EnableClock(DEVICE_PIT);
	PIT_Enable();
	PIT_FreezeOnDebug(1);

	for(int i = 0; i < TIMER_COUNT; i++)handlers[i] = NULL;

	//Determine the bus clock rate and setup the timer to fire at 1kHz
	PIT_SetTimerFrequency(0, 1000);
	PIT_SetTimerFrequency(1, 1000);
	PIT_SetTimerFrequency(2, 1000);
	PIT_SetTimerFrequency(3, 1000);

	InterruptManager_Register(64, PIT_Interrupt0Handler);
	InterruptManager_Register(65, PIT_Interrupt1Handler);
	InterruptManager_Register(66, PIT_Interrupt2Handler);
	InterruptManager_Register(67, PIT_Interrupt3Handler);
}

void
PIT_Enable(void)
{
	uint32_t volatile *r = (uint32_t*)PIT_MCR;
	r[0] &= ~(1<<1);
}

void
PIT_Disable(void)
{
	uint32_t volatile *r = (uint32_t*)PIT_MCR;
	r[0] |= (1 << 1);
}

void
PIT_FreezeOnDebug(uint8_t freeze)
{
	uint32_t volatile *r = (uint32_t*)PIT_MCR;
	r[0] &= ~1;
	r[0] |= (freeze != 0);
}

void
PIT_EnableTimer(uint8_t timer)
{
	if(timer >= TIMER_COUNT)return;

	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	r[TIMER_MULTIPLIER_32 * timer + CTRL_32_OFF] = 3;	//Enable IRQ and Timer
}

void
PIT_DisableTimer(uint8_t timer)
{
	if(timer >= TIMER_COUNT)return;

	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	r[TIMER_MULTIPLIER_32 * timer + CTRL_32_OFF] = 0;	//Disable IRQ and Timer
}

uint32_t
PIT_GetTimerCount(uint8_t timer)
{
	if(timer >= TIMER_COUNT)return (uint32_t)-1;

	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	return r[TIMER_MULTIPLIER_32 * timer + CUR_VAL_32_OFF];	//Enable IRQ and Timer
}

void
PIT_SetTimerFrequency(uint8_t  timer,
					  uint32_t frequency)
{
	if(timer >= TIMER_COUNT)return;

	PIT_DisableTimer(0);
	uint32_t volatile *r = (uint32_t*)PIT_BASE;
	r[TIMER_MULTIPLIER_32 * timer + LOAD_VAL_32_OFF] = (BUS_CLOCK_MHZ/(uint32_t)PWM_GetBusClockDivider() * 1000 * 1000)/frequency;
}

void
PIT_RegisterHandler(uint8_t 		 timer,
					InterruptHandler handler)
{
	if(timer >= TIMER_COUNT)return;
	handlers[timer] = handler;
}