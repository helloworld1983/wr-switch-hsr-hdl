/*
  Register definitions for slave core: WR Switch HSR LRE Dropper registers

  * File           : hsr_lre_dropper_regs.h
  * Author         : auto-generated by wbgen2 from hsr_dropper_regs.wb
  * Created        : Tue Oct 11 09:44:37 2016
  * Standard       : ANSI C

    THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE hsr_dropper_regs.wb
    DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!

*/

#ifndef __WBGEN2_REGDEFS_HSR_DROPPER_REGS_WB
#define __WBGEN2_REGDEFS_HSR_DROPPER_REGS_WB

#include <inttypes.h>

#if defined( __GNUC__)
#define PACKED __attribute__ ((packed))
#else
#error "Unsupported compiler?"
#endif

#ifndef __WBGEN2_MACROS_DEFINED__
#define __WBGEN2_MACROS_DEFINED__
#define WBGEN2_GEN_MASK(offset, size) (((1<<(size))-1) << (offset))
#define WBGEN2_GEN_WRITE(value, offset, size) (((value) & ((1<<(size))-1)) << (offset))
#define WBGEN2_GEN_READ(reg, offset, size) (((reg) >> (offset)) & ((1<<(size))-1))
#define WBGEN2_SIGN_EXTEND(value, bits) (((value) & (1<<bits) ? ~((1<<(bits))-1): 0 ) | (value))
#endif


/* definitions for register: Available positions */

/* definitions for register: Node removal register */

/* definitions for field: Node removal index in reg: Node removal register */
#define DROPPER_DEL_INDEX_MASK                WBGEN2_GEN_MASK(8, 5)
#define DROPPER_DEL_INDEX_SHIFT               8
#define DROPPER_DEL_INDEX_W(value)            WBGEN2_GEN_WRITE(value, 8, 5)
#define DROPPER_DEL_INDEX_R(reg)              WBGEN2_GEN_READ(reg, 8, 5)

/* definitions for field: Node removal command in reg: Node removal register */
#define DROPPER_DEL_CMD                       WBGEN2_GEN_MASK(16, 1)

/* definitions for field: Node list reset in reg: Node removal register */
#define DROPPER_DEL_RST                       WBGEN2_GEN_MASK(24, 1)
/* definitions for RAM: Dropper general RAM */
#define DROPPER_RAM_BASE 0x00000100 /* base address */                                
#define DROPPER_RAM_BYTES 0x00000100 /* size in bytes */                               
#define DROPPER_RAM_WORDS 0x00000040 /* size in 32-bit words, 32-bit aligned */        

PACKED struct DROPPER_WB {
  /* [0x0]: REG Available positions */
  uint32_t AVAIL;
  /* [0x4]: REG Node removal register */
  uint32_t DEL;
  /* padding to: 64 words */
  uint32_t __padding_0[62];
  /* [0x100 - 0x1ff]: RAM Dropper general RAM, 64 32-bit words, 32-bit aligned, word-addressable */
  uint32_t RAM [64];
};

#endif