# `ioc_project_minimal`

This is the smallest practical IOC-project example for `ecmc_plugin_strucpp`.

It is meant to show the default workflow only:

- one ST source file
- one short `src/Makefile`
- no handwritten C++ files
- startup only passes `LOGIC_LIB`
- direct EtherCAT item mapping, not memmaps

The source tree is:

- [`src/machine.st`](src/machine.st)
- [`src/Makefile`](src/Makefile)

The expected flow is:

1. `make`
2. `ioc install --source .`
3. IOC startup loads:
   - `bin/machine_logic.so`
   - `bin/machine_logic.so.map`
   - `bin/machine_logic.so.substitutions`

Because the helper stages the map and substitutions next to the logic library,
the startup script can stay minimal:

```iocsh
epicsEnvSet(STRUCPP_LOGIC_LIB,"bin/machine_logic.so")
require ecmc_plugin_strucpp sandst_a "PLUGIN_ID=0,LOGIC_LIB=${STRUCPP_LOGIC_LIB},REPORT=1"
```

This example uses `// @ecmc ...` annotations in the ST source, so the plugin
defaults to `${LOGIC_LIB}.map` and does not need `INPUT_ITEM`,
`OUTPUT_ITEM`, or `MAPPING_FILE` macros in the normal case.

The concrete sample maps directly to EL7041 PDO items:

- `%IW0` -> `ec0.s14.positionActual01`
- `%QW0` -> `ec0.s14.driveControl01`
- `%QW2` -> `ec0.s14.velocitySetpoint01`

So this example is deliberately showing the direct EtherCAT-data path rather
than the older contiguous memmap path.
