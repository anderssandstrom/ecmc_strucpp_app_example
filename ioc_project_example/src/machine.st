PROGRAM MACHINE
VAR
  start_button   AT %IX0.0 : BOOL;  // @ecmc ec0.s2.mm.inputDataArray01
  stop_button    AT %IX0.1 : BOOL;  // @ecmc ec0.s2.mm.inputDataArray01
  enable_output  AT %QX0.0 : BOOL;  // @ecmc ec0.s2.mm.outputDataArray01
  target_word    AT %QW2   : INT;   // @ecmc ec0.s2.mm.outputDataArray01
  counter        AT %MW0   : INT;   // @epics plugin.strucpp.machine.counter
  manual_target            : INT;   // @epics plugin.strucpp.machine.manual_target rw
  counter_fb               : COUNTER_FB;
END_VAR

IF stop_button THEN
  enable_output := FALSE;
ELSIF start_button THEN
  enable_output := TRUE;
END_IF;

counter_fb(Enable := enable_output);
counter := counter_fb.Value;

IF enable_output THEN
  IF manual_target <> 0 THEN
    target_word := manual_target;
  ELSE
    target_word := counter;
  END_IF;
ELSE
  target_word := 0;
END_IF;
END_PROGRAM
