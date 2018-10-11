[BU_Buses_Mantencion:32]Fecha:3:=DT_PopCalendar 
If ([BU_Buses_Mantencion:32]Fecha:3>Current date:C33(*))
	ok:=CD_Dlog (1;__ ("No puede ingresar una fecha posterior a la actual  \r debe ingresar otra fecha");__ ("");__ ("OK"))
	[BU_Buses_Mantencion:32]Fecha:3:=!00-00-00!
End if 

