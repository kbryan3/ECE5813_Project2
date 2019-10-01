## PES Project Two Readme

Student Name: Kyle Bryan

##### Running Code, General description

This code is written to be run on either the FRDM board or in a Linux PC
environment.  For the FRDM board a .axf file is generated to be run with
MCUExpresso on a FRDM-KL25Z development board and for the Linux PC
a .out file is generated.  Choosing which file the user wants is done via the
makefile in the /Debug folder.  There are 4 total targets:

- fb_run: Blinks LEDs on FRDM board without any debug info
- fb_debug: fb_run plus serial output with debug info
- pc_run: outputs text instead of physical LED blinking
- pc_debug: outputs text but adds debug time info as well

When implementing the makefile, make sure you are pointing to the debug folder
as all the files are referenced under the assumption that is where the makefile
is.  When making either of the PC builds add TARGET = PC to the end of the make
command.  
e.g:

"make -r -f makefile -j8 pc_debug TARGET=PC"

"make -r -f makefile -j8 fb_run"

##### Repository Contents
###### Updated WBS
*PES Project 2 WBS_Update.pdf*

An updated WBS from the original showing the WBS for this project, all updates are in red font.


###### Source Code
*project2.c*, *led.h*, *led.c*, *makefile*

This project flashes an LED in a given order as well as changes the LED color
every three ON/OFF cycles.  The main() is located in project2.c while led.c/.h
contains the functions for initializing and blinking the LEDs.  The makefile is
used to generate the executables for the FRDM or PC platform.  Many other driver/board files
are also in this repository for use on the FRDM-KL25Z.

*There is code taken from https://stackoverflow.com/questions/5141960/get-the-current-time-in-c which is
pointed out in the led.c file*
