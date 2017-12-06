/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'first_nios2_system'
 * SOPC Builder design path: ../../first_nios2_system.sopcinfo
 *
 * Generated: Tue Dec 05 18:59:15 PST 2017
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00010820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00008020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 2048
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00008000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00010820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 2048
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00008000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x11108
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x11108
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x11108
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "first_nios2_system"


/*
 * camData1 configuration
 *
 */

#define ALT_MODULE_CLASS_camData1 altera_avalon_pio
#define CAMDATA1_BASE 0x110c0
#define CAMDATA1_BIT_CLEARING_EDGE_REGISTER 0
#define CAMDATA1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CAMDATA1_CAPTURE 0
#define CAMDATA1_DATA_WIDTH 7
#define CAMDATA1_DO_TEST_BENCH_WIRING 0
#define CAMDATA1_DRIVEN_SIM_VALUE 0
#define CAMDATA1_EDGE_TYPE "NONE"
#define CAMDATA1_FREQ 50000000
#define CAMDATA1_HAS_IN 1
#define CAMDATA1_HAS_OUT 0
#define CAMDATA1_HAS_TRI 0
#define CAMDATA1_IRQ -1
#define CAMDATA1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CAMDATA1_IRQ_TYPE "NONE"
#define CAMDATA1_NAME "/dev/camData1"
#define CAMDATA1_RESET_VALUE 0
#define CAMDATA1_SPAN 16
#define CAMDATA1_TYPE "altera_avalon_pio"


/*
 * camData2 configuration
 *
 */

#define ALT_MODULE_CLASS_camData2 altera_avalon_pio
#define CAMDATA2_BASE 0x110b0
#define CAMDATA2_BIT_CLEARING_EDGE_REGISTER 0
#define CAMDATA2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CAMDATA2_CAPTURE 0
#define CAMDATA2_DATA_WIDTH 7
#define CAMDATA2_DO_TEST_BENCH_WIRING 0
#define CAMDATA2_DRIVEN_SIM_VALUE 0
#define CAMDATA2_EDGE_TYPE "NONE"
#define CAMDATA2_FREQ 50000000
#define CAMDATA2_HAS_IN 1
#define CAMDATA2_HAS_OUT 0
#define CAMDATA2_HAS_TRI 0
#define CAMDATA2_IRQ -1
#define CAMDATA2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CAMDATA2_IRQ_TYPE "NONE"
#define CAMDATA2_NAME "/dev/camData2"
#define CAMDATA2_RESET_VALUE 0
#define CAMDATA2_SPAN 16
#define CAMDATA2_TYPE "altera_avalon_pio"


/*
 * camState1 configuration
 *
 */

#define ALT_MODULE_CLASS_camState1 altera_avalon_pio
#define CAMSTATE1_BASE 0x11070
#define CAMSTATE1_BIT_CLEARING_EDGE_REGISTER 0
#define CAMSTATE1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CAMSTATE1_CAPTURE 0
#define CAMSTATE1_DATA_WIDTH 6
#define CAMSTATE1_DO_TEST_BENCH_WIRING 0
#define CAMSTATE1_DRIVEN_SIM_VALUE 0
#define CAMSTATE1_EDGE_TYPE "NONE"
#define CAMSTATE1_FREQ 50000000
#define CAMSTATE1_HAS_IN 1
#define CAMSTATE1_HAS_OUT 0
#define CAMSTATE1_HAS_TRI 0
#define CAMSTATE1_IRQ -1
#define CAMSTATE1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CAMSTATE1_IRQ_TYPE "NONE"
#define CAMSTATE1_NAME "/dev/camState1"
#define CAMSTATE1_RESET_VALUE 0
#define CAMSTATE1_SPAN 16
#define CAMSTATE1_TYPE "altera_avalon_pio"


/*
 * camState2 configuration
 *
 */

