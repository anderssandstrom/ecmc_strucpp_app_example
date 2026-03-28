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
- `build/motion_velocity_direct_logic.so`
- or `build/motion_velocity_direct_logic.dylib` on macOS
- `build/mc_power_move_abs_logic.so`
- or `build/mc_power_move_abs_logic.dylib` on macOS
- `build/mc_power_move_absolute_lib_logic.so`
- or `build/mc_power_move_absolute_lib_logic.dylib` on macOS
- `build/mc_power_move_velocity_lib_logic.so`
- or `build/mc_power_move_velocity_lib_logic.dylib` on macOS
- `build/mc_power_move_relative_lib_logic.so`
- or `build/mc_power_move_relative_lib_logic.dylib` on macOS
- `build/machine_logic.so.map`
- or `build/machine_logic.dylib.map` on macOS
- `build/machine_logic.so.substitutions`
- or `build/machine_logic.dylib.substitutions` on macOS
- `build/el7041_velocity_logic.so.map`
- or `build/el7041_velocity_logic.dylib.map` on macOS
- `build/motion_actpos_mirror_logic.so.map`
- or `build/motion_actpos_mirror_logic.dylib.map` on macOS
- `build/motion_velocity_direct_logic.so.map`
- or `build/motion_velocity_direct_logic.dylib.map` on macOS

Those logic libraries are what the generic `ecmc_plugin_strucpp` host loads through
its `logic_lib=...` config string.

## Layout

- [`st/machine.st`](st/machine.st)
  sample ST source
- [`src/generated/machine.hpp`](src/generated/machine.hpp)
- [`src/generated/machine.cpp`](src/generated/machine.cpp)
  real generated `STruCpp` output
- [`src/generated/machine_epics_exports.hpp`](src/generated/machine_epics_exports.hpp)
  generated export table from `// @epics ...` annotations in the ST source
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
- [`st/motion_velocity_direct.st`](st/motion_velocity_direct.st)
  direct-mapped motion sample using `ax1.enc.actpos`, `ax1.traj.targetvel`,
  and `ax1.drv.enable`
- [`src/generated/motion_velocity_direct.hpp`](src/generated/motion_velocity_direct.hpp)
- [`src/generated/motion_velocity_direct.cpp`](src/generated/motion_velocity_direct.cpp)
  generated `STruCpp` output for the direct-mapped motion sample
- [`src/motion_velocity_direct_logic.cpp`](src/motion_velocity_direct_logic.cpp)
  wrapper for the direct-mapped motion logic library
- [`src/mc_power_move_abs_logic.cpp`](src/mc_power_move_abs_logic.cpp)
  manual logic-library example that uses `MC_Power`, `MC_MoveAbsolute`, and
  `MC_ReadActualPosition` through [`ecmcStrucppMcWrapper.hpp`](../ecmc_plugin_strucpp/src/ecmcStrucppMcWrapper.hpp)
- [`st/mc_power_move_absolute_lib.st`](st/mc_power_move_absolute_lib.st)
  real ST sample program using the shared motion library
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
- [`ioc_project_example`](ioc_project_example)
  best-guess `gfa-iocutils`-style IOC project layout that keeps Structured Text
  in an IOC project, stages the runtime artifacts into a top-level `bin/`
  directory, and then runs `ioc install`
- [`ioc_project_minimal`](ioc_project_minimal)
  smallest practical `gfa-iocutils`-style IOC project with one ST file and no
  handwritten C++ sources

In a real application repo, the only handwritten file should normally be the
logic wrapper. If you want startup-linked `ecmc` maps, add `// @ecmc ...`
annotations next to the located ST declarations. If you want selected internal
ST variables visible in EPICS, add `// @epics ...` annotations next to the ST
variable declarations.

## Build

```sh
make STRUCPP=/path/to/strucpp ECMC_PLUGIN_STRUCPP=/path/to/ecmc_plugin_strucpp
```

Defaults:

- `STRUCPP=../strucpp`
- `ECMC_PLUGIN_STRUCPP=../ecmc_plugin_strucpp`

