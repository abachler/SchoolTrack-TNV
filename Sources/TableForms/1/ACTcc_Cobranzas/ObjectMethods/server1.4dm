OBJECT SET ENTERABLE:C238(vHrs;(Self:C308->=1))
OBJECT SET ENTERABLE:C238(vMinutes;(Self:C308->=1))
OBJECT SET ENTERABLE:C238(vt_Fecha;(Self:C308->=1))

If (Self:C308->=1)
	vHrs:=TM_Get_Hours (Current time:C178(*))
	vMinutes:=TM_Get_Minutes (Current time:C178(*))
	vt_Fecha:=String:C10(Current date:C33(*);7)
	vdDate:=Current date:C33(*)
	OBJECT SET TITLE:C194(bEmitir;__ ("Programar"))
Else 
	OBJECT SET TITLE:C194(bEmitir;__ ("Emitir avisos"))
End if 

IT_SetButtonState ((Self:C308->=1);->bCalendar1;->bUpHrs;->bDownHrs;->bUpMinutes;->bDownMinutes)