#define ALT_MODULE_CLASS_camState2 altera_avalon_pio
#define CAMSTATE2_BASE 0x11060
#define CAMSTATE2_BIT_CLEARING_EDGE_REGISTER 0
#define CAMSTATE2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CAMSTATE2_CAPTURE 0
#define CAMSTATE2_DATA_WIDTH 6
#define CAMSTATE2_DO_TEST_BENCH_WIRING 0
#define CAMSTATE2_DRIVEN_SIM_VALUE 0
#define CAMSTATE2_EDGE_TYPE "NONE"
#define CAMSTATE2_FREQ 50000000
#define CAMSTATE2_HAS_IN 1
#define CAMSTATE2_HAS_OUT 0
#define CAMSTATE2_HAS_TRI 0
#define CAMSTATE2_IRQ -1
#define CAMSTATE2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CAMSTATE2_IRQ_TYPE "NONE"
#define CAMSTATE2_NAME "/dev/camState2"
#define CAMSTATE2_RESET_VALUE 0
#define CAMSTATE2_SPAN 16
#define CAMSTATE2_TYPE "altera_avalon_pio"


/*
 * download1 configuration
 *
 */

#define ALT_MODULE_CLASS_download1 altera_avalon_pio
#define DOWNLOAD1_BASE 0x110e0
#define DOWNLOAD1_BIT_CLEARING_EDGE_REGISTER 0
#define DOWNLOAD1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DOWNLOAD1_CAPTURE 0
#define DOWNLOAD1_DATA_WIDTH 1
#define DOWNLOAD1_DO_TEST_BENCH_WIRING 0
#define DOWNLOAD1_DRIVEN_SIM_VALUE 0
#define DOWNLOAD1_EDGE_TYPE "NONE"
#define DOWNLOAD1_FREQ 50000000
#define DOWNLOAD1_HAS_IN 0
#define DOWNLOAD1_HAS_OUT 1
#define DOWNLOAD1_HAS_TRI 0
#define DOWNLOAD1_IRQ -1
#define DOWNLOAD1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DOWNLOAD1_IRQ_TYPE "NONE"
#define DOWNLOAD1_NAME "/dev/download1"
#define DOWNLOAD1_RESET_VALUE 0
#define DOWNLOAD1_SPAN 16
#define DOWNLOAD1_TYPE "altera_avalon_pio"


/*
 * download2 configuration
 *
 */

#define ALT_MODULE_CLASS_download2 altera_avalon_pio
#define DOWNLOAD2_BASE 0x110d0
#define DOWNLOAD2_BIT_CLEARING_EDGE_REGISTER 0
#define DOWNLOAD2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DOWNLOAD2_CAPTURE 0
#define DOWNLOAD2_DATA_WIDTH 1
#define DOWNLOAD2_DO_TEST_BENCH_WIRING 0
#define DOWNLOAD2_DRIVEN_SIM_VALUE 0
#define DOWNLOAD2_EDGE_TYPE "NONE"
#define DOWNLOAD2_FREQ 50000000
#define DOWNLOAD2_HAS_IN 0
#define DOWNLOAD2_HAS_OUT 1
#define DOWNLOAD2_HAS_TRI 0
#define DOWNLOAD2_IRQ -1
#define DOWNLOAD2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DOWNLOAD2_IRQ_TYPE "NONE"
#define DOWNLOAD2_NAME "/dev/download2"
#define DOWNLOAD2_RESET_VALUE 0
#define DOWNLOAD2_SPAN 16
#define DOWNLOAD2_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * hex1 configuration
 *
 */

#define ALT_MODULE_CLASS_hex1 altera_avalon_pio
#define HEX1_BASE 0x11050
#define HEX1_BIT_CLEARING_EDGE_REGISTER 0
#define HEX1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX1_CAPTURE 0
#define HEX1_DATA_WIDTH 7
#define HEX1_DO_TEST_BENCH_WIRING 0
#define HEX1_DRIVEN_SIM_VALUE 0
#define HEX1_EDGE_TYPE "NONE"
#define HEX1_FREQ 50000000
#define HEX1_HAS_IN 0
#define HEX1_HAS_OUT 1
#define HEX1_HAS_TRI 0
#define HEX1_IRQ -1
#define HEX1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEX1_IRQ_TYPE "NONE"
#define HEX1_NAME "/dev/hex1"
#define HEX1_RESET_VALUE 0
#define HEX1_SPAN 16
#define HEX1_TYPE "altera_avalon_pio"


/*
 * hex2 configuration
 *
 */

