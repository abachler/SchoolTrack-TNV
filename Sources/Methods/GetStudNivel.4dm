//%attributes = {}
  //GetStudNivel

If ([Alumnos:2]curso:20="POST")
	[Alumnos:2]nivel_numero:29:=Nivel_AdmissionTrack
	[Alumnos:2]Nivel_Nombre:34:="AdmissionTrack"
Else 
	$el:=Find in array:C230(<>aCursos;[Alumnos:2]curso:20)
	If ($el>0)
		[Alumnos:2]nivel_numero:29:=<>aCUNivNo{$el}
		[Alumnos:2]Nivel_Nombre:34:=<>aCUNivNme{$el}
		[Alumnos:2]Sección:26:=<>aCUSection{$el}
	Else 
		[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
		[Alumnos:2]Nivel_Nombre:34:="Admisión"
	End if 
End if 