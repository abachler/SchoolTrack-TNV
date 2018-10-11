//%attributes = {}
  // MÉTODO: ASev2_RegistraInasistencia
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/03/12, 18:19:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_RegistraInasistencia()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)
C_BOOLEAN:C305($0)

C_LONGINT:C283($l_recNumCalificaciones)
C_LONGINT:C283($l_valorEditado)
C_POINTER:C301($y_campoCalificaciones_Real)
C_LONGINT:C283($l_HorasImpartidasPeriodo)

  // CODIGO PRINCIPAL
$l_recNumCalificaciones:=$1
$l_inasistencias:=$2
$y_campoCalificaciones_Real:=$3


SET QUERY DESTINATION:C396(Into variable:K19:4;$l_horasAsignadas)
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_HorasImpartidasPeriodo)
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{atSTR_Periodos_Nombre};*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=adSTR_Periodos_Hasta{atSTR_Periodos_Nombre})
SET QUERY DESTINATION:C396(Into current selection:K19:1)


  //If (($l_inasistencias>$l_HorasImpartidasPeriodo) & ($l_horasAsignadas>0))
If ((($l_inasistencias>$l_HorasImpartidasPeriodo) & ($l_horasAsignadas>0)) | ($l_HorasImpartidasPeriodo=0))  //ASM 20121215 ticket 139390
	CD_Dlog (0;"Sólo se han impartido "+String:C10($l_HorasImpartidasPeriodo)+" horas de clase.\r\rNo es posible registrar más horas de inasistencias que las hora"+"s de clase realmente impartidas.")
Else 
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNumCalificaciones)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
	$y_campoCalificaciones_Real->:=$l_inasistencias
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
	KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
	$l_elemento:=Find in array:C230(aIdAlumnos_a_Recalcular;[Alumnos_Calificaciones:208]ID_Alumno:6)
	If ($l_elemento<0)
		APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;[Alumnos_Calificaciones:208]ID_Alumno:6)
	End if 
	$0:=True:C214
End if 