`make all` now builds all logic libraries and all generated `.map` files next
to the corresponding logic library.
The shared helper workflow also generates `${LOGIC_LIB}.summary.txt` reports
and supports `make validate` for dry-run checking before runtime. This sample
repo still uses its own makefile, but the same generators and stricter checks
apply to the generated `.map` and `.substitutions` files.
If you only want to regenerate the mapping files:

```sh
make maps
```

Those `.map` files are generated from the `// @ecmc <ecmcDataItem>` comments in
the ST source and follow the same naming convention as the logic library:

- `build/<logic_lib>.$(LIBEXT).map`

The `machine` sample also generates
[`src/generated/machine_epics_exports.hpp`](src/generated/machine_epics_exports.hpp)
from the `// @epics ...` comments in [`st/machine.st`](st/machine.st). That is
what lets `ecmc_plugin_strucpp` publish `counter` and `manual_target` as EPICS
asyn parameters directly from the ST source.

The same annotations also generate a substitutions file next to the logic
library, for example
[`build/machine_logic.dylib.substitutions`](build/machine_logic.dylib.substitutions)
on macOS or `build/machine_logic.so.substitutions` on Linux, via
[`strucpp_epics_substgen.py`](../ecmc_plugin_strucpp/scripts/strucpp_epics_substgen.py).
That substitutions file references the generic templates shipped by
[`ecmc_plugin_strucpp`](../ecmc_plugin_strucpp), so the ST source can also be
the single source of truth for the EPICS record layer.

## IOC Project Example

The directory [`ioc_project_example`](ioc_project_example) is a best-guess
example for a `gfa-iocutils`-managed IOC project.

The important assumptions behind that example are:

- `ioc install` deploys files, but does not run the `strucpp` generation/build
  step for you
- compiled IOC libraries are expected to come from `src/O.<epics_ver>_<arch>`
  and are installed into the IOC `bin/` directory
- `.map` and `.substitutions` are not special install file types in
  `gfa-iocutils`

So the example project does this:

- keeps the ST source and wrapper in [`ioc_project_example/src`](ioc_project_example/src)
- builds the logic library plus `${LOGIC_LIB}.map` and
  `${LOGIC_LIB}.substitutions`
- stages those runtime artifacts into [`ioc_project_example/bin`](ioc_project_example/bin)
- uses [`STRUCPP-IOC-EXAMPLE_startup.script`](ioc_project_example/STRUCPP-IOC-EXAMPLE_startup.script)
  to load `bin/machine_logic.so`

The richer IOC example now also maps directly to EL7041 EtherCAT items:

- `ec0.s14.positionActual01`
- `ec0.s14.driveControl01`
- `ec0.s14.velocitySetpoint01`

The example now uses the reusable helper shipped by
[`ecmc_plugin_strucpp`](../ecmc_plugin_strucpp):

- [`templates/strucpp_ioc_logic.make`](../ecmc_plugin_strucpp/templates/strucpp_ioc_logic.make)
- [`scripts/strucpp_logic_wrappergen.py`](../ecmc_plugin_strucpp/scripts/strucpp_logic_wrappergen.py)

That choice is deliberate. If the `.map` and `.substitutions` files were placed
in `cfg/`, then startup would need explicit `MAPPING_FILE=cfg/...` and
`EPICS_SUBST=cfg/...` arguments. By staging them in `bin/` next to the logic
library, the default plugin conventions work:

- `${LOGIC_LIB}.map`
- `${LOGIC_LIB}.substitutions`

So the default mapping/export startup path stays minimal.

If an IOC project needs a small amount of handwritten C++ glue, the example now
also includes concrete opt-in files under
[`ioc_project_example/src`](ioc_project_example/src):

- [`Makefile.with_cpp`](ioc_project_example/src/Makefile.with_cpp)
- [`custom_logic_wrapper.cpp`](ioc_project_example/src/custom_logic_wrapper.cpp)
- [`machine_helper.cpp`](ioc_project_example/src/machine_helper.cpp)

Those are not used by default, but they show how to override the generated
wrapper and compile extra C++ into the same logic library without changing the
overall IOC workflow.

## Minimal IOC Project Example

The directory [`ioc_project_minimal`](ioc_project_minimal) is the shortest
path for a real IOC project:

