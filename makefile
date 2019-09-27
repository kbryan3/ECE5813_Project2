############################
# Command for removing files
RM := rm -rf

############################
# Compiler
#moved to individual targets
############################
# Linker
#moved to individual targets



############################
# Binary/exectable to build
#moved to individual targets

############################
# List of object files
#moved to individual targets

############################
# List of dependency files
#moved to individual targets

############################
# Include generated dependcy files (only if not clean target)
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif


############################
# Compiler options
#moved to each target

############################
# Linker Options
#moved to each target

############################
# Main targets
all: $(EXE)
	@echo "*** finished building ***"

fb_run: CC = arm-none-eabi-gcc
fb_run: LL = arm-none-eabi-gcc
fb_run: INC = -I../board -I../source -I../ -I../drivers -I../CMSIS -I../utilities -I../startup
fb_run: CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC)
fb_run: LL_OPTIONS := -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
fb_run: EXE = ../Debug/project2.axf
fb_run: OBJS := \
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
  ../Debug/board/pin_mux.o
fb_run: C_DEPS = \
  ../Debug/board/*.d \
  ../Debug/CMSIS/*.d \
  ../Debug/drivers/*.d \
  ../Debug/source/*.d \
  ../Debug/startup/*.d \
  ../Debug/utilities/*.d
fb_run: $(EXE)
	@echo "*** finished building ***"

fb_debug: CC = arm-none-eabi-gcc
fb_debug: LL = arm-none-eabi-gcc
fb_debug: INC = -I../board -I../source -I../ -I../drivers -I../CMSIS -I../utilities -I../startup
fb_debug: CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC) -DFB_DEBUG
fb_debug: LL_OPTIONS := -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
fb_debug: EXE = ../Debug/project2.axf
fb_debug: OBJS := \
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
  ../Debug/board/pin_mux.o
fb_debug: C_DEPS = \
  ../Debug/board/*.d \
  ../Debug/CMSIS/*.d \
  ../Debug/drivers/*.d \
  ../Debug/source/*.d \
  ../Debug/startup/*.d \
  ../Debug/utilities/*.d
fb_debug: $(EXE)


pc_run: CC = gcc
pc_run: LL = gcc
pc_run: INC = -I../source
pc_run: CC_OPTIONS = -O0 -c std=gnu99 -g $(INC) -DPC_RUN
pc_run: LL_OPTIONS =
pc_run: EXE = project2.o
pc_run: OBJS = \
	./source/main.o \
	./source/led.o
pc_run: C_DEPS = \
	./source/*.d
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
