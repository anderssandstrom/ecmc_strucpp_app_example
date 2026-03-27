# `ecmc_strucpp_app_example`

This is a minimal sample ST application repo for
[`ecmc_plugin_strucpp`](../ecmc_plugin_strucpp).

It builds one loadable logic library:

- `build/machine_logic.so`
- or `build/machine_logic.dylib` on macOS
- `build/el7041_velocity_logic.so`
- or `build/el7041_velocity_logic.dylib` on macOS
- `build/motion_actpos_mirror_logic.so`
- or `build/motion_actpos_mirror_logic.dylib` on macOS
- `build/mc_power_move_abs_logic.so`
- or `build/mc_power_move_abs_logic.dylib` on macOS
- `build/mc_power_move_absolute_lib_logic.so`
- or `build/mc_power_move_absolute_lib_logic.dylib` on macOS
- `build/mc_power_move_velocity_lib_logic.so`
- or `build/mc_power_move_velocity_lib_logic.dylib` on macOS
- `build/mc_power_move_relative_lib_logic.so`
- or `build/mc_power_move_relative_lib_logic.dylib` on macOS
- `build/machine.map`
- `build/el7041_velocity.map`
- `build/motion_actpos_mirror.map`

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
- [`st/motion_actpos_mirror.st`](st/motion_actpos_mirror.st)
  motion-data sample using `ax1.enc.actpos` and `ax1.traj.targetpos`
- [`src/generated/motion_actpos_mirror.hpp`](src/generated/motion_actpos_mirror.hpp)
- [`src/generated/motion_actpos_mirror.cpp`](src/generated/motion_actpos_mirror.cpp)
  real generated `STruCpp` output for the motion-data sample
- [`src/motion_actpos_mirror_logic.cpp`](src/motion_actpos_mirror_logic.cpp)
  wrapper for the motion-data logic library
- [`src/mc_power_move_abs_logic.cpp`](src/mc_power_move_abs_logic.cpp)
  manual logic-library example that uses `MC_Power`, `MC_MoveAbsolute`, and
  `MC_ReadActualPosition` through [`ecmcStrucppMcWrapper.hpp`](../ecmc_plugin_strucpp/src/ecmcStrucppMcWrapper.hpp)
- [`lib/ecmc_motion.st`](lib/ecmc_motion.st)
  local `STruCpp` motion library source that defines `ECMC_AXIS_REF`,
  `MC_Power`, `MC_MoveAbsolute`, and `MC_ReadActualPosition`
- [`st/mc_power_move_absolute_lib.st`](st/mc_power_move_absolute_lib.st)
  real ST sample program using the local motion library
- [`src/generated/mc_power_move_absolute_lib.hpp`](src/generated/mc_power_move_absolute_lib.hpp)
- [`src/generated/mc_power_move_absolute_lib.cpp`](src/generated/mc_power_move_absolute_lib.cpp)
  generated `STruCpp` output for the motion-library sample
- [`src/mc_power_move_absolute_lib_logic.cpp`](src/mc_power_move_absolute_lib_logic.cpp)
  tiny ABI wrapper for the motion-library sample
- [`st/mc_power_move_velocity_lib.st`](st/mc_power_move_velocity_lib.st)
  real ST sample program using `MC_Power`, `MC_MoveVelocity`, `MC_ReadStatus`,
  and `MC_ReadActualVelocity`
- [`src/generated/mc_power_move_velocity_lib.hpp`](src/generated/mc_power_move_velocity_lib.hpp)
- [`src/generated/mc_power_move_velocity_lib.cpp`](src/generated/mc_power_move_velocity_lib.cpp)
  generated `STruCpp` output for the motion velocity sample
- [`src/mc_power_move_velocity_lib_logic.cpp`](src/mc_power_move_velocity_lib_logic.cpp)
  tiny ABI wrapper for the motion velocity sample
