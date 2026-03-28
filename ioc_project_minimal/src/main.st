PROGRAM MAIN
VAR
  actual_position    AT %IW0 : INT;   // @ecmc ec0.s14.positionActual01
  drive_control      AT %QW0 : WORD;  // @ecmc ec0.s14.driveControl01
  velocity_setpoint  AT %QW2 : INT;   // @ecmc ec0.s14.velocitySetpoint01
  cycle_counter      AT %MW0 : INT;   // @epics plugin.strucpp.main.cycle_counter
  actual_pos_export           : INT;   // @epics plugin.strucpp.main.actual_position
END_VAR

actual_pos_export := actual_position;
cycle_counter := cycle_counter + 1;
drive_control := 16#0001;

IF actual_position < 1000 THEN
  velocity_setpoint := 1000;
ELSE
  velocity_setpoint := -1000;
END_IF;
END_PROGRAM
