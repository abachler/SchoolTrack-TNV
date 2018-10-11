If (Form event:C388=On Load:K2:1)
	
	$err:=PL_SetArraysNam (xPL_Asist;1;5;"aAbsNames";"aInt1";"aReel1";"aReel2";"aEmptyText")
	PL_SetWidths (xPL_Asist;1;5;150;80;80;70;170)
	PL_SetHdrOpts (xPL_Asist;2)
	PL_SetHeight (xPL_Asist;1;1;0;0)
	PL_SetHdrStyle (xPL_Asist;0;"Tahoma";9;1)
	PL_SetStyle (xPL_Asist;0;"Tahoma";9;0)
	PL_SetFormat (xPL_Asist;1;"";1;2)
	$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
	
	Case of 
		: (($modoRegistroAsistencia=1) | ($modoRegistroAsistencia=3))
			PL_SetHeaders (xPL_Asist;1;5;"Alumno";"Inasist.";"% a la fecha";"% / días año";"Observaciones")
			PL_SetFormat (xPL_Asist;2;"### ###";2;2)
			PL_SetFormat (xPL_Asist;3;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
			PL_SetFormat (xPL_Asist;4;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
		: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
			PL_SetHeaders (xPL_Asist;1;5;"Alumno";"Horas reales";"Horas Ausencia";"% asistencia.";"Observaciones")
			PL_SetFormat (xPL_Asist;2;"### ###";2;2)
			PL_SetFormat (xPL_Asist;3;"### ###";2;2)
			PL_SetFormat (xPL_Asist;4;"##0"+<>tXS_RS_DecimalSeparator+"0";2;2)
	End case 
	
	PL_SetDividers (xPL_Asist;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Asist;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Asist;1)
End if 
