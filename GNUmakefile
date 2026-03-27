BUILD_DIR ?= build

STRUCPP ?= $(abspath ../strucpp)
ECMC_PLUGIN_STRUCPP ?= $(abspath ../ecmc_plugin_strucpp)
PODMAN ?= podman
NODE_IMAGE ?= docker.io/library/node:20

LOGIC_MODULES := machine_logic el7041_velocity_logic

CXX ?= c++
CXXFLAGS += -std=c++17 -fPIC -Wall -Wextra
CPPFLAGS += -I$(STRUCPP)/src/runtime/include
CPPFLAGS += -I$(ECMC_PLUGIN_STRUCPP)/src
CPPFLAGS += -Isrc
CPPFLAGS += -Isrc/generated

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS += -dynamiclib
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

MACHINE_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(MACHINE_SOURCES))
EL7041_VELOCITY_OBJECTS := $(patsubst src/%.cpp,$(BUILD_DIR)/%.o,$(EL7041_VELOCITY_SOURCES))

MACHINE_TARGET := $(BUILD_DIR)/machine_logic.$(LIBEXT)
EL7041_VELOCITY_TARGET := $(BUILD_DIR)/el7041_velocity_logic.$(LIBEXT)
TARGETS := $(MACHINE_TARGET) $(EL7041_VELOCITY_TARGET)

.PHONY: all clean regen regen-container

all: $(TARGETS)

$(MACHINE_TARGET): $(MACHINE_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(MACHINE_OBJECTS) $(LDFLAGS) -o $@

$(EL7041_VELOCITY_TARGET): $(EL7041_VELOCITY_OBJECTS)
	@mkdir -p $(dir $@)
	$(CXX) $(EL7041_VELOCITY_OBJECTS) $(LDFLAGS) -o $@

$(BUILD_DIR)/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

regen:
	strucpp st/machine.st -o src/generated/machine.cpp
	strucpp st/el7041_velocity.st -o src/generated/el7041_velocity.cpp

regen-container:
	$(PODMAN) run --rm \
		-v $(STRUCPP):/src/strucpp:ro \
		-v $(CURDIR):/src/app \
		$(NODE_IMAGE) \
		bash -lc "set -euo pipefail; cp -R /src/strucpp /tmp/strucpp; cd /tmp/strucpp; npm ci --ignore-scripts; npm run build; node dist/cli.js /src/app/st/machine.st -o /src/app/src/generated/machine.cpp; node dist/cli.js /src/app/st/el7041_velocity.st -o /src/app/src/generated/el7041_velocity.cpp"

clean:
	rm -rf $(BUILD_DIR)
