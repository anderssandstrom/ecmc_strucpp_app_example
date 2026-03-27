PROGRAM EL7041_VELOCITY
VAR
  actual_position    AT %IW0 : INT;
  drive_control      AT %QW0 : WORD;
  velocity_setpoint  AT %QW2 : INT;
END_VAR

drive_control := 16#0001;
velocity_setpoint := 1000;
END_PROGRAM
