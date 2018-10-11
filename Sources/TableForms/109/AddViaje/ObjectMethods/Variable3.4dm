dFrom:=DT_PopCalendar 
If (dFrom>Current date:C33(*))
	ok:=CD_Dlog (1;__ ("No puede ingresar un viaje en una fecha posterior a la actual  \r debe ingresar otra fecha");__ ("");__ ("OK"))
	dFrom:=!00-00-00!
End if 
SET WINDOW TITLE:C213(String:C10(dFrom;3))