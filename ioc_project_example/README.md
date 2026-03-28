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
