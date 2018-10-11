//%attributes = {}
  // SRal_InformacionConductual()
  // Por: Alberto Bachler K.: 15-08-15, 15:56:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_idxPeriodo;$l_modoRegistroInasistencia)
C_TEXT:C284($t_llaveRegistro)

ARRAY LONGINT:C221($DA_Return;0)
If (False:C215)
	C_LONGINT:C283(SRal_InformacionConductual ;$1)
End if 

C_LONGINT:C283(vPeriodo)



If (Count parameters:C259=1)
	vPeriodo:=$1
End if 
If (vPeriodo<=0)
	vPeriodo:=viSTR_PeriodoActual_Numero
End if 

viSRal_InasistenciasPeriodo:=0
vrSRal_PctAsistenciaPeriodo:=0
viSRal_AtrasosPeriodo:=0
viSRal_AntNegativasPeriodo:=0
viSRal_AntPositivasPeriodo:=0
viSRal_CastigosPeriodo:=0
viSRal_SuspensionesPeriodo:=0
viSRal_InasistenciasTotal:=0
vrSRal_PctAsistenciaTotal:=0
viSRal_AtrasosTotal:=0
viSRal_AntNegativasTotal:=0
viSRal_AntPositivasTotal:=0
viSRal_CastigosTotal:=0
viSRal_SuspensionesTotal:=0
vtSRal_ComentariosPeriodo:=""
vtSRal_ComentariosFinal:=""
viSRal_HorasInasistPeriodo:=0
viSRal_HorasInasistPeriodoJ:=0
viSRal_HorasInasistTotal:=0
viSRal_HorasInasistTotalJ:=0



PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
$l_modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)


$l_idxPeriodo:=Find in array:C230(aiSTR_Periodos_Numero;vPeriodo)
viSRal_DiasPeriodo:=aiSTR_Periodos_Dias{$l_idxPeriodo}