- [`st/mc_power_move_relative_lib.st`](st/mc_power_move_relative_lib.st)
  real ST sample program using `MC_Power`, `MC_MoveRelative`, `MC_ReadStatus`,
  and `MC_ReadActualPosition`
- [`src/generated/mc_power_move_relative_lib.hpp`](src/generated/mc_power_move_relative_lib.hpp)
- [`src/generated/mc_power_move_relative_lib.cpp`](src/generated/mc_power_move_relative_lib.cpp)
  generated `STruCpp` output for the motion relative sample
- [`src/mc_power_move_relative_lib_logic.cpp`](src/mc_power_move_relative_lib_logic.cpp)
  tiny ABI wrapper for the motion relative sample
- [`scripts/patch_stlib_headers.py`](scripts/patch_stlib_headers.py)
  helper that restores required external headers inside the compiled `.stlib`

In a real application repo, the only handwritten file should normally be the
logic wrapper. If you want startup-linked `ecmc` maps, add `// @ecmc ...`
annotations next to the located ST declarations.

## Build

```sh
make STRUCPP=/path/to/strucpp ECMC_PLUGIN_STRUCPP=/path/to/ecmc_plugin_strucpp
```

Defaults:

- `STRUCPP=../strucpp`
- `ECMC_PLUGIN_STRUCPP=../ecmc_plugin_strucpp`

`make all` now builds all logic libraries and all generated `.map` files.
If you only want to regenerate the mapping files:

```sh
make maps
```

Those `.map` files are generated from the `// @ecmc <ecmcDataItem>` comments in
[`st/machine.st`](st/machine.st) and
[`st/el7041_velocity.st`](st/el7041_velocity.st).

The `mc_power_move_abs_logic` sample is different: it is a handwritten C++
logic library rather than generated ST. That is intentional. It demonstrates
the new PLCopen-style `MC_*` wrapper path without assuming external function
block support in `STruCpp`.

There is now also a real ST-based motion sample, `mc_power_move_absolute_lib`.
That path uses a local `.stlib` library compiled from [`lib/ecmc_motion.st`](lib/ecmc_motion.st).
The library function blocks call into [`ecmcMcApi.h`](../ecmc/devEcmcSup/motion/ecmcMcApi.h)
through `STruCpp` `{external ...}` blocks.

The library now exposes a more useful first subset:

- `MC_Power`
- `MC_Reset`
- `MC_MoveAbsolute`
- `MC_MoveRelative`
- `MC_MoveVelocity`
- `MC_Home`
- `MC_Halt`
- `MC_ReadStatus`
- `MC_ReadActualPosition`
- `MC_ReadActualVelocity`

`STruCpp` currently clears `manifest.headers` when producing a `.stlib`, so the
sample build patches the archive afterward to restore `ecmcMcApi.h`. That keeps
the consumer compile generic without carrying a private fork of `STruCpp`.

It uses one contiguous input image and one contiguous output image with this
layout, hard-wired to axis `0`:

- Inputs:
  - `%IX0.0` `power_enable`
  - `%IX0.1` `move_execute`
  - `%IL8` `target_position`
  - `%IL16` `velocity`
  - `%IL24` `acceleration`
  - `%IL32` `deceleration`
- Outputs:
  - `%QX0.0` `power_status`
  - `%QX0.1` `power_valid`
  - `%QX0.2` `move_busy`
  - `%QX0.3` `move_done`
  - `%QX0.4` `move_error`
  - `%QD4` `move_error_id`
  - `%QL8` `actual_position`

So this sample wants an input buffer of at least `40` bytes and an output
buffer of at least `16` bytes.

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

For that sample, point `MAPPING_FILE` at the generated
`build/el7041_velocity.map`.

There is also a motion-data example in
`../ecmc_plugin_strucpp/examples/loadMotionActposMirrorExample.cmd` that binds:

- `%IL0` to `ax1.enc.actpos`
- `%QL0` to `ax1.traj.targetpos`

