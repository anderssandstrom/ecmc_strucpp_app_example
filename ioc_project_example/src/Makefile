PROGRAM := machine
LOGIC_NAME := $(PROGRAM)_logic

PROJECT_BIN_DIR := ../bin
GEN_DIR := generated

STRUCPP ?= ../../../strucpp
STRUCPP_CLI ?= strucpp
ECMC_PLUGIN_STRUCPP ?= ../../../ecmc_plugin_strucpp
PYTHON ?= python3
EPICS_VERSION ?= 3.14.12
OS_CLASS ?= RHEL7
CPU_ARCH ?= x86_64

MAPGEN := $(ECMC_PLUGIN_STRUCPP)/scripts/strucpp_mapgen.py
EXPORTGEN := $(ECMC_PLUGIN_STRUCPP)/scripts/strucpp_epics_exportgen.py
SUBSTGEN := $(ECMC_PLUGIN_STRUCPP)/scripts/strucpp_epics_substgen.py

CXX ?= c++
CXXFLAGS += -std=c++17 -fPIC -Wall -Wextra
CPPFLAGS += -I$(STRUCPP)/src/runtime/include
CPPFLAGS += -I$(ECMC_PLUGIN_STRUCPP)/src
CPPFLAGS += -I.
CPPFLAGS += -I$(GEN_DIR)

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LDFLAGS += -dynamiclib -undefined dynamic_lookup
LIBEXT := dylib
else
LDFLAGS += -shared
LIBEXT := so
endif

ODIR := O.$(EPICS_VERSION)_$(OS_CLASS)-$(CPU_ARCH)

GEN_CPP := $(GEN_DIR)/$(PROGRAM).cpp
GEN_HPP := $(GEN_DIR)/$(PROGRAM).hpp
EXPORTS_HPP := $(GEN_DIR)/$(PROGRAM)_epics_exports.hpp

LOGIC_LIB := $(ODIR)/$(LOGIC_NAME).$(LIBEXT)
MAP_FILE := $(LOGIC_LIB).map
SUBST_FILE := $(LOGIC_LIB).substitutions

STAGED_LOGIC_LIB := $(PROJECT_BIN_DIR)/$(LOGIC_NAME).$(LIBEXT)
STAGED_MAP_FILE := $(STAGED_LOGIC_LIB).map
STAGED_SUBST_FILE := $(STAGED_LOGIC_LIB).substitutions

OBJS := $(ODIR)/$(PROGRAM).o $(ODIR)/$(LOGIC_NAME).o

.PHONY: all clean regen maps stage

all: $(LOGIC_LIB) $(MAP_FILE) $(SUBST_FILE)

stage: all $(STAGED_LOGIC_LIB) $(STAGED_MAP_FILE) $(STAGED_SUBST_FILE)

regen: $(GEN_CPP)

$(GEN_CPP): $(PROGRAM).st
	mkdir -p $(GEN_DIR)
	$(STRUCPP_CLI) $< -o $@

$(EXPORTS_HPP): $(GEN_HPP) $(PROGRAM).st $(EXPORTGEN)
	$(PYTHON) $(EXPORTGEN) --st-source $(PROGRAM).st --header $(GEN_HPP) --header-include generated/$(PROGRAM).hpp --output $@

$(MAP_FILE): $(GEN_HPP) $(PROGRAM).st $(MAPGEN)
	mkdir -p $(ODIR)
	$(PYTHON) $(MAPGEN) --header $(GEN_HPP) --st-source $(PROGRAM).st --output $@

$(SUBST_FILE): $(PROGRAM).st $(SUBSTGEN)
	mkdir -p $(ODIR)
	$(PYTHON) $(SUBSTGEN) --st-source $(PROGRAM).st --output $@

$(ODIR)/$(PROGRAM).o: $(GEN_CPP)
	mkdir -p $(ODIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(ODIR)/$(LOGIC_NAME).o: $(LOGIC_NAME).cpp $(EXPORTS_HPP)
	mkdir -p $(ODIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(LOGIC_LIB): $(OBJS)
	mkdir -p $(ODIR)
	$(CXX) $(OBJS) $(LDFLAGS) -o $@

$(STAGED_LOGIC_LIB): $(LOGIC_LIB)
	mkdir -p $(PROJECT_BIN_DIR)
	cp $< $@

$(STAGED_MAP_FILE): $(MAP_FILE)
	mkdir -p $(PROJECT_BIN_DIR)
	cp $< $@

$(STAGED_SUBST_FILE): $(SUBST_FILE)
	mkdir -p $(PROJECT_BIN_DIR)
	cp $< $@

maps: $(MAP_FILE) $(SUBST_FILE)

clean:
	rm -rf $(ODIR) $(GEN_DIR) $(PROJECT_BIN_DIR)
