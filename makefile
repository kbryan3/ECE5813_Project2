############################
# Command for removing files
RM := rm -rf

############################
# Compiler
CC := arm-none-eabi-gcc

############################
# Linker
LL := arm-none-eabi-gcc

############################
# Binary/exectable to build
EXE := \
  ../Debug/project2.axf

############################
# List of object files
OBJS := \
  ../Debug/source/project2.o \
  ../Debug/source/led.o \
  ../Debug/source/mtb.o \
  ../Debug/source/semihost_hardfault.o \
  ../Debug/startup/startup_mkl25z4.o \
  ../Debug/CMSIS/system_MKL25Z4.o \
  ../Debug/utilities/fsl_debug_console.o \
  ../Debug/drivers/fsl_clock.o \
  ../Debug/drivers/fsl_common.o \
  ../Debug/drivers/fsl_flash.o \
  ../Debug/drivers/fsl_gpio.o \
  ../Debug/drivers/fsl_lpsci.o \
  ../Debug/drivers/fsl_smc.o \
  ../Debug/drivers/fsl_uart.o \
  ../Debug/board/board.o \
  ../Debug/board/clock_config.o \
  ../Debug/board/peripherals.o \
  ../Debug/board/pin_mux.o \
  

############################
# List of dependency files
C_DEPS = \
  ../Debug/board/*.d \
  ../Debug/CMSIS/*.d \
  ../Debug/drivers/*.d \
  ../Debug/source/*.d \
  ../Debug/startup/*.d \
  ../Debug/utilities/*.d \
  

############################
# Include generated dependcy files (only if not clean target)
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

############################
#Includes
INC = -I../board -I../src -I../ -I../drivers -I../CMSIS -I../utilities -I../startup

############################
# Compiler options
CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC) 

############################
# Linker Options
LL_OPTIONS := -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)


############################
# Main (all) target
all: $(EXE)
	@echo "*** finished building ***"

fb_run: $(EXE)
	@echo "*** finished building ***"

fb_debug: CC_OPTIONS += -DFB_DEBUG
fb_debug: $(EXE)


pc_run: $(EXE)
	@echo "*** finished building ***"

#pc_debug:

############################
# Clean target
clean:
	-$(RM) $(EXECUTABLES) $(OBJS) $(EXE)
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
../Debug/source/%.o: ../source/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

############################
# Rule to build the files in the CMSIS folder
../Debug/CMSIS/%.o: ../CMSIS/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
	############################
# Rule to build the files in the startup folder
../Debug/startup/%.o: ../startup/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
	############################
# Rule to build the files in the source folder
../Debug/source/%.o: ../source/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the utilities folder
../Debug/utilities/%.o: ../utilities/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
	############################
# Rule to build the files in the board folder
../Debug/board/%.o: ../board/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the drivers folder
../Debug/drivers/%.o: ../drivers/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '