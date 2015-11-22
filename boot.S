.syntax unified
.arch armv7-m

.section .interrupt_descriptors, "a"
.align 2
.extern _start

ivt_start:
.long stack_top
.long _sys_init
.long _default_handler	//NMI
.long _default_handler  //HardFault
.long _default_handler	//MemManage
.long _default_handler  //Bus fault
.long _default_handler 	//Usage fault
.long 0
.long 0
.long 0
.long 0
.long _default_handler	//SVC
.long _default_handler	//Debug Monitor
.long 0
.long _default_handler	//PendSV
.long _default_handler	//SysTick
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
.long _default_handler	//RTC
.long _default_handler	//RTC seconds
.long _default_handler	//PIT0
.long _default_handler	//PIT1
.long _default_handler	//PIT2
.long _default_handler	//PIT3
.long _default_handler	//PDB0
.long _default_handler	//USB0
.long _default_handler	//USBDCD
.long _default_handler	//Reserved
.long _default_handler	//DAC0
.long _default_handler	//MCG
.long _default_handler	//LTimer
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
		dmb

		//Once we are done with initialization, we should enable the watchdog again, configure it and make sure to refresh it
		bl _start
		//ldr r1, =0x400FF04C
		//ldr r0, =0
		//orr r0, r0, #(1 << 22)	//Power on red light
		//str r0, [r1]
_hang:
		cpsid i
		wfi
		b _hang


.size _sys_init, . - _sys_init

.section .stack_info, "w"
.thumb
stack_bottom:
.skip 1024
stack_top:
.size stack_bottom, . - stack_bottom