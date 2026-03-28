# `ioc_project_minimal`

This is the smallest practical IOC-project example for `ecmc_plugin_strucpp`.

It is meant to show the default workflow only:

- one ST source file
- one short `src/Makefile`
- no handwritten C++ files
- startup only calls `require`
- direct EtherCAT item mapping, not memmaps

The source tree is:

- [`src/main.st`](src/main.st)
- [`src/Makefile`](src/Makefile)

The expected flow is:

1. `make`
2. `ioc install --source .`
3. IOC startup loads:
   - `bin/main.so`
   - `bin/main.so.map`
   - `bin/main.so.substitutions`

Because the helper stages the map and substitutions next to the logic library,
the startup script can stay minimal:

```iocsh
require ecmccfg
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=14,HW_DESC=EL7041-0052"
require ecmc_plugin_strucpp sandst_a "REPORT=1"
```

This example uses `// @ecmc ...` annotations in the ST source, so the plugin
defaults to `bin/main.so.map` and does not need `INPUT_ITEM`,
`OUTPUT_ITEM`, or `MAPPING_FILE` macros in the normal case.

The concrete sample maps directly to EL7041 PDO items:

- `%IW0` -> `ec0.s14.positionActual01`
- `%QW0` -> `ec0.s14.driveControl01`
- `%QW2` -> `ec0.s14.velocitySetpoint01`

So this example is deliberately showing the direct EtherCAT-data path rather
than the older contiguous memmap path.
