/*
 * Copyright 2016-2019 NXP
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this list
 *   of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * o Neither the name of NXP Semiconductor, Inc. nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
/**
 * @file    project2.c
 * @brief   Application entry point.
 */
#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL25Z4.h"
#include "fsl_debug_console.h"

#include "led.h"
/* TODO: insert other include files here. */

/* TODO: insert other definitions and declarations here. */

//lookup table for delay values
static const uint32_t delayLookup[20] =
	{12500000, 4166667, 8333333, 2500000, 4166667,1666667, 4166667, 833333,
	  2083333, 416667, 2083333, 416667, 2083333, 416667, 4166667, 833333,
	  4166667, 1666667, 8333333, 2500000};

void delay(volatile int32_t number);

/*
 * @brief   Application entry point.
 */
int main(void) {

  	/* Init board hardware. */
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitBootPeripherals();
  	/* Init FSL debug console. */
    BOARD_InitDebugConsole();

    PRINTF("Hello World\n");
    initializeLEDs();

    /* Force the counter to be placed into memory. */
    volatile static uint32_t i = 0;

    uint8_t color = 0;
    uint8_t numRepeat = 0;
    _Bool complete = 0;
    _Bool on = 0;
    /* Enter an infinite loop*/
    while(1) {
    	//loop goes through each ON/OFF three times(3x2)
		for(uint8_t j=0; j<6; j++)
		{
			on = !on;
			toggleLED(color, delayLookup[i], on);
			delay(delayLookup[i]);
			i++;
			//goes until LEDs have been toggled 20 times then starts over
			if(i>=20)
			{
				i=0;
				numRepeat++;				}
				//total sequence repeats 10 times
			if(numRepeat >= 10)
			{
				complete = 1;
				break;
			}
		}

        color++; //change to next color
        //resets color back to 0(red)
        if(color == 3)
        {
        	color = 0;
        }
        while(complete)
        {
        	i++;
        }
        /* 'Dummy' NOP to allow source level single stepping of
            tight while() loop */
        __asm volatile ("nop");
    }
    return 0 ;
}

/**
* @brief Delays the application
*
* This function generates a delay based on a given delay value
*
* @param int32_t number of 24MHz clock cycles to delay
*
*@return void
*/
void delay(volatile int32_t number)
{
	while(number !=0)
	{
		__asm volatile("nop");
		number--;
	}
}
