 /********************************************************************
*
* @file led.h
* @brief Has functions to initialize LEDs as well as turn them on and off
*      RED LED is 0
*      Yellow LED is 1
*      Blue LED is 2
*
* @author Kyle Bryan
* @date September 30 2019
* version 1.0
*
***********************************************************************/
#ifndef __LED_H__
#define __LED_H__

#include <stdint.h>

/**
* @brief Initializes Red, Yellow and Blue LEDs so they are outputs
*
* This function calls the board.c macros for initializing the LED GPIO pins to
*  be outputs
*
*@return void
*/
void initializeLEDs();

/**
* @brief Toggles LEDs on/off
*
* This function toggles the given LED color on/off and prints the
* action to the UART terminal
*
* @param uint8_t ledColor which LED to toggle on/off
*          (0 is red, 1 is yellow, 2 is blue)
* @param uint32_t delay number of 25MHz clock cylces for delay
* @param _Bool on whether or not the LED is on or off
*
*@return void
*/
void toggleLED(uint8_t ledColor, uint32_t delay, _Bool on);



#endif /* __LED_H__ */
