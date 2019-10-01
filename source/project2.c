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

 /********************************************************************
 *
 * @file project2.c
 * @brief Toggles LEDs in a specified ON/OFF sequence
 *
 *Given a Lookup table of time on and off(a constant array in the file below)
 * LEDs are toggled on and off based on the values(time and/or clock cycles)
 * in the lookup table.  The colors of the LEDs are also cycled through every
 * three On/OFF cycles
 *
 *Contains pre-processor definitions based on the following:
 *   a) Freedom Board Only
 *   b) Freedom Board plus Debug Serial Prinout
 *		c) PC Only
 *   d) PC with Debug info
 *
 *
 * @author Kyle Bryan
 * @date September 30 2019
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
 #include <unistd.h>
 #endif
 /* TODO: insert other include files here. */

 /* TODO: insert other definitions and declarations here. */

 //lookup table for delay values if FRMD Baord 24MHz if PC in ms
 #ifndef PC_RUN
 static const uint32_t DELAYLOOKUP[20] =
 	{12500000, 4166667, 8333333, 2500000, 4166667,1666667, 4166667, 833333,
 	  2083333, 416667, 2083333, 416667, 2083333, 416667, 4166667, 833333,
 	  4166667, 1666667, 8333333, 2500000};
 #else
 static const uint32_t DELAYLOOKUP[20] =
   {3000, 1000, 2000, 600, 1000, 400, 1000, 200, 500, 100, 500, 100,
     500, 100, 1000, 200, 1000, 400, 2000, 600};
 #endif

 /**
 * @brief Delays the application
 *
 * This function generates a delay based on a given delay value
 *
 * @param int32_t number of ms(or clock cycles) to delay
 *
 *@return void
 */
 void delay(volatile uint32_t number);


 /*
  * @brief   Application entry point.
  */
 int main(void) {

 #ifndef PC_RUN
   	/* Init board hardware. */
     BOARD_InitBootPins();
     BOARD_InitBootClocks();
     BOARD_InitBootPeripherals();
   	/* Init FSL debug console. */
     BOARD_InitDebugConsole();

     PRINTF("Hello World\n");
     initializeLEDs();
 #endif

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
 			toggleLED(color, DELAYLOOKUP[i], on);
 			delay(DELAYLOOKUP[i]);
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
 #ifndef PC_RUN
 void delay(volatile uint32_t number)
 {
 	while(number !=0)
 	{
 		__asm volatile("nop");
 		number--;
 	}
 }
 #else
 /**
 * @brief Delays the application
 *
 * This function generates a delay based on a given delay value
 *
 * @param int32_t number of ms to delay
 *
 *@return void
 */
 void delay(volatile uint32_t number)
 {
   usleep(number*1000);
 }
 #endif
