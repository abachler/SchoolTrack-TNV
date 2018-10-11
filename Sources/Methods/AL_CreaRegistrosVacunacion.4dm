//%attributes = {}
  //AL_CreaRegistrosVacunacion

$id_alumno:=$1
For ($k;1;Size of array:C274(<>alSTK_MesesVacunacion))
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=$id_alumno;*)
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Enfermedad:3=<>atSTK_Vacunas{$k};*)
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Meses:4=<>alSTK_MesesVacunacion{$k})
	If (Records in selection:C76([Alumnos_Vacunas:101])=0)
		CREATE RECORD:C68([Alumnos_Vacunas:101])
		[Alumnos_Vacunas:101]Numero_Alumno:1:=$id_alumno
		[Alumnos_Vacunas:101]Enfermedad:3:=<>atSTK_Vacunas{$k}
		[Alumnos_Vacunas:101]Meses:4:=<>alSTK_MesesVacunacion{$k}
		[Alumnos_Vacunas:101]Edad:2:=<>atSTK_Edades{$k}
		SAVE RECORD:C53([Alumnos_Vacunas:101])
	End if 
End for 
KRL_ReloadAsReadOnly (->[Alumnos_Vacunas:101])