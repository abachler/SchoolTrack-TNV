  //  //$date:=DT_GetDateFromDayMonthYear (Num(Substring(Self->;1;2));Num(Substring(Self->;3;2));Num(Substring(Self->;5)))
  //$date:=Date(Self->)
  //$StringFecha:=String($date)
  //$FechaFecha:=Date(DT_StrDateIsOK ($StringFecha))
  //If ($FechaFecha=!00/00/00!)
  //Self->:=""
  //GOTO OBJECT(Self->)
  //Else 
  //Self->:=$StringFecha
  //End if 
  //vdACT_FechaDocumento:=$FechaFecha
  //Case of 
  //: (Form event=On Losing Focus)
  //vbSpell_StopChecking:=True
  //End case 