/*

White Rabbit Softcore PLL (SoftPLL) - common definitions

WARNING: These parameters must be in sync with the generics of the HDL instantiation of wr_softpll_ng.

*/


#include <stdio.h>

/* Reference clock frequency, in [Hz] */
#define CLOCK_FREQ 62500000

/* Reference clock period, in picoseconds */
#define CLOCK_PERIOD_PICOSECONDS 16000

/* Number of bits in phase tags generated by the DMTDs. Used to sign-extend the tags. 
	 Corresponding VHDL generic: g_tag_bits. */
#define TAG_BITS 22

/* Helper PLL N divider (2**(-N) is the frequency offset). Must be big enough
   to offer reasonable PLL bandwidth, and small enough so the offset frequency fits
   within the tuning range of the helper oscillator. */
#define HPLL_N 14

/* Fractional bits in PI controller coefficients */
#define PI_FRACBITS 12

/* Max. allowed number of reference channels. Can be used to tweak memory usage. */
#define MAX_CHAN_REF 7

/* Max. allowed number of auxillary channels */
#define MAX_CHAN_AUX 1

/* Max. allowed number of phase trackers */
#define MAX_PTRACKERS 6

/* Number of bits of the DAC(s) driving the oscillator(s). Must be the same for
   all the outputs. */
#define DAC_BITS 16

/* Number of samples in a single ptracker averaging bin */
#define PTRACKER_AVERAGE_SAMPLES 512