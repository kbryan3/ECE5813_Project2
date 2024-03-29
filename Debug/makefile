##########################
#
#@brief: Custom makefile to build PC and FB projects
#
# This makefile builds 2 different files(.axf for FB and .out for PC)
# User must call the correct target and then if creating the .out add
# TARGET = PC which tells the makefule to select the proper settings/files
# for generating the PC version of the application
# targets include: fb_run, fb_debug, pc_run, pc_debug
#
# @author Kyle Bryan
# @date September 30 2019
# version 1.0
#
#based off of the example given in the project 2 description given in class
# https://mcuoneclipse.com/s017/07/22/tutorial-makefile-projects-with-eclipse/
###########################
# Command for removing files
RM := rm -rf

############################
# Compiler
ifneq ($(TARGET), PC)
	CC = arm-none-eabi-gcc
else
	CC = gcc
endif
############################
# Linker
ifneq ($(TARGET), PC)
	LL = arm-none-eabi-gcc
else
	LL = gcc
endif
############################
# Binary/exectable to build
ifneq ($(TARGET), PC)
	EXE = project2.axf
else
	EXE = project2.out
endif
############################
# List of object files
OBJS_FB := \
	./source/project2.o \
  ./source/led.o \
  ./source/mtb.o \
  ./source/semihost_hardfault.o \
	./startup/startup_mkl25z4.o \
	./CMSIS/system_MKL25Z4.o \
	./utilities/fsl_debug_console.o \
	./drivers/fsl_clock.o \
	./drivers/fsl_common.o \
	./drivers/fsl_flash.o \
	./drivers/fsl_gpio.o \
	./drivers/fsl_lpsci.o \
	./drivers/fsl_smc.o \
	./drivers/fsl_uart.o \
	./board/board.o \
	./board/clock_config.o \
	./board/peripherals.o \
	./board/pin_mux.o

OBJS_PC := \
	./source/project2.o \
	./source/led.o

ifneq ($(TARGET), PC)
	OBJS = $(OBJS_FB)
else
	OBJS = $(OBJS_PC)
endif


############################
# List of dependency files
C_DEPS_FB := \
  ./board/*.d \
  ./CMSIS/*.d \
  ./drivers/*.d \
  ./source/*.d \
  ./startup/*.d \
  ./utilities/*.d

C_DEPS_PC := \
	  ./source/project2.d \
		./source/led.d

ifneq ($(TARGET), PC)
	C_DEPS = $(C_DEPS_FB)
else
	C_DEPS = $(C_DEPS_PC)
endif

############################
# Include generated dependcy files (only if not clean target)
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

############################
#Includes
INC = -I../board -I../source -I../ -I../drivers -I../CMSIS -I../utilities -I../startup

############################
# Compiler options
ifneq ($(TARGET), PC)
	CC_OPTIONS = -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC)
else
	CC_OPTIONS = -O0 -c -g $(INC) -DPC_RUN
endif
############################
# Linker Options
ifneq ($(TARGET), PC)
	LL_OPTIONS = -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
else
	LL_OPTIONS =
endif


############################
# Main targets
fb_run: $(EXE)
	@echo "*** finished building ***"

fb_debug: CC_OPTIONS += -DFB_DEBUG
fb_debug: $(EXE)
	@echo "*** finished building ***"

pc_run: $(EXE)
	@echo "*** finished building ***"

pc_debug: CC_OPTIONS += -DPC_DEBUG
pc_debug: $(EXE)
	@echo "*** finished building ***"

############################
# Clean target
clean:
	-$(RM) $(EXECUTABLES) $(OBJS_FB) $(EXE)
	-$(RM) ./Debug/*.map
	-@echo ' '

############################
# Rule to link the executable
$(EXE): $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Linker'
	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '



############################
# Rule to build the files in the source folder
source/%.o: ../source/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

############################
# Rule to build the files in the CMSIS folder
CMSIS/%.o: ../CMSIS/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the startup folder
startup/%.o: ../startup/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the utilities folder
utilities/%.o: ../utilities/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the board folder
board/%.o: ../board/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the drivers folder
drivers/%.o: ../drivers/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
