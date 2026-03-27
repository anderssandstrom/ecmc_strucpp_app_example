PROGRAM MOTION_ACTPOS_MIRROR
VAR
  source_actpos   AT %IL0 : LREAL;  // @ecmc ax1.enc.actpos
  target_position AT %QL0 : LREAL;  // @ecmc ax1.traj.targetpos
END_VAR

target_position := source_actpos;
END_PROGRAM
