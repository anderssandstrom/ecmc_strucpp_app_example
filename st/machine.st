PROGRAM MACHINE
VAR
  start_button   AT %IX0.0 : BOOL;
  stop_button    AT %IX0.1 : BOOL;
  enable_output  AT %QX0.0 : BOOL;
  target_word    AT %QW2   : INT;
  counter        AT %MW0   : INT;
END_VAR

IF stop_button THEN
  enable_output := FALSE;
ELSIF start_button THEN
  enable_output := TRUE;
END_IF;

IF enable_output THEN
  counter := counter + 1;
  target_word := counter;
ELSE
  target_word := 0;
END_IF;
END_PROGRAM
