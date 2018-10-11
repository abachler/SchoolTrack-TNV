//%attributes = {}
  //CAE_CreaHistoricoAsignaturas
  //REGISTRO DE CAMBIOS
  //20080303 RCH. Se almacenan 2 nuevos campos en el histórico de cada alumno. orden general y en informes internos.

EVS_LoadStyles 


C_LONGINT:C283($1;$2;$l_nivelAsignaturas)  //MONO 184433
C_BOOLEAN:C305($b_logCierreAño)  //MONO 184433

If (Count parameters:C259=2)
	vl_UltimoAño:=$1  //MONO 184433
	$l_nivelAsignaturas:=$2  //MONO 184433
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivelAsignaturas)  //MONO 184433
Else 
	ALL RECORDS:C47([Asignaturas:18])  //MONO 184433
	$b_logCierreAño:=True:C214  //MONO 184433
End if 

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
$n:=Size of array:C274($aRecNums)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando asignaturas de ")+String:C10(vl_UltimoAño))
SQ_RestauraSecuencias (->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
For ($i;1;$n)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$n)
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	$idAsignatura:=[Asignaturas:18]Numero:1
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	
	
	$key:=KRL_MakeStringAccesKey (-><>gInstitucion;->vl_UltimoAño;->$idAsignatura)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_Historico:84]LlavePrimaria:9;->$key)
	If ($recNum<0)
		CREATE RECORD:C68([Asignaturas_Historico:84])
		[Asignaturas_Historico:84]ID_RegistroHistorico:1:=SQ_SeqNumber (->[Asignaturas_Historico:84]ID_RegistroHistorico:1)
	Else 
		
	End if 
	[Asignaturas_Historico:84]Asignatura:2:=[Asignaturas:18]Asignatura:3
	[Asignaturas_Historico:84]Materia_UUID:45:=[Asignaturas:18]Materia_UUID:46  //Asignatura, Materia Auto uuid
	[Asignaturas_Historico:84]Nombre_interno:3:=[Asignaturas:18]denominacion_interna:16
	[Asignaturas_Historico:84]Nivel:4:=[Asignaturas:18]Numero_del_Nivel:6
	[Asignaturas_Historico:84]Nivel_Nombre:41:=[Asignaturas:18]Nivel:30
	[Asignaturas_Historico:84]Año:5:=vl_UltimoAño
	[Asignaturas_Historico:84]NombreAgnoEscolar:39:=vt_NombreUltimoAñoEscolar
	[Asignaturas_Historico:84]Promediable:6:=[Asignaturas:18]Incide_en_promedio:27
	[Asignaturas_Historico:84]Incluida_En_Actas:7:=[Asignaturas:18]Incluida_en_Actas:44
	[Asignaturas_Historico:84]Electiva:10:=[Asignaturas:18]Electiva:11
	[Asignaturas_Historico:84]Order:11:=[Asignaturas:18]posicion_en_informes_de_notas:36
	[Asignaturas_Historico:84]Profesor_Numero:12:=[Asignaturas:18]profesor_numero:4
	[Asignaturas_Historico:84]Curso:14:=[Asignaturas:18]Curso:5
	[Asignaturas_Historico:84]HorasAnuales:29:=[Asignaturas:18]Horas_Anuales:68
	[Asignaturas_Historico:84]Horas_Semanales:35:=[Asignaturas:18]Horas_Semanales:51
	[Asignaturas_Historico:84]Horas_Efectivas:36:=[Asignaturas:18]Horas_de_clases_efectivas:52
	[Asignaturas_Historico:84]Grupo_Estadistico:37:=[Asignaturas:18]GrupoEstadistico:89
	[Asignaturas_Historico:84]Optativa:24:=[Asignaturas:18]Es_Optativa:70
	[Asignaturas_Historico:84]ID_AsignaturaOriginal:30:=[Asignaturas:18]Numero:1
	[Asignaturas_Historico:84]Sector:38:=[Asignaturas:18]Sector:9
	[Asignaturas_Historico:84]OrdenGeneral:42:=[Asignaturas:18]ordenGeneral:105
	[Asignaturas_Historico:84]EnInformesInternos:43:=[Asignaturas:18]En_InformesInternos:14
	  //ABK - 2012.07.12 Nuevos campos en el histórico para almacenar información sobre el calculo de promedios generales
	  //                 Permite recalcular promedios históricos con todas las opciones existentes en el año actual   
	[Asignaturas_Historico:84]IncideEnPromedioInterno:27:=[Asignaturas:18]IncideEnPromedioInterno:64
	[Asignaturas_Historico:84]PonderacionPromedioINT:23:=[Asignaturas:18]PonderacionEnPromedioINT:110
	[Asignaturas_Historico:84]PonderacionEnPromedioOF:26:=[Asignaturas:18]PonderacionEnPromedioOF:109
	  //20121031 ASM Nuevo campo 
	[Asignaturas_Historico:84]Incide_en_Asistencia:28:=[Asignaturas:18]Incide_en_Asistencia:45
	READ ONLY:C145([xxSTR_HistoricoEstilosEval:88])
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[Asignaturas:18]Numero_de_EstiloEvaluacion:39;*)
	QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=vl_UltimoAño)
	[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
	RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
	[Asignaturas_Historico:84]Profesor_Nombre:13:=[Profesores:4]Apellidos_y_nombres:28
	SAVE RECORD:C53([Asignaturas_Historico:84])
	$idRegistroHistorico:=[Asignaturas_Historico:84]ID_RegistroHistorico:1
	
	$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_UltimoAño)+"."+String:C10($idAsignatura)
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56=$key)
	APPLY TO SELECTION:C70([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48:=$idRegistroHistorico)
	
	READ WRITE:C146([Alumnos_Calificaciones:208])
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Asignatura:494=$key)
	APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493:=$idRegistroHistorico)
	
	READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
	QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]Llave_asignatura:10=$key)
	APPLY TO SELECTION:C70([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6:=$idRegistroHistorico)
	
	READ WRITE:C146([Asignaturas_RegistroSesiones:168])
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$idAsignatura)
	APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_HistoricoAsignatura:14:=$idRegistroHistorico)
	KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
	
	READ WRITE:C146([Asignaturas_Inasistencias:125])
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=$idAsignatura)
	APPLY TO SELECTION:C70([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_HistoricoAsignatura:12:=$idRegistroHistorico)
	KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
	
	
End for 
If ($b_logCierreAño)  //MONO 184433
	LOG_RegisterEvt ("Cierre de año escolar: Archivaje de asignaturas para el año "+String:C10(vl_UltimoAño))
End if 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
FLUSH CACHE:C297

ALL RECORDS:C47([TMT_Horario:166])
KRL_DeleteSelection (->[TMT_Horario:166];True:C214;__ ("Eliminando Registros de Horario..."))
If ($b_logCierreAño)  //MONO 184433
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros de horario para el año "+String:C10(vl_UltimoAño))
End if 
FLUSH CACHE:C297

ALL RECORDS:C47([Asignaturas_Eventos:170])
KRL_DeleteSelection (->[Asignaturas_Eventos:170];True:C214;__ ("Eliminando Registros de Eventos en Asignaturas..."))
If ($b_logCierreAño)  //MONO 184433
	LOG_RegisterEvt ("Cierre de año escolar: Eliminacion de registros eventos de asignaturas para el añ"+"o "+String:C10(vl_UltimoAño))
End if 
FLUSH CACHE:C297
