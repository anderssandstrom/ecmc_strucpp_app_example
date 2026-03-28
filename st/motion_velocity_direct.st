PROGRAM MOTION_VELOCITY_DIRECT
VAR
  actual_position  AT %IL0   : LREAL;  // @ecmc ax1.enc.actpos
  target_velocity  AT %QL0   : LREAL;  // @ecmc ax1.traj.targetvel
  drive_enable     AT %QX8.0 : BOOL;   // @ecmc ax1.drv.enable
END_VAR

drive_enable := TRUE;

IF actual_position < 1000.0 THEN
  target_velocity := 10.0;
ELSE
  target_velocity := -10.0;
END_IF;
END_PROGRAM
