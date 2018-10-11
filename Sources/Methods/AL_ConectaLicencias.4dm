//%attributes = {}
  //AL_ConectaLicencias

C_LONGINT:C283($idAlumno)
$idAlumno:=$1

READ WRITE:C146([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos_Licencias:73])

QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno;*)
QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10];$aRecNums)

QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$idAlumno)  //con esto se buscan las licencias del periodo
QUERY SELECTION:C341([Alumnos_Licencias:73];[Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{1};*)
QUERY SELECTION:C341([Alumnos_Licencias:73]; | [Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{2})
SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$desde;[Alumnos_Licencias:73]Hasta:3;$hasta;[Alumnos_Licencias:73]ID:6;$lic;[Alumnos_Licencias:73]Tipo_licencia:4;$aTipoLicencia)

For ($i;1;Size of array:C274($aRecNums))
	KRL_GotoRecord (->[Alumnos_Inasistencias:10];$aRecNums{$i})
	[Alumnos_Inasistencias:10]Justificación:2:=""
	[Alumnos_Inasistencias:10]Licencia:5:=0
	For ($j;1;Size of array:C274($desde))
		If (([Alumnos_Inasistencias:10]Fecha:1>=$desde{$j}) & ([Alumnos_Inasistencias:10]Fecha:1<=$hasta{$j}))
			[Alumnos_Inasistencias:10]Licencia:5:=$lic{$j}
			[Alumnos_Inasistencias:10]Justificación:2:=$aTipoLicencia{$j}+" Nº "+String:C10($lic{$j})
			$j:=Size of array:C274($desde)
		End if 
	End for 
	SAVE RECORD:C53([Alumnos_Inasistencias:10])
End for 
UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos_Inasistencias:10])
