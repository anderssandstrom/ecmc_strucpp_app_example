BUILD_DIR ?= build
STLIB_DIR := $(BUILD_DIR)/stlib

STRUCPP ?= $(abspath ../strucpp)
ECMC_PLUGIN_STRUCPP ?= $(abspath ../ecmc_plugin_strucpp)
PODMAN ?= podman
NODE_IMAGE ?= docker.io/library/node:20

LOGIC_MODULES := machine_logic el7041_velocity_logic motion_actpos_mirror_logic mc_power_move_abs_logic mc_power_move_absolute_lib_logic
PYTHON ?= python3
MAPGEN := $(ECMC_PLUGIN_STRUCPP)/scripts/strucpp_mapgen.py
PATCH_STLIB_HEADERS := scripts/patch_stlib_headers.py

CXX ?= c++
CXXFLAGS += -std=c++17 -fPIC -Wall -Wextra
ECMC ?= $(abspath ../ecmc)
CPPFLAGS += -I$(STRUCPP)/src/runtime/include
CPPFLAGS += -I$(ECMC_PLUGIN_STRUCPP)/src
CPPFLAGS += -I$(ECMC)/devEcmcSup/motion
CPPFLAGS += -Isrc
CPPFLAGS += -Isrc/generated

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS += -dynamiclib -undefined dynamic_lookup
LIBEXT := dylib
else
LDFLAGS += -shared
LIBEXT := so
endif

MACHINE_SOURCES := \
	src/generated/machine.cpp \
	src/machine_logic.cpp

EL7041_VELOCITY_SOURCES := \
	src/generated/el7041_velocity.cpp \
	src/el7041_velocity_logic.cpp

MOTION_ACTPOS_MIRROR_SOURCES := \
	src/generated/motion_actpos_mirror.cpp \
	src/motion_actpos_mirror_logic.cpp

MC_POWER_MOVE_ABS_SOURCES := \
	src/mc_power_move_abs_logic.cpp

MC_POWER_MOVE_ABSOLUTE_LIB_SOURCES := \
	src/generated/mc_power_move_absolute_lib.cpp \
	src/mc_power_move_absolute_lib_logic.cpp

MACHINE_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(MACHINE_SOURCES))
EL7041_VELOCITY_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(EL7041_VELOCITY_SOURCES))
MOTION_ACTPOS_MIRROR_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(MOTION_ACTPOS_MIRROR_SOURCES))
MC_POWER_MOVE_ABS_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(MC_POWER_MOVE_ABS_SOURCES))
MC_POWER_MOVE_ABSOLUTE_LIB_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(MC_POWER_MOVE_ABSOLUTE_LIB_SOURCES))

MACHINE_TARGET := $(BUILD_DIR)/machine_logic.$(LIBEXT)
EL7041_VELOCITY_TARGET := $(BUILD_DIR)/el7041_velocity_logic.$(LIBEXT)
MOTION_ACTPOS_MIRROR_TARGET := $(BUILD_DIR)/motion_actpos_mirror_logic.$(LIBEXT)
MC_POWER_MOVE_ABS_TARGET := $(BUILD_DIR)/mc_power_move_abs_logic.$(LIBEXT)
MC_POWER_MOVE_ABSOLUTE_LIB_TARGET := $(BUILD_DIR)/mc_power_move_absolute_lib_logic.$(LIBEXT)
MACHINE_MAP := $(BUILD_DIR)/machine.map
EL7041_VELOCITY_MAP := $(BUILD_DIR)/el7041_velocity.map
MOTION_ACTPOS_MIRROR_MAP := $(BUILD_DIR)/motion_actpos_mirror.map
ECMC_MOTION_STLIB := $(STLIB_DIR)/ecmc-motion.stlib
TARGETS := $(MACHINE_TARGET) $(EL7041_VELOCITY_TARGET) $(MOTION_ACTPOS_MIRROR_TARGET) $(MC_POWER_MOVE_ABS_TARGET) $(MC_POWER_MOVE_ABSOLUTE_LIB_TARGET) $(MACHINE_MAP) $(EL7041_VELOCITY_MAP) $(MOTION_ACTPOS_MIRROR_MAP)

.PHONY: all clean regen regen-container maps

all: $(TARGETS)

