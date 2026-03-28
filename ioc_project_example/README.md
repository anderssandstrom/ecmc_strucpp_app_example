# `ioc_project_example`

This directory is a best-guess example of how an IOC project could carry
`STruCpp` Structured Text when deployed with `gfa-iocutils`.

It is intentionally separate from the main sample app build in the repo. The
goal is to show one plausible IOC-project layout:

- top-level IOC project files for `gfa-iocutils`
- a `src/` subtree with one ST file and one short `Makefile`
- a top-level `bin/` staging directory containing the runtime artifacts that
  should end up in the installed IOC
- a startup script that loads `ecmc_plugin_strucpp` through `require`

This example is based on the current `gfa-iocutils` README, which says:

- `ioc install` handles deployment, not compilation
- source files can live in `/src`
- any compile/generation step must be handled by the project makefiles before
  `ioc install`

So the expected flow is:

1. `make`
2. `ioc install --source .`
3. IOC startup uses `require ecmc_plugin_strucpp ...`

The default naming conventions from `ecmc_plugin_strucpp` are used:

- `${LOGIC_LIB}.map`
- `${LOGIC_LIB}.substitutions`

So in mapping mode the startup script only needs `LOGIC_LIB` in the common
case.

One important detail from `gfa-iocutils`:

- compiled libraries are installed to the IOC `bin/` directory
- `.map` and `.substitutions` are not special file types in `ioc install`

So this example stages all runtime artifacts into the project-local `bin/`
directory before installation. The installed startup script can then point at
`bin/machine_logic.so` and the plugin will also find:

- `bin/machine_logic.so.map`
- `bin/machine_logic.so.substitutions`

To reduce boilerplate further, the example now uses the reusable helper from:

- [`../../ecmc_plugin_strucpp/templates/strucpp_ioc_logic.make`](../../ecmc_plugin_strucpp/templates/strucpp_ioc_logic.make)

So `src/Makefile` only sets:

```make
PROGRAM := machine
ST_SOURCES := machine_counter_fb.st machine.st
ECMC_PLUGIN_STRUCPP ?= ../../../ecmc_plugin_strucpp
include $(ECMC_PLUGIN_STRUCPP)/templates/strucpp_ioc_logic.make
```

The logic wrapper source is generated automatically from the bundled ST source.
This example also shows a split ST project:

- [`src/machine_counter_fb.st`](src/machine_counter_fb.st)
  reusable helper FB
- [`src/machine.st`](src/machine.st)
  final `PROGRAM`

The concrete sample now maps directly to EL7041 EtherCAT items:

- `%IW0` -> `ec0.s14.positionActual01`
- `%QW0` -> `ec0.s14.driveControl01`
- `%QW2` -> `ec0.s14.velocitySetpoint01`

So this richer IOC example also follows the preferred direct item-mapping
workflow rather than using memmaps.

If needed, the shared helper can also be extended with handwritten C++ by
setting:

- `WRAPPER_CPP := my_wrapper.cpp`
- `EXTRA_CPP_SOURCES := helper.cpp more_glue.cpp`

That is optional. The default path here intentionally stays fully generated,
but the `src/` directory also ships concrete opt-in examples:

- [`src/Makefile.with_cpp`](src/Makefile.with_cpp)
  alternate helper configuration using handwritten C++
- [`src/custom_logic_wrapper.cpp`](src/custom_logic_wrapper.cpp)
  manual wrapper that replaces the generated one
- [`src/machine_helper.cpp`](src/machine_helper.cpp)
  extra C++ translation unit linked into the same logic library

So if a project needs a small amount of direct C++ glue, the intended next
step is to copy `Makefile.with_cpp` over `src/Makefile` and adjust the helper
files as needed, rather than rewriting the whole build flow.