#define ALT_MODULE_CLASS_hex2 altera_avalon_pio
#define HEX2_BASE 0x11040
#define HEX2_BIT_CLEARING_EDGE_REGISTER 0
#define HEX2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define HEX2_CAPTURE 0
#define HEX2_DATA_WIDTH 7
#define HEX2_DO_TEST_BENCH_WIRING 0
#define HEX2_DRIVEN_SIM_VALUE 0
#define HEX2_EDGE_TYPE "NONE"
#define HEX2_FREQ 50000000
#define HEX2_HAS_IN 0
#define HEX2_HAS_OUT 1
#define HEX2_HAS_TRI 0
#define HEX2_IRQ -1
#define HEX2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEX2_IRQ_TYPE "NONE"
#define HEX2_NAME "/dev/hex2"
#define HEX2_RESET_VALUE 0
#define HEX2_SPAN 16
#define HEX2_TYPE "altera_avalon_pio"


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x11108
#define JTAG_UART_IRQ 16
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * leds configuration
 *
 */

#define ALT_MODULE_CLASS_leds altera_avalon_pio
#define LEDS_BASE 0x110f0
#define LEDS_BIT_CLEARING_EDGE_REGISTER 0
#define LEDS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LEDS_CAPTURE 0
#define LEDS_DATA_WIDTH 8
#define LEDS_DO_TEST_BENCH_WIRING 0
#define LEDS_DRIVEN_SIM_VALUE 0
#define LEDS_EDGE_TYPE "NONE"
#define LEDS_FREQ 50000000
#define LEDS_HAS_IN 0
#define LEDS_HAS_OUT 1
#define LEDS_HAS_TRI 0
#define LEDS_IRQ -1
#define LEDS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LEDS_IRQ_TYPE "NONE"
#define LEDS_NAME "/dev/leds"
#define LEDS_RESET_VALUE 0
#define LEDS_SPAN 16
#define LEDS_TYPE "altera_avalon_pio"


/*
 * onchip_mem configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_mem altera_avalon_onchip_memory2
#define ONCHIP_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEM_BASE 0x8000
#define ONCHIP_MEM_CONTENTS_INFO ""
#define ONCHIP_MEM_DUAL_PORT 0
#define ONCHIP_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEM_INIT_CONTENTS_FILE "first_nios2_system_onchip_mem"
#define ONCHIP_MEM_INIT_MEM_CONTENT 1
#define ONCHIP_MEM_INSTANCE_ID "NONE"
#define ONCHIP_MEM_IRQ -1
#define ONCHIP_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEM_NAME "/dev/onchip_mem"
#define ONCHIP_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEM_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEM_SINGLE_CLOCK_OP 0
#define ONCHIP_MEM_SIZE_MULTIPLE 1
#define ONCHIP_MEM_SIZE_VALUE 20480
#define ONCHIP_MEM_SPAN 20480
#define ONCHIP_MEM_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEM_WRITABLE 1


/*
 * rtd1 configuration
 *
 */

#define ALT_MODULE_CLASS_rtd1 altera_avalon_pio
#define RTD1_BASE 0x110a0
#define RTD1_BIT_CLEARING_EDGE_REGISTER 0
#define RTD1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RTD1_CAPTURE 0
#define RTD1_DATA_WIDTH 1
#define RTD1_DO_TEST_BENCH_WIRING 0
#define RTD1_DRIVEN_SIM_VALUE 0
#define RTD1_EDGE_TYPE "NONE"
#define RTD1_FREQ 50000000
#define RTD1_HAS_IN 1
#define RTD1_HAS_OUT 0
#define RTD1_HAS_TRI 0
#define RTD1_IRQ -1
#define RTD1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RTD1_IRQ_TYPE "NONE"
#define RTD1_NAME "/dev/rtd1"
#define RTD1_RESET_VALUE 0
#define RTD1_SPAN 16
#define RTD1_TYPE "altera_avalon_pio"


/*
 * rtd2 configuration
 *
 */

#define ALT_MODULE_CLASS_rtd2 altera_avalon_pio
#define RTD2_BASE 0x11090
#define RTD2_BIT_CLEARING_EDGE_REGISTER 0
#define RTD2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RTD2_CAPTURE 0
#define RTD2_DATA_WIDTH 1
#define RTD2_DO_TEST_BENCH_WIRING 0
#define RTD2_DRIVEN_SIM_VALUE 0
#define RTD2_EDGE_TYPE "NONE"
#define RTD2_FREQ 50000000
#define RTD2_HAS_IN 1
#define RTD2_HAS_OUT 0
#define RTD2_HAS_TRI 0
#define RTD2_IRQ -1
#define RTD2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RTD2_IRQ_TYPE "NONE"
#define RTD2_NAME "/dev/rtd2"
#define RTD2_RESET_VALUE 0
#define RTD2_SPAN 16
#define RTD2_TYPE "altera_avalon_pio"


