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

#ifndef PC_RUN
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"

#else
#include <stdio.h>
#include <time.h>

#endif

#ifdef PC_DEBUG
static time_t lastTime;
void printTime();
#endif




void initializeLEDs()
{
#ifndef PC_RUN
	LED_BLUE_INIT(1);
	LED_RED_INIT(1);
	LED_GREEN_INIT(1);
#endif
}

//toggles LED: 0 red, 1 yellow, 2 blue
void toggleLED(uint8_t ledColor, uint32_t delay, _Bool on)
{
	uint32_t msDelay = delay*.00024;
	if(ledColor == 0)
	{
#ifndef PC_RUN
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
#ifdef PC_RUN
			if(on)
			{
				printf("LED RED ON");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
			else
			{
				printf("LED RED OFF");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
#endif
	}
	else if(ledColor == 1)
	{
#ifndef PC_RUN
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
#ifdef PC_RUN
			if(on)
			{
				printf("LED GREEN ON");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
			else
			{
				printf("LED GREEN OFF");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
#endif
	}
	else if(ledColor == 2)
	{
#ifndef PC_RUN
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
#ifdef PC_RUN
			if(on)
			{
				printf("LED BLUE ON");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
			else
			{
				printf("LED BLUE OFF");
#ifdef PC_DEBUG
				printTime(delay);
#endif
			}
#endif
	}
#ifdef PC_DEBUG
	printf("\n");
#endif
}

#ifdef PC_DEBUG
void printTime(uint32_t delay)
{
//https://stackoverflow.com/questions/5141960/get-the-current-time-in-c
	time_t	t;
	struct tm * curTime;
	time(&t);
	curTime = localtime(&t);
	printf(" %02d:%02d:%02d %d", curTime->tm_hour, curTime->tm_min,
	        curTime->tm_sec, delay);

}
#endif
