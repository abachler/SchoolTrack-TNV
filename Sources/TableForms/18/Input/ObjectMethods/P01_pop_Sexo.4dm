C_LONGINT:C283($r)
If (<>aSexSel>0)
	If (Size of array:C274(aNtaStdNme)>0)
		$r:=CD_Dlog (1;__ ("Ya hay alumnos inscritos en esta asignatura.\rNo se puede modificar esta característica."))
	Else 
		[Asignaturas:18]Seleccion_por_sexo:24:=<>aSexSel
		sSex:=<>aSexSel{<>aSexSel}
	End if 
End if 