/*
 * start configuration
 *
 */

#define ALT_MODULE_CLASS_start altera_avalon_pio
#define START_BASE 0x11080
#define START_BIT_CLEARING_EDGE_REGISTER 0
#define START_BIT_MODIFYING_OUTPUT_REGISTER 0
#define START_CAPTURE 0
#define START_DATA_WIDTH 1
#define START_DO_TEST_BENCH_WIRING 0
#define START_DRIVEN_SIM_VALUE 0
#define START_EDGE_TYPE "NONE"
#define START_FREQ 50000000
#define START_HAS_IN 0
#define START_HAS_OUT 1
#define START_HAS_TRI 0
#define START_IRQ -1
#define START_IRQ_INTERRUPT_CONTROLLER_ID -1
#define START_IRQ_TYPE "NONE"
#define START_NAME "/dev/start"
#define START_RESET_VALUE 0
#define START_SPAN 16
#define START_TYPE "altera_avalon_pio"


/*
 * sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_sys_clk_timer altera_avalon_timer
#define SYS_CLK_TIMER_ALWAYS_RUN 0
#define SYS_CLK_TIMER_BASE 0x11000
#define SYS_CLK_TIMER_COUNTER_SIZE 32
#define SYS_CLK_TIMER_FIXED_PERIOD 0
#define SYS_CLK_TIMER_FREQ 50000000
#define SYS_CLK_TIMER_IRQ 1
#define SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYS_CLK_TIMER_LOAD_VALUE 49999
#define SYS_CLK_TIMER_MULT 0.001
#define SYS_CLK_TIMER_NAME "/dev/sys_clk_timer"
#define SYS_CLK_TIMER_PERIOD 1
#define SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define SYS_CLK_TIMER_RESET_OUTPUT 0
#define SYS_CLK_TIMER_SNAPSHOT 1
#define SYS_CLK_TIMER_SPAN 32
#define SYS_CLK_TIMER_TICKS_PER_SEC 1000
#define SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x11100
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1512528086
#define SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * tenOut1 configuration
 *
 */

#define ALT_MODULE_CLASS_tenOut1 altera_avalon_pio
#define TENOUT1_BASE 0x11030
#define TENOUT1_BIT_CLEARING_EDGE_REGISTER 0
#define TENOUT1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TENOUT1_CAPTURE 0
#define TENOUT1_DATA_WIDTH 4
#define TENOUT1_DO_TEST_BENCH_WIRING 0
#define TENOUT1_DRIVEN_SIM_VALUE 0
#define TENOUT1_EDGE_TYPE "NONE"
#define TENOUT1_FREQ 50000000
#define TENOUT1_HAS_IN 1
#define TENOUT1_HAS_OUT 0
#define TENOUT1_HAS_TRI 0
#define TENOUT1_IRQ -1
#define TENOUT1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TENOUT1_IRQ_TYPE "NONE"
#define TENOUT1_NAME "/dev/tenOut1"
#define TENOUT1_RESET_VALUE 0
#define TENOUT1_SPAN 16
#define TENOUT1_TYPE "altera_avalon_pio"


/*
 * tenOut2 configuration
 *
 */

#define ALT_MODULE_CLASS_tenOut2 altera_avalon_pio
#define TENOUT2_BASE 0x11020
#define TENOUT2_BIT_CLEARING_EDGE_REGISTER 0
#define TENOUT2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TENOUT2_CAPTURE 0
#define TENOUT2_DATA_WIDTH 4
#define TENOUT2_DO_TEST_BENCH_WIRING 0
#define TENOUT2_DRIVEN_SIM_VALUE 0
#define TENOUT2_EDGE_TYPE "NONE"
#define TENOUT2_FREQ 50000000
#define TENOUT2_HAS_IN 1
#define TENOUT2_HAS_OUT 0
#define TENOUT2_HAS_TRI 0
#define TENOUT2_IRQ -1
#define TENOUT2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TENOUT2_IRQ_TYPE "NONE"
#define TENOUT2_NAME "/dev/tenOut2"
#define TENOUT2_RESET_VALUE 0
#define TENOUT2_SPAN 16
#define TENOUT2_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
