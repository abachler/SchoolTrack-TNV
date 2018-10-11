  //  //$date:=DT_GetDateFromDayMonthYear (Num(Substring(Self->;1;2));Num(Substring(Self->;3;2));Num(Substring(Self->;5)))
  //$date:=Date(Self->)
  //$StringFecha:=String($date)
  //$FechaFecha:=Date(DT_StrDateIsOK ($StringFecha))
  //If (($FechaFecha=!00/00/00!) | (vdACT_LFechaVencimiento<$FechaFecha))
  //Self->:=""
  //GOTO OBJECT(Self->)
  //Else 
  //Self->:=$StringFecha
  //vdACT_LFechaEmision:=$FechaFecha
  //End if 
  //If (vdACT_LFechaVencimiento<vdACT_LFechaEmision)
  //Self->:=dt_GetNullDateString 
  //vdACT_LFechaEmision:=!00/00/00!
  //End if 
  //Case of 
  //: (Form event=On Losing Focus)
  //vbSpell_StopChecking:=True
  //End case 