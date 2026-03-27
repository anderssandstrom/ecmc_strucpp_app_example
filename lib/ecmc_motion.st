TYPE ECMC_AXIS_REF :
STRUCT
  AxisIndex : DINT;
END_STRUCT
END_TYPE

FUNCTION_BLOCK MC_Power
VAR_INPUT
  Axis   : ECMC_AXIS_REF;
  Enable : BOOL;
END_VAR
VAR_OUTPUT
  Status  : BOOL;
  Valid   : BOOL;
  Busy    : BOOL;
  Error   : BOOL;
  ErrorID : UDINT;
  Active  : BOOL;
END_VAR
VAR
  StatePtr : ULINT;
END_VAR
{external
  auto *handle = reinterpret_cast<ecmcMcPowerHandle *>(static_cast<uintptr_t>(STATEPTR.get()));
  if (!handle) {
    handle = ecmcMcPowerCreate();
    STATEPTR.set(static_cast<ULINT_t>(reinterpret_cast<uintptr_t>(handle)));
  }

  if (!handle) {
    STATUS.set(false);
    VALID.set(false);
    BUSY.set(false);
    ERROR.set(true);
    ERRORID.set(static_cast<UDINT_t>(0xffffffffu));
    ACTIVE.set(false);
  } else {
    ecmcMcPowerStatus fb_status{};
    ecmcMcPowerRun(handle, AXIS.AXISINDEX.get(), ENABLE.get() ? 1 : 0, &fb_status);
    STATUS.set(fb_status.Status != 0);
    VALID.set(fb_status.Valid != 0);
    BUSY.set(fb_status.base.Busy != 0);
    ERROR.set(fb_status.base.Error != 0);
    ERRORID.set(static_cast<UDINT_t>(fb_status.base.ErrorID));
    ACTIVE.set(fb_status.base.Active != 0);
  }
}
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_MoveAbsolute
VAR_INPUT
  Axis         : ECMC_AXIS_REF;
  Execute      : BOOL;
  Position     : LREAL;
  Velocity     : LREAL;
  Acceleration : LREAL;
  Deceleration : LREAL;
END_VAR
VAR_OUTPUT
  Done            : BOOL;
  Busy            : BOOL;
  Active          : BOOL;
  CommandAborted  : BOOL;
  Error           : BOOL;
  ErrorID         : UDINT;
END_VAR
VAR
  StatePtr : ULINT;
END_VAR
{external
  auto *handle = reinterpret_cast<ecmcMcMoveAbsoluteHandle *>(static_cast<uintptr_t>(STATEPTR.get()));
  if (!handle) {
    handle = ecmcMcMoveAbsoluteCreate();
    STATEPTR.set(static_cast<ULINT_t>(reinterpret_cast<uintptr_t>(handle)));
  }

  if (!handle) {
    DONE.set(false);
    BUSY.set(false);
    ACTIVE.set(false);
    COMMANDABORTED.set(false);
    ERROR.set(true);
    ERRORID.set(static_cast<UDINT_t>(0xffffffffu));
  } else {
    ecmcMcMoveAbsoluteStatus fb_status{};
    ecmcMcMoveAbsoluteRun(handle,
                          AXIS.AXISINDEX.get(),
                          EXECUTE.get() ? 1 : 0,
                          POSITION.get(),
                          VELOCITY.get(),
                          ACCELERATION.get(),
                          DECELERATION.get(),
                          &fb_status);
    DONE.set(fb_status.base.Done != 0);
    BUSY.set(fb_status.base.Busy != 0);
    ACTIVE.set(fb_status.base.Active != 0);
    COMMANDABORTED.set(fb_status.base.CommandAborted != 0);
    ERROR.set(fb_status.base.Error != 0);
    ERRORID.set(static_cast<UDINT_t>(fb_status.base.ErrorID));
  }
}
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_ReadActualPosition
VAR_INPUT
  Axis   : ECMC_AXIS_REF;
  Enable : BOOL;
END_VAR
VAR_OUTPUT
  Valid    : BOOL;
  Busy     : BOOL;
  Error    : BOOL;
  ErrorID  : UDINT;
  Position : LREAL;
END_VAR
VAR
  StatePtr : ULINT;
END_VAR
{external
  auto *handle = reinterpret_cast<ecmcMcReadActualPositionHandle *>(static_cast<uintptr_t>(STATEPTR.get()));
  if (!handle) {
    handle = ecmcMcReadActualPositionCreate();
    STATEPTR.set(static_cast<ULINT_t>(reinterpret_cast<uintptr_t>(handle)));
  }

  if (!handle) {
    VALID.set(false);
    BUSY.set(false);
    ERROR.set(true);
    ERRORID.set(static_cast<UDINT_t>(0xffffffffu));
    POSITION.set(0.0);
  } else {
    ecmcMcReadActualPositionStatus fb_status{};
    ecmcMcReadActualPositionRun(handle, AXIS.AXISINDEX.get(), ENABLE.get() ? 1 : 0, &fb_status);
    VALID.set(fb_status.Valid != 0);
    BUSY.set(fb_status.base.Busy != 0);
    ERROR.set(fb_status.base.Error != 0);
    ERRORID.set(static_cast<UDINT_t>(fb_status.base.ErrorID));
    POSITION.set(fb_status.Position);
  }
}
END_FUNCTION_BLOCK
