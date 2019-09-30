############################
# Command for removing files
RM := rm -rf

############################
# Compiler
ifeq ($(TARGET), FB)
	CC = arm-none-eabi-gcc
else
	CC = gcc
endif
############################
# Linker
ifeq ($(TARGET), FB)
	LL = arm-none-eabi-gcc
else
	LL = gcc
endif
############################
# Binary/exectable to build
ifeq ($(TARGET), FB)
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

ifeq ($(TARGET), FB)
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
	  ./board/*.d \
	  ./CMSIS/*.d \
	  ./drivers/*.d \
	  ./source/*.d \
	  ./startup/*.d \
	  ./utilities/*.d

ifeq ($(TARGET), FB)
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
ifeq ($(TARGET), FB)
	CC_OPTIONS = -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INC)
else
	CC_OPTIONS = -O0 -c -g $(INC) -DPC_RUN
endif
############################
# Linker Options
ifeq ($(TARGET), FB)
	LL_OPTIONS = -nostdlib -Xlinker -Map="project2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T project2_Debug.ld -o $(EXE)
else
	LL_OPTIONS =
endif


############################
# Main (all) target
all: $(EXE)
	@echo "*** finished building ***"

fb_run: $(EXE)
	@echo "*** finished building ***"

fb_run: CC_OPTIONS += -DFB_DEBUG
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
# Rule to link the executable for FRDM Board version
$(EXE): $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Linker'
	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

############################
# Rule to create .out of PC version
#project2.out: ./source/project2.o ./source/led.o $(USER_OBJS)
#	@echo 'Building target: $@'
#	@echo 'Invoking: Linker'
#	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS)
#	@echo 'Finished building target: $@'
#	@echo ' '



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
