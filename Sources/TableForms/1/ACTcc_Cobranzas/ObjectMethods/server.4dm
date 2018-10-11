IT_SetButtonStateObject ((Self:C308->=1);->bc_SetProgTask)
IT_SetButtonStateObject (((Self:C308->=1) & (bc_SetProgTask=1));->bCalendar1;->bUpHrs;->bDownHrs;->bUpMinutes;->bDownMinutes)

OBJECT SET ENTERABLE:C238(vHrs;((Self:C308->=1) & (bc_SetProgTask=1)))
OBJECT SET ENTERABLE:C238(vMinutes;((Self:C308->=1) & (bc_SetProgTask=1)))
OBJECT SET ENTERABLE:C238(vt_Fecha;((Self:C308->=1) & (bc_SetProgTask=1)))
If (Self:C308->=0)
	bc_SetProgTask:=0
End if 