$(MACHINE_TARGET): $(MACHINE_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(MACHINE_OBJECTS) $(LDFLAGS) -o $@

$(EL7041_VELOCITY_TARGET): $(EL7041_VELOCITY_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(EL7041_VELOCITY_OBJECTS) $(LDFLAGS) -o $@

$(MOTION_ACTPOS_MIRROR_TARGET): $(MOTION_ACTPOS_MIRROR_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(MOTION_ACTPOS_MIRROR_OBJECTS) $(LDFLAGS) -o $@

$(MC_POWER_MOVE_ABS_TARGET): $(MC_POWER_MOVE_ABS_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(MC_POWER_MOVE_ABS_OBJECTS) $(LDFLAGS) -o $@

$(MC_POWER_MOVE_ABSOLUTE_LIB_TARGET): $(MC_POWER_MOVE_ABSOLUTE_LIB_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(MC_POWER_MOVE_ABSOLUTE_LIB_OBJECTS) $(LDFLAGS) -o $@

$(BUILD_DIR)/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(MACHINE_MAP): src/generated/machine.hpp st/machine.st $(MAPGEN)
	@mkdir -p $(dir $@)
	$(PYTHON) $(MAPGEN) --header src/generated/machine.hpp --st-source st/machine.st --output $@

$(EL7041_VELOCITY_MAP): src/generated/el7041_velocity.hpp st/el7041_velocity.st $(MAPGEN)
	@mkdir -p $(dir $@)
	$(PYTHON) $(MAPGEN) --header src/generated/el7041_velocity.hpp --st-source st/el7041_velocity.st --output $@

$(MOTION_ACTPOS_MIRROR_MAP): src/generated/motion_actpos_mirror.hpp st/motion_actpos_mirror.st $(MAPGEN)
	@mkdir -p $(dir $@)
	$(PYTHON) $(MAPGEN) --header src/generated/motion_actpos_mirror.hpp --st-source st/motion_actpos_mirror.st --output $@

regen:
	strucpp st/machine.st -o src/generated/machine.cpp
	strucpp st/el7041_velocity.st -o src/generated/el7041_velocity.cpp
	strucpp st/motion_actpos_mirror.st -o src/generated/motion_actpos_mirror.cpp
	@mkdir -p $(STLIB_DIR)
	strucpp --compile-lib lib/ecmc_motion.st -o $(STLIB_DIR) --lib-name ecmc-motion --lib-version 0.1.0 --lib-namespace ecmc_motion --no-default-libs
	$(PYTHON) $(PATCH_STLIB_HEADERS) --stlib $(ECMC_MOTION_STLIB) --header ecmcMcApi.h
	strucpp st/mc_power_move_absolute_lib.st -o src/generated/mc_power_move_absolute_lib.cpp -L $(STLIB_DIR)

regen-container:
	$(PODMAN) run --rm \
		-v $(STRUCPP):/src/strucpp:ro \
		-v $(CURDIR):/src/app \
		$(NODE_IMAGE) \
		bash -lc "set -euo pipefail; cp -R /src/strucpp /tmp/strucpp; cd /tmp/strucpp; npm ci --ignore-scripts; npm run build; mkdir -p /src/app/$(STLIB_DIR); node dist/cli.js /src/app/st/machine.st -o /src/app/src/generated/machine.cpp; node dist/cli.js /src/app/st/el7041_velocity.st -o /src/app/src/generated/el7041_velocity.cpp; node dist/cli.js /src/app/st/motion_actpos_mirror.st -o /src/app/src/generated/motion_actpos_mirror.cpp; node dist/cli.js --compile-lib /src/app/lib/ecmc_motion.st -o /src/app/$(STLIB_DIR) --lib-name ecmc-motion --lib-version 0.1.0 --lib-namespace ecmc_motion --no-default-libs"
	$(PYTHON) $(PATCH_STLIB_HEADERS) --stlib $(ECMC_MOTION_STLIB) --header ecmcMcApi.h
	$(PODMAN) run --rm \
		-v $(STRUCPP):/src/strucpp:ro \
		-v $(CURDIR):/src/app \
		$(NODE_IMAGE) \
		bash -lc "set -euo pipefail; cp -R /src/strucpp /tmp/strucpp; cd /tmp/strucpp; npm ci --ignore-scripts; npm run build; node dist/cli.js /src/app/st/mc_power_move_absolute_lib.st -o /src/app/src/generated/mc_power_move_absolute_lib.cpp -L /src/app/$(STLIB_DIR)"

maps: $(MACHINE_MAP) $(EL7041_VELOCITY_MAP) $(MOTION_ACTPOS_MIRROR_MAP)

clean:
	rm -rf $(BUILD_DIR)
