C_TEXT:C284($vt_value)
C_LONGINT:C283($Ascii)
$Ascii:=Character code:C91(Keystroke:C390)
$vt_value:=Self:C308->
IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40)
If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34))
	If (Self:C308->="")
		Self:C308->:=$vt_value
	Else 
		If (Form event:C388=On Losing Focus:K2:8)
			QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=vt_nombre+"@")
			ACTter_ProcesaBusquedaCtas 
		End if 
	End if 
Else 
	If (Form event:C388=On Losing Focus:K2:8)
		QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=vt_nombre+"@")
		ACTter_ProcesaBusquedaCtas 
	End if 
End if 