For that sample, point `LOGIC_LIB` at `build/motion_actpos_mirror_logic.*` and
`MAPPING_FILE` at `build/motion_actpos_mirror.map`.

For the new `MC_Power` + `MC_MoveAbsolute` sample, point `LOGIC_LIB` at
`build/mc_power_move_abs_logic.*` and bind it with the host plugin's
contiguous-image mode:

```iocsh
${SCRIPTEXEC} $(ecmc_plugin_strucpp_DIR)startup.cmd, "PLUGIN_ID=0,LOGIC_LIB=/absolute/path/to/mc_power_move_abs_logic.so,INPUT_ITEM=<40-byte-input-item>,OUTPUT_ITEM=<16-byte-output-item>,MEMORY_BYTES=16,REPORT=1"
```

The sample itself does not depend on EtherCAT. The two items only need to be
contiguous `ecmcDataItem` buffers of the required sizes.

The ST-based `mc_power_move_absolute_lib` sample uses the same contiguous image
layout as the handwritten `mc_power_move_abs_logic` example:

- Inputs:
  - `%IX0.0` `enableCmd`
  - `%IX0.1` `executeCmd`
  - `%IL8` `targetPos`
  - `%IL16` `velocity`
  - `%IL24` `accel`
  - `%IL32` `decel`
- Outputs:
  - `%QX0.0` `powerStatus`
  - `%QX0.1` `powerValid`
  - `%QX0.2` `moveBusy`
  - `%QX0.3` `moveDone`
  - `%QX0.4` `moveError`
  - `%QD4` `moveErrorId`
  - `%QL8` `actualPos`

So it also wants an input buffer of at least `40` bytes and an output buffer of
at least `16` bytes.

## Motion Library Regeneration

To rebuild the local motion `.stlib` and regenerate the ST-based motion sample:

```sh
make regen
```

or with Podman:

```sh
make regen-container
```

That produces:

- `build/stlib/ecmc-motion.stlib`
- `src/generated/mc_power_move_absolute_lib.hpp`
- `src/generated/mc_power_move_absolute_lib.cpp`

For IOC use, point `LOGIC_LIB` at `build/mc_power_move_absolute_lib_logic.*`
and use the same contiguous input/output image sizes as the handwritten motion
sample.

There is also a velocity-oriented ST sample, `mc_power_move_velocity_lib`, with
this layout:

- Inputs:
  - `%IX0.0` `enableCmd`
  - `%IX0.1` `executeCmd`
  - `%IL8` `velocityCmd`
  - `%IL16` `accelCmd`
  - `%IL24` `decelCmd`
- Outputs:
  - `%QX0.0` `powerStatus`
  - `%QX0.1` `powerValid`
  - `%QX0.2` `inVelocity`
  - `%QX0.3` `moveBusy`
  - `%QX0.4` `moveError`
  - `%QX0.5` `standStill`
  - `%QX0.6` `contMotion`
  - `%QX0.7` `errorStop`
  - `%QD4` `moveErrorId`
  - `%QL8` `actualVel`

So it wants an input buffer of at least `32` bytes and an output buffer of at
least `16` bytes.

There is also a relative-move ST sample, `mc_power_move_relative_lib`, with
this layout:

- Inputs:
  - `%IX0.0` `enableCmd`
  - `%IX0.1` `executeCmd`
  - `%IL8` `distanceCmd`
  - `%IL16` `velocityCmd`
  - `%IL24` `accelCmd`
  - `%IL32` `decelCmd`
- Outputs:
  - `%QX0.0` `powerStatus`
  - `%QX0.1` `powerValid`
  - `%QX0.2` `moveBusy`
  - `%QX0.3` `moveDone`
  - `%QX0.4` `moveError`
  - `%QX0.5` `standStill`
  - `%QX0.6` `discreteMove`
  - `%QX0.7` `errorStop`
  - `%QD4` `moveErrorId`
  - `%QL8` `actualPos`

So it wants an input buffer of at least `40` bytes and an output buffer of at
least `16` bytes.
