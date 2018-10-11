//%attributes = {}
  //ACTpp_RetornaNoCargasTotal

  //RCH 20080905 Cuando no se tiene considerado los niveles adm en la contabilización de cargas el apoderado podría quedar con el campo Es apoderado de cuenta en falso cuando efectivamente tiene un alumno en ADM. Además esto afectaba en el total de apoderados de cuenta...

C_LONGINT:C283($vl_idApoderado;$1;$0;$vl_NoAlumnos;$vl_NoAlumnosTotal)

$vl_idApoderado:=$1
If (Size of array:C274(<>al_NumeroNivelesActivos)>0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_NoAlumnos)
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=$vl_idApoderado;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelesActivos{1};*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)})
	$vl_NoAlumnosTotal:=$vl_NoAlumnosTotal+$vl_NoAlumnos
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=$vl_idApoderado;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta*1)
	$vl_NoAlumnosTotal:=$vl_NoAlumnosTotal+$vl_NoAlumnos
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=$vl_idApoderado;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29;=;Nivel_AdmissionTrack*1)
	$vl_NoAlumnosTotal:=$vl_NoAlumnosTotal+$vl_NoAlumnos
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
$0:=$vl_NoAlumnosTotal