$t_llaveRegistro:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveRegistro;False:C215)
Case of 
	: (vPeriodo=1)
		viSRal_InasistenciasPeriodo:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
		vrSRal_PctAsistenciaPeriodo:=[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100
		viSRal_AtrasosPeriodo:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107+[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
		viSRal_AntNegativasPeriodo:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
		viSRal_AntPositivasPeriodo:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
		viSRal_CastigosPeriodo:=[Alumnos_SintesisAnual:210]P01_Castigos:110
		viSRal_SuspensionesPeriodo:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111
		vtSRal_ComentariosPeriodo:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		viSRal_HorasPeriodo:=[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99
		viSRal_HorasInasistPeriodo:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
		
	: (vperiodo=2)
		viSRal_InasistenciasPeriodo:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
		vrSRal_PctAsistenciaPeriodo:=[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129
		viSRal_AtrasosPeriodo:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136+[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
		viSRal_AntNegativasPeriodo:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
		viSRal_AntPositivasPeriodo:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
		viSRal_CastigosPeriodo:=[Alumnos_SintesisAnual:210]P02_Castigos:139
		viSRal_SuspensionesPeriodo:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140
		vtSRal_ComentariosPeriodo:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
		viSRal_HorasPeriodo:=[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128
		viSRal_HorasInasistPeriodo:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
		
	: (vperiodo=3)
		viSRal_InasistenciasPeriodo:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
		vrSRal_PctAsistenciaPeriodo:=[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158
		viSRal_AtrasosPeriodo:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165+[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
		viSRal_AntNegativasPeriodo:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
		viSRal_AntPositivasPeriodo:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
		viSRal_CastigosPeriodo:=[Alumnos_SintesisAnual:210]P03_Castigos:168
		viSRal_SuspensionesPeriodo:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169
		vtSRal_ComentariosPeriodo:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
		viSRal_HorasPeriodo:=[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157
		viSRal_HorasInasistPeriodo:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
		
		
	: (vperiodo=4)
		viSRal_InasistenciasPeriodo:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
		vrSRal_PctAsistenciaPeriodo:=[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187
		viSRal_AtrasosPeriodo:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194+[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
		viSRal_AntNegativasPeriodo:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
		viSRal_AntPositivasPeriodo:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
		viSRal_CastigosPeriodo:=[Alumnos_SintesisAnual:210]P04_Castigos:197
		viSRal_SuspensionesPeriodo:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198
		vtSRal_ComentariosPeriodo:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
		viSRal_HorasPeriodo:=[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186
		viSRal_HorasInasistPeriodo:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
		
	: (vPeriodo=5)
		viSRal_InasistenciasPeriodo:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
		vrSRal_PctAsistenciaPeriodo:=[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216
		viSRal_AtrasosPeriodo:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223+[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
		viSRal_AntNegativasPeriodo:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
		viSRal_AntPositivasPeriodo:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
		viSRal_CastigosPeriodo:=[Alumnos_SintesisAnual:210]P05_Castigos:226
		viSRal_SuspensionesPeriodo:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227
		vtSRal_ComentariosPeriodo:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
		viSRal_HorasPeriodo:=[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215
		viSRal_HorasInasistPeriodo:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
End case 


viSRal_InasistenciasTotal:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
vrSRal_PctAsistenciaTotal:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
viSRal_HorasInasistTotal:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
viSRal_AtrasosTotal:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40+[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
viSRal_AntNegativasTotal:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
viSRal_AntPositivasTotal:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
viSRal_CastigosTotal:=[Alumnos_SintesisAnual:210]Castigos:43
viSRal_SuspensionesTotal:=[Alumnos_SintesisAnual:210]Suspensiones:44
vtSRal_ComentariosFinal:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47

EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
viSRal_HorasInasistTotal:=0
viSRal_HorasInasistTotalJ:=0
Case of 
	: ($l_modoRegistroInasistencia=2)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=Current date:C33(*);*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Impartida:5=True:C214)
		viSRal_HorasTotal:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
		
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{vPeriodo};*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=adSTR_Periodos_Hasta{vPeriodo})
		viSRal_HorasPeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
		
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2;=;[Alumnos:2]numero:1)
		viSRal_HorasInasistTotal:=Records in selection:C76([Asignaturas_Inasistencias:125])
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Justificacion:3#"")
		viSRal_HorasInasistTotalJ:=Records in selection:C76([Asignaturas_Inasistencias:125])
		
		
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2;=;[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=adSTR_Periodos_Desde{vPeriodo};*)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=adSTR_Periodos_Hasta{vPeriodo})
		viSRal_HorasInasistPeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Justificacion:3#"")
		viSRal_HorasInasistPeriodoJ:=Records in selection:C76([Asignaturas_Inasistencias:125])
		vrSRal_PctAsistenciaPeriodo:=Round:C94((viSRal_HorasPeriodo-viSRal_HorasInasistPeriodo)/viSRal_HorasPeriodo*100;2)
		  //vrSRal_PctAsistenciaTotal:=Round((viSRal_HorasTotal-viSRal_HorasInasistTotal)/viSRal_HorasTotal*100;2)
		  //JVP 20160720 se corrige el porcentaje de asistencia
		  //se valida que tenga el mismo que el del explorador
		If (Round:C94((viSRal_HorasTotal-viSRal_HorasInasistTotal)/viSRal_HorasTotal*100;2)=vrSRal_PctAsistenciaTotal)
			vrSRal_PctAsistenciaTotal:=Round:C94((viSRal_HorasTotal-viSRal_HorasInasistTotal)/viSRal_HorasTotal*100;2)
		End if 
		
		
	: ($l_modoRegistroInasistencia=4)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=Current date:C33(*);*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Impartida:5=True:C214)
		viSRal_HorasTotal:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{vPeriodo};*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=adSTR_Periodos_Hasta{vPeriodo})
		viSRal_HorasPeriodo:=Records in selection:C76([Asignaturas_RegistroSesiones:168])
		
End case 






