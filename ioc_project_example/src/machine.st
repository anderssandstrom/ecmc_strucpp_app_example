PROGRAM MACHINE
VAR
  actual_position    AT %IW0 : INT;   // @ecmc ec0.s14.positionActual01
  drive_control      AT %QW0 : WORD;  // @ecmc ec0.s14.driveControl01
  velocity_setpoint  AT %QW2 : INT;   // @ecmc ec0.s14.velocitySetpoint01
  cycle_counter      AT %MW0 : INT;   // @epics plugin.strucpp.machine.cycle_counter
  manual_velocity             : INT;   // @epics plugin.strucpp.machine.manual_velocity rw
  actual_pos_export           : INT;   // @epics plugin.strucpp.machine.actual_position
  counter_fb                  : COUNTER_FB;
END_VAR

actual_pos_export := actual_position;
drive_control := 16#0001;
counter_fb(Enable := TRUE);
cycle_counter := counter_fb.Value;

IF manual_velocity <> 0 THEN
  velocity_setpoint := manual_velocity;
ELSIF actual_position < 1000 THEN
  velocity_setpoint := 1000;
ELSE
  velocity_setpoint := -1000;
END_IF;
END_PROGRAM
