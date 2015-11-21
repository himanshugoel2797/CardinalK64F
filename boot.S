.syntax unified
.arch armv7-m

.section .interrupt_descriptors, "a"
.align 2
.extern _start

ivt_start:
.long stack_top
.long _sys_init

.long _NMI_handler
.long _HardFault_handler
.long _MemManage_handler
.long _BusFault_handler
.long _UsageFault_handler

.long 0
.long 0
.long 0
.long 0
.long _SupervisorCall_handler
.long _default_handler
.long 0
.long _PendSV_handler
.long _SysTick_handler


//IRQ Handlers
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler	//Port A
.long _default_handler	//Port B
.long _default_handler	//Port C
.long _default_handler	//Port D
.long _default_handler	//Port E
.long _default_handler	//SWI
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
.long _default_handler
ivt_end:

.size ivt_start, . - ivt_start

.section .flash_config, "a"
.thumb
.long 0xFFFFFFFF
.long 0xFFFFFFFF
.long 0xFFFFFFFF
.long 0xFFFFFFFE

.text
.align
.thumb
.thumb_func
.globl _sys_init
.type _sys_init, %function
_sys_init:
		cpsid i 		//Disable interrupts

_disable_watchdog:
		//Unlock Watchdog
		ldr r0, =0x4005200E
		movw r1, #0xC520
		strh r1, [r0]
		ldr r0, =0x4005200E
		movw r1, #0xD928
		strh r1, [r0]

		//Disable Watchdog
		ldr r0, =0x40052000
		movw r1, #0x1D2
		strh r1, [r0]

_initialize_processor:

		//Enable the FPU in all modes
		ldr r1, =0xE000ED88	//CPACR (Coprocessor Access Control Register)
		ldr r0, [r1]
		orrs r0, r0, #(0xF << 20)
		str r0, [r1]

		//Enable the clock gates
		ldr r1, =0x40048038
		ldr r0, [r1]
		orrs r0, r0, #0xFFFFFFFF
		str r0, [r1]

		//Initialize the LED pins
		ldr r0, =0x100
		ldr r1, =0x4004A054
		str r0, [r1]
		ldr r1, =0x4004A058
		str r0, [r1]
		ldr r1, =0x4004D068
		str r0, [r1]

		//Mark the pins as output
		ldr r1, =0x400FF054
		ldr r0, =(3 << 21)
		str r0, [r1]

		ldr r1, =0x400FF114
		ldr r0, =(1 << 26)
		str r0, [r1]

		ldr r1, =0x400FF040
		ldr r0, =0
		orr r0, r0, #(3 << 21)	//Power off red light
		str r0, [r1]

		ldr r1, =0x400FF100
		ldr r0, =0
		orr r0, r0, #(1 << 26)
		str r0, [r1]

		//Once we are done with initialization, we should enable the watchdog again, configure it and make sure to refresh it
		bl _start


		ldr r1, =0x400FF04C
		ldr r0, =0
		orr r0, r0, #(3 << 21)	//Power off red light
		str r0, [r1]

		ldr r1, =0x400FF10C
		ldr r0, =0
		orr r0, r0, #(1 << 26)
		str r0, [r1]

_hang:
		cpsid i
		b _hang
.size _sys_init, . - _sys_init

.thumb_func


_NMI_handler:
_HardFault_handler:
_MemManage_handler:
_BusFault_handler:
_UsageFault_handler:

_SupervisorCall_handler:
_PendSV_handler:
_SysTick_handler:

_default_handler:
		mov r0, sp
		push {lr}
		bl Interrupt_default_handler
		pop {pc}^

		

.size _default_handler, . - _default_handler



.section .stack_info, "w"
.thumb
stack_bottom:
.skip 1024
stack_top:
.size stack_bottom, . - stack_bottom