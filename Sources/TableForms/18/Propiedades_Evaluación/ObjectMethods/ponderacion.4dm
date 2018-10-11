AL_ExitCell (xALP_CsdList2)

vi_PonderacionTruncada:=bc_PonderacionTruncada
vbRecalcPromedios:=True:C214
  // Ticket 175179
  //APPEND TO ARRAY(atSTR_EventLog;"Cálculo de resultado con "+String(Self->)+"\" decimales; "+("con troncatura"*vi_PonderacionTruncada)+("con aproximación"*Num(vi_PonderacionTruncada=0)))