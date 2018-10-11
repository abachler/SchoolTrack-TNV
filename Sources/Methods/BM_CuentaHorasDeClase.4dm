//%attributes = {}
  //BM_CuentaHorasDeClase

  //DECLARATIONS
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_TEXT:C284($error)
C_BOOLEAN:C305($0;$succes)
C_DATE:C307($d_inicioSemana;$d_finSemana)

  //INITIALIZATION
$batchRecNum:=$1

  //MAIN CODE

MESSAGES OFF:C175
$success:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	$id:=Num:C11([xShell_BatchRequests:48]Msg:2)
	READ WRITE:C146([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id)
	If (Records in selection:C76([Asignaturas:18])=1)
		If (Not:C34(Locked:C147([Asignaturas:18])))
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
			READ ONLY:C145([Asignaturas_RegistroSesiones:168])
			READ ONLY:C145([TMT_Horario:166])
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$id;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Año:13=<>gyear)
			$oldHorasEfectivas:=[Asignaturas:18]Horas_de_clases_efectivas:52
			[Asignaturas:18]Horas_de_clases_efectivas:52:=$records
			$horasEfectivas:=$records
			If (vlSTR_Horario_NoCiclos=1)
				  // Modificado por: Saúl Ponce (19/05/2017) Ticket Nº 180337, contabiliar horas de clase vigentes
				  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=$id)
				  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero;*)
				  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=Current date(*);*)
				  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesDesde<=Current date(*))
				
				  //20180219 ASM Ticket 198673, valido según periodo configurado.
				  //PERIODOS_LoadData ([Asignaturas]Numero_del_Nivel)
				  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero;*)
				  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=adSTR_Periodos_Desde{1};*)
				  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesDesde<=adSTR_Periodos_Hasta{Size of array(adSTR_Periodos_Hasta)})
				
				  // Modificado por: Saúl Ponce (12/03/2018) valido con el nuevo método creado por Alberto B. 
				DT_GetStartEndWeekDates (Current date:C33(*);->$d_inicioSemana;->$d_finSemana)
				QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_inicioSemana;*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=$d_finSemana)
				[Asignaturas:18]Horas_Semanales:51:=$records
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SAVE RECORD:C53([Asignaturas:18])
			UNLOAD RECORD:C212([Asignaturas:18])
			READ ONLY:C145([Asignaturas:18])
			$success:=True:C214
			
			If ([Asignaturas:18]Incide_en_Asistencia:45)
				  //creo una tarea batch para recontabilizar las horas de clase y horas de inasistencia en los registros de síntesis de alumnos
				EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				
				READ ONLY:C145([Alumnos:2])
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIds_Alumnos)
				For ($i_Alumnos;1;Size of array:C274($aIds_Alumnos))
					$ignore:=BM_CreateRequest ("Totaliza Horas Inasistencia";String:C10($aIds_Alumnos{$i_Alumnos}))
				End for 
			End if 
			
		End if 
	Else 
		$success:=True:C214
	End if 
End if 


$0:=$success
KRL_UnloadAll 