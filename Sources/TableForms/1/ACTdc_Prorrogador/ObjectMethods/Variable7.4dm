$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(Self:C308->;1;2));Num:C11(Substring:C12(Self:C308->;3;2));Num:C11(Substring:C12(Self:C308->;5)))
$StringFecha:=String:C10($date)
$FechaFecha:=Date:C102(DT_StrDateIsOK ($StringFecha))
If ($FechaFecha=!00-00-00!)
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
Else 
	Self:C308->:=$StringFecha
	vdACT_FechaProrroga:=$FechaFecha
End if 
If (vdACT_FechaProrroga>=vdACT_FechaCheque)
	vDias:=vdACT_FechaProrroga-vdACT_FechaCheque
Else 
	BEEP:C151
	vdACT_FechaProrroga:=vdACT_FechaCheque
	Self:C308->:=String:C10(vdACT_FechaProrroga;7)
	vDias:=vdACT_FechaProrroga-vdACT_FechaCheque
	GOTO OBJECT:C206(Self:C308->)
End if 