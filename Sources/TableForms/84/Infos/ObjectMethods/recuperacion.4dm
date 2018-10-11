If (Self:C308->=True:C214)
	[Alumnos_ComplementoEvaluacion:209]Historico_FechaAprobacionDif:49:=!00-00-00!
	[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50:=""
	[Alumnos_ComplementoEvaluacion:209]Historico_CondicionAprobacion:51:=""
Else 
	[Alumnos_ComplementoEvaluacion:209]Historico_FechaAprobacionDif:49:=Current date:C33(*)
	[Alumnos_ComplementoEvaluacion:209]Historico_ColegioAprobacion:50:=ST_Boolean2Str ((<>vtXS_CountryCode="ar");"EN ESTE ESTABLECIMIENTO";<>gCustom)
	[Alumnos_ComplementoEvaluacion:209]Historico_CondicionAprobacion:51:="REGULAR"
End if 
REDRAW WINDOW:C456
REDRAW:C174([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88)
[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+": "+String:C10(Num:C11(Old:C35(Self:C308->)))+" -> "+String:C10(Num:C11(Self:C308->))+"\r"+[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88
LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+", del registro histórico del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")