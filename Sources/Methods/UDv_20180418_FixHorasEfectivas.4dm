//%attributes = {}
  //UDv_20180418_FixHorasEfectivas

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
C_LONGINT:C283($l_records;$i;$l_idTermometro)
ARRAY LONGINT:C221($al_recnum;0)

$l_idTermometro:=IT_Progress (1;0;0;"Revisando horas efectivas...")

ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnum;"")

For ($i;1;Size of array:C274($al_recnum))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_recnum{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum))
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Año:13=<>gyear)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($l_records#[Asignaturas:18]Horas_de_clases_efectivas:52)
		[Asignaturas:18]Horas_de_clases_efectivas:52:=$l_records
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	KRL_UnloadReadOnly (->[Asignaturas:18])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)