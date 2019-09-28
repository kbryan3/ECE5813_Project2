############################
# Command for removing files
RM := rm -rf

############################
# Compiler


############################
# Linker


############################
# Binary/exectable to build
EXE = ./project2.axf

############################
# List of object files
OBJS = \
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
  ./board/pin_mux.o \


############################
# List of dependency files
C_DEPS = \
  ./board/*.d \
  ./CMSIS/*.d \
  ./drivers/*.d \
  ./source/*.d \
  ./startup/*.d \
  ./utilities/*.d \


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


############################
# Linker Options



############################
# Main (all) target
all: $(EXE)
	@echo "*** finished building ***"

fb_run: CC_OPTIONS = -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC) -DFB_DEBUG
fb_run: LL_OPTIONS = -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
#fb_run: EXE = ./project2.axf
fb_run: CC = arm-none-eabi-gcc
fb_run: LL = arm-none-eabi-gcc
fb_run: ./project2.axf
	@echo "*** finished building ***"

#fb_debug: CC_OPTIONS += -DFB_DEBUG
fb_debug: CC_OPTIONS = -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC) -DFB_DEBUG
fb_debug: LL_OPTIONS = -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
#fb_debug: EXE = ./project2.axf
fb_debug: CC = arm-none-eabi-gcc
fb_debug: LL = arm-none-eabi-gcc
fb_debug: ./project2.axf


pc_run: CC = gcc
pc_run: LL = gcc
pc_run: INC = -I../source
#pc_run: EXE = ./project2.o
pc_run: OBJS = ./source/project2.o ./source/led.o
pc_run: C_DEPS = ./source/project2.d ./source/led.d
pc_run: CC_OPTIONS = -O0 -c std=gnu99 -g $(INC) -DPC_RUN
pc_run: LL_OPTIONS =
pc_run: ./project2.out
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
./project2.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Linker'
	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	
./project2.out: ../source/project2.o ../source/led.o $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Linker'
	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

############################
# Rule to build the files in the source folder
./source/%.o: ../source/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

############################
# Rule to build the files in the CMSIS folder
./CMSIS/%.o: ../CMSIS/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the startup folder
./startup/%.o: ../startup/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the source folder
../source/%.o: ../source/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the utilities folder
./utilities/%.o: ../utilities/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the board folder
./board/%.o: ../board/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

	############################
# Rule to build the files in the drivers folder
./drivers/%.o: ../drivers/%.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
