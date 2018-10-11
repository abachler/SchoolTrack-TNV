//%attributes = {"executedOnServer":true}
  //AS_creaRegistrosAluEvaEspecial
  //MONO

C_LONGINT:C283($n;$l_recNumEvalEspecial;$l_idTermometro)
C_TEXT:C284($llaveAsig;$1)
$llaveAsig:=$1
ARRAY LONGINT:C221($al_rn;0)

READ ONLY:C145([Alumnos_Calificaciones:208])
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Asignatura:494=$llaveAsig)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_rn;"")

For ($n;1;Size of array:C274($al_rn))
	
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_rn{$n})
	$l_recNumEvalEspecial:=KRL_FindAndLoadRecordByIndex (->[Alumnos_EvaluacionesEspeciales:211]Llave_principal:8;->[Alumnos_Calificaciones:208]Llave_principal:1)
	If ($l_recNumEvalEspecial<0)
		READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
		CREATE RECORD:C68([Alumnos_EvaluacionesEspeciales:211])
		[Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2:=[Alumnos_Calificaciones:208]ID_institucion:2
		[Alumnos_EvaluacionesEspeciales:211]Año:3:=[Alumnos_Calificaciones:208]Año:3
		[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4:=[Alumnos_Calificaciones:208]ID_Alumno:6
		[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
		[Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6:=[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493
		[Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7:=[Alumnos_Calificaciones:208]NIvel_Numero:4
		SAVE RECORD:C53([Alumnos_EvaluacionesEspeciales:211])
		KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionesEspeciales:211])
	End if 
End for 
