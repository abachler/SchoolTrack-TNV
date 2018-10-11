//%attributes = {}
  // UD_v20130529_ProfesorEnSesiones()
  // Por: Alberto Bachler: 29/05/13, 18:05:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_IdProceso;$i)

ARRAY LONGINT:C221($al_RecNums;0)

<>vb_ImportHistoricos_STX:=True:C214
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=0;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; | ;[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11="";*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; | ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=0)

If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
	$l_IdProceso:=IT_Progress (1;0;0;"Normalizando registros de sesiones de clases...")
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
	For ($i;1;Size of array:C274($al_RecNums))
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i})
		[Asignaturas_RegistroSesiones:168]NumeroDia:15:=DT_GetDayNumber_ISO8601 ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
		If ([Asignaturas_RegistroSesiones:168]Año:13=<>gyear)
			[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]profesor_numero:4)
			[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]profesor_nombre:13)
		Else 
			[Asignaturas_RegistroSesiones:168]ID_Asignatura:2:=-Abs:C99([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=KRL_GetNumericFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Asignaturas_RegistroSesiones:168]ID_HistoricoAsignatura:14;->[Asignaturas_Historico:84]Profesor_Numero:12)
			[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=KRL_GetTextFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Asignaturas_RegistroSesiones:168]ID_HistoricoAsignatura:14;->[Asignaturas_Historico:84]Profesor_Nombre:13)
		End if 
		SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
		$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274($al_RecNums);"Normalizando registros de sesiones de clases...")
	End for 
	KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
	$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
	
End if 


<>vb_ImportHistoricos_STX:=False:C215