- one ST file in [`src/machine.st`](ioc_project_minimal/src/machine.st)
- one short [`src/Makefile`](ioc_project_minimal/src/Makefile)
- no handwritten C++ sources
- startup only passes `LOGIC_LIB`

It uses the same shared helper and the same `bin/` staging convention, but
removes the split-ST and C++ extension-point material so the default workflow
is easier to copy.

Unlike the older memmap-style sample, the minimal IOC example now maps
directly to EtherCAT item names for an EL7041:

- `ec0.s14.positionActual01`
- `ec0.s14.driveControl01`
- `ec0.s14.velocitySetpoint01`

The `mc_power_move_abs_logic` sample is different: it is a handwritten C++
logic library rather than generated ST. That is intentional. It demonstrates
the new PLCopen-style `MC_*` wrapper path without assuming external function
block support in `STruCpp`.

There is now also a real ST-based motion sample, `mc_power_move_absolute_lib`.
That path uses the reusable bundled motion library from
[`../ecmc_plugin_strucpp/libs/ecmc-motion.stlib`](../ecmc_plugin_strucpp/libs/ecmc-motion.stlib).
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

The sample app no longer rebuilds that library itself. It just consumes the
shared `.stlib` from `ecmc_plugin_strucpp`, which keeps rebuilds shorter and
avoids per-app duplication.

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

If the ST source also exports EPICS variables, the wrapper can auto-pick the
generated `*_epics_exports.hpp` file with `__has_include(...)` and switch to
the export-aware ABI without further manual changes. The `machine_logic.cpp`
sample shows that pattern.

The explicit export-aware form is still available:

```cpp
#include "generated/my_program_epics_exports.hpp"

ECMC_STRUCPP_DECLARE_LOGIC_API_WITH_EXPORTS(
  "my_logic",
  strucpp::Program_MYPROGRAM,
  strucpp::locatedVars,
  ecmcStrucppExports::initProgram_MYPROGRAMExports);
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

Preferred direct-mapping examples:

- `../ecmc_plugin_strucpp/examples/loadEL7041VelocityExample.cmd`
- `../ecmc_plugin_strucpp/examples/loadMotionActposMirrorExample.cmd`
- `../ecmc_plugin_strucpp/examples/loadMotionVelocityDirectExample.cmd`
- [`ioc_project_example`](ioc_project_example)
- [`ioc_project_minimal`](ioc_project_minimal)

These show the preferred current pattern:

- `// @ecmc ...` in ST
- generated `${LOGIC_LIB}.map`
- startup only passes `LOGIC_LIB` in the common case

The concrete sample in `../ecmc_plugin_strucpp/examples/loadPluginExample.cmd`
is kept intentionally as the contiguous-image example. It uses channel 1 of an
`EL6002` and binds:

- `%I*` to `ec0.s${ECMC_EC_SLAVE_NUM}.mm.inputDataArray01`
- `%Q*` to `ec0.s${ECMC_EC_SLAVE_NUM}.mm.outputDataArray01`

The final plugin load is intended to happen through `require`, which makes
`$(ecmc_plugin_strucpp_DIR)` available and auto-executes the plugin startup
helper. It can also auto-load the generated substitutions file:

```iocsh
require ecmc_plugin_strucpp sandst_a "PLUGIN_ID=0,LOGIC_LIB=/absolute/path/to/machine_logic.so,ASYN_PORT=PLUGIN.STRUCPP0,INPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.inputDataArray01,OUTPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.outputDataArray01,MEMORY_BYTES=64,EPICS_SUBST=/absolute/path/to/build/machine_logic.so.substitutions,REPORT=1"
```

That sample also exports two internal ST variables on the plugin-owned asyn
port `PLUGIN.STRUCPP0`:

- `plugin.strucpp.machine.counter` as read-only
- `plugin.strucpp.machine.manual_target` as writable

If you omit `EPICS_SUBST`, the helper defaults to `${LOGIC_LIB}.substitutions`
when `DB_PREFIX` or `DB_MACROS` is set. So the normal call can be:

```iocsh
require ecmc_plugin_strucpp sandst_a "PLUGIN_ID=0,LOGIC_LIB=/absolute/path/to/machine_logic.so,ASYN_PORT=PLUGIN.STRUCPP0,INPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.inputDataArray01,OUTPUT_ITEM=ec0.s${ECMC_EC_SLAVE_NUM}.mm.outputDataArray01,MEMORY_BYTES=64,REPORT=1"
```

That automatically loads matching records through `dbLoadTemplate(...)` with:

- `P=$(IOC)` by default, or `P=$(DB_PREFIX)` if set explicitly
- `PORT=PLUGIN.STRUCPP0`

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

For that sample, the preferred default is the generated
`build/el7041_velocity_logic.*.map` next to the logic library, so
`MAPPING_FILE` can normally be omitted.

There is also a motion-data example in
`../ecmc_plugin_strucpp/examples/loadMotionActposMirrorExample.cmd` that binds:

- `%IL0` to `ax1.enc.actpos`
- `%QL0` to `ax1.traj.targetpos`

For that sample, point `LOGIC_LIB` at `build/motion_actpos_mirror_logic.*`.
The plugin defaults `MAPPING_FILE` to `build/motion_actpos_mirror_logic.*.map`.

There is also a direct-mapped motion velocity example in
`../ecmc_plugin_strucpp/examples/loadMotionVelocityDirectExample.cmd` that
binds:

- `%IL0` to `ax1.enc.actpos`
- `%QL0` to `ax1.traj.targetvel`
- `%QX8.0` to `ax1.drv.enable`

For that sample, point `LOGIC_LIB` at `build/motion_velocity_direct_logic.*`.
The plugin defaults `MAPPING_FILE` to `build/motion_velocity_direct_logic.*.map`.

The motion-block samples are still contiguous-image examples by design. For
the new `MC_Power` + `MC_MoveAbsolute` sample, point `LOGIC_LIB` at
`build/mc_power_move_abs_logic.*` and bind it with the host plugin's
contiguous-image mode:

```iocsh
require ecmc_plugin_strucpp sandst_a "PLUGIN_ID=0,LOGIC_LIB=/absolute/path/to/mc_power_move_abs_logic.so,INPUT_ITEM=<40-byte-input-item>,OUTPUT_ITEM=<16-byte-output-item>,MEMORY_BYTES=16,REPORT=1"
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

## Motion Library

The reusable motion library now lives in
[`../ecmc_plugin_strucpp`](../ecmc_plugin_strucpp):

- [`../ecmc_plugin_strucpp/lib/ecmc_motion.st`](../ecmc_plugin_strucpp/lib/ecmc_motion.st)
- [`../ecmc_plugin_strucpp/libs/ecmc-motion.stlib`](../ecmc_plugin_strucpp/libs/ecmc-motion.stlib)
- [`../ecmc_plugin_strucpp/templates/mc_move_absolute_template.st`](../ecmc_plugin_strucpp/templates/mc_move_absolute_template.st)
- [`../ecmc_plugin_strucpp/templates/motion_logic_wrapper_template.cpp`](../ecmc_plugin_strucpp/templates/motion_logic_wrapper_template.cpp)

By default this sample app consumes `$(ECMC_PLUGIN_STRUCPP)/libs` as its motion
library path. If you keep the default sibling-repo layout, no extra setup is
needed beyond building `ecmc_plugin_strucpp`.

## Regeneration

To regenerate the checked-in generated files:

```sh
make regen
```

or with Podman:

```sh
make regen-container
```

`regen-container` now builds `strucpp` once and regenerates all sample programs
in one container run.

For IOC use, point `LOGIC_LIB` at `build/mc_power_move_absolute_lib_logic.*`
and use the same contiguous input/output image sizes as the handwritten motion
sample.

## Quick Start

For a new motion app:

1. Copy [`../ecmc_plugin_strucpp/templates/mc_move_absolute_template.st`](../ecmc_plugin_strucpp/templates/mc_move_absolute_template.st) into `st/`.
2. Copy [`../ecmc_plugin_strucpp/templates/motion_logic_wrapper_template.cpp`](../ecmc_plugin_strucpp/templates/motion_logic_wrapper_template.cpp) into `src/`.
3. Rename the program/wrapper identifiers and set `axis.AxisIndex`.
4. Regenerate with `make regen-container`.
5. Build with `make all`.

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
