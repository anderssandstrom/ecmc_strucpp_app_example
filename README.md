# `ecmc_strucpp_app_example`

This is a minimal sample ST application repo for
[`ecmc_plugin_strucpp`](../ecmc_plugin_strucpp).

It builds one loadable logic library:

- `build/machine_logic.so`
- or `build/machine_logic.dylib` on macOS
- `build/el7041_velocity_logic.so`
- or `build/el7041_velocity_logic.dylib` on macOS

Those logic libraries are what the generic `ecmc_plugin_strucpp` host loads through
its `logic_lib=...` config string.

## Layout

- [`st/machine.st`](st/machine.st)
  sample ST source
- [`src/generated/machine.hpp`](src/generated/machine.hpp)
- [`src/generated/machine.cpp`](src/generated/machine.cpp)
  real generated `STruCpp` output
- [`src/machine_logic.cpp`](src/machine_logic.cpp)
  tiny ABI wrapper that exposes the memmap sample logic library entry point
- [`st/el7041_velocity.st`](st/el7041_velocity.st)
  EL7041 velocity-only ST sample
- [`src/generated/el7041_velocity.hpp`](src/generated/el7041_velocity.hpp)
- [`src/generated/el7041_velocity.cpp`](src/generated/el7041_velocity.cpp)
  real generated `STruCpp` output for the EL7041 sample
- [`src/el7041_velocity_logic.cpp`](src/el7041_velocity_logic.cpp)
  wrapper for the EL7041 velocity-only logic library

In a real application repo, the only handwritten file should normally be the
logic wrapper.

## Build

```sh
make STRUCPP=/path/to/strucpp ECMC_PLUGIN_STRUCPP=/path/to/ecmc_plugin_strucpp
```

Defaults:

- `STRUCPP=../strucpp`
- `ECMC_PLUGIN_STRUCPP=../ecmc_plugin_strucpp`

## Wrapper Pattern

The wrapper uses the public helper installed by `ecmc_plugin_strucpp`:

```cpp
#include "ecmcStrucppLogicWrapper.hpp"
#include "my_program.hpp"

ECMC_STRUCPP_DECLARE_LOGIC_API("my_logic",
                               strucpp::Program_MYPROGRAM,
                               strucpp::locatedVars);
```

## Regeneration

The checked-in generated files were produced from [`st/machine.st`](st/machine.st)
with `strucpp`. To regenerate them on a machine with `strucpp` in `PATH`:

```sh
make regen
```

If you do not want to install Node or `strucpp` on the host, you can regenerate
through Podman:

```sh
make regen-container
```

## IOC Usage

Build the generic host plugin in `../ecmc_plugin_strucpp`, configure a real
slave, then point the host at the logic library from this repo.

The concrete sample in `../ecmc_plugin_strucpp/examples/loadPluginExample.cmd`
uses channel 1 of an `EL6002` and binds:

- `%I*` to `ec0.s${ECMC_EC_SLAVE_NUM}.mm.inputDataArray01`
- `%Q*` to `ec0.s${ECMC_EC_SLAVE_NUM}.mm.outputDataArray01`

The final plugin load looks like:

```iocsh
${SCRIPTEXEC} $(ecmc_plugin_strucpp_DIR)startup.cmd, "PLUGIN_ID=0,LOGIC_LIB=/absolute/path/to/machine_logic.so,INPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.inputDataArray01,OUTPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.outputDataArray01,MEMORY_BYTES=64,REPORT=1"
```

There is also an EL7041 velocity example in
`../ecmc_plugin_strucpp/examples/loadEL7041VelocityExample.cmd` that binds:

- `%I*` to `ec0.s${ECMC_EC_SLAVE_NUM}.positionActual01`
- `%QW0` to `driveControl01`
- `%QW2` to `velocitySetpoint01`

That example uses the host plugin's startup-linked `mapping_file` mode rather
than an extra memmap. The generic host reads the ST located variables, checks
that the manifest covers the exact `%IW0`, `%QW0`, and `%QW2` addresses used by
the program, and links those addresses to the final `ecmcDataItem` buffers once
before the RT loop starts.
