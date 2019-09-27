 /********************************************************************
*
* @file led.c
* @brief Has functions to initialize LEDs as well as turn them on and off
*
* @author Kyle Bryan
* @date September 18 2019
* version 1.0
*
***********************************************************************/
#include <stdint.h>
#include "led.h"

#if !defined(PC_RUN) || !defined(PC_DEBUG)
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"

#else
#include <stdio.h>
#endif



void initializeLEDs()
{
	LED_BLUE_INIT(1);
	LED_RED_INIT(1);
	LED_GREEN_INIT(1);
}

//toggles LED: 0 red, 1 yellow, 2 blue
void toggleLED(uint8_t ledColor, uint32_t delay, _Bool on)
{
	uint32_t msDelay = delay*.00024;
	if(ledColor == 0)
	{
#if !defined(PC_RUN) || !defined(PC_DEBUG)
		LED_RED_TOGGLE();
#ifdef FB_DEBUG
			if(on)
			{

				PRINTF("LED RED ON %d\n", msDelay);
			}
			else
			{
				PRINTF("LED RED OFF %d\n", msDelay);
			}
#endif
#endif
#if defined(PC_RUN) || defined(PC_DEBUG)
			if(on)
			{
				printf("LED RED ON");
			}
			else
			{
				printf("LED RED OFF");
			}
#endif
	}
	else if(ledColor == 1)
	{
#if !defined(PC_RUN) || !defined(PC_DEBUG)
		LED_GREEN_TOGGLE();
#ifdef FB_DEBUG
			if(on)
			{

				PRINTF("LED GREEN ON %d\n", msDelay);
			}
			else
			{
				PRINTF("LED GREEN OFF %d\n", msDelay);
			}
#endif
#endif
#if defined(PC_RUN) || defined(PC_DEBUG)
			if(on)
			{
				printf("LED GREEN ON");
			}
			else
			{
				printf("LED GREEN OFF");
			}
#endif
	}
	else if(ledColor == 2)
	{
#if !defined(PC_RUN) || !defined(PC_DEBUG)
		LED_BLUE_TOGGLE();
#ifdef FB_DEBUG
			if(on)
			{

				PRINTF("LED BLUE ON %d\n", msDelay);
			}
			else
			{
				PRINTF("LED BLUE OFF %d\n", msDelay);
			}
#endif
#endif
#if defined(PC_RUN) || defined(PC_DEBUG)
			if(on)
			{
				printf("LED BLUE ON");
			}
			else
			{
				printf("LED BLUE OFF");
			}
#endif
	}
}
