//%attributes = {}
  //AL_ClearCurrentInfo

If (False:C215)
	  //Method: AL_ClearCurrentInfo
	  //Written by  Alberto Bachler on 26/3/98
	  //Module: Alumnos
	  //Purpose: elimina la información del año de un alumno
	  //Syntax:  AL_ClearCurrentInfo()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS


  //INITIALIZATION


  //MAIN CODE
OK:=0
If (Not:C34(In transaction:C397))
	START TRANSACTION:C239
	$handleTransaction:=True:C214
Else 
	$handleTransaction:=False:C215
End if 
$idAlumno:=[Alumnos:2]numero:1

EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)

If (ok=1)
	$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Alumnos:2]nivel_numero:29;->[Alumnos:2]numero:1)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Castigos:9];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Anotaciones:11];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Suspensiones:12];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_EvaluacionValorica:23];[Alumnos_EvaluacionValorica:23]Alumno_Numero:1=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionValorica:23];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Actividades:28];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_Atrasos:55];False:C215)
End if 
If (ok=1)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=$idAlumno)
	OK:=KRL_DeleteSelection (->[Alumnos_SintesisAnual:210];False:C215)
End if 
If (ok=1)
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$idAlumno)
	OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
End if 

KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;True:C214)  // 20120706 ASM. para volver a cargar el registro en escritura
If (ok=1)
	[Alumnos:2]Observaciones_Periodo1:44:=""
	[Alumnos:2]Observaciones_Periodo2:45:=""
	[Alumnos:2]Observaciones_Periodo3:46:=""
	[Alumnos:2]Observaciones_Periodo4:55:=""
	[Alumnos:2]Observaciones_Periodo5:106:=""
	[Alumnos:2]Observaciones_finales:47:=""
	[Alumnos:2]Situacion_final:33:=""
	[Alumnos:2]Porcentaje_asistencia:56:=100
	[Alumnos:2]Promedio_General_Numerico:57:=0
	[Alumnos:2]Promedio_General_Interno:88:=""
	[Alumnos:2]Promedio_General_Oficial:32:=""
	[Alumnos:2]Promedio_Periodo1:59:=""
	[Alumnos:2]Promedio_Periodo2:60:=""
	[Alumnos:2]Promedio_Periodo3:61:=""
	[Alumnos:2]Promedio_Periodo4:62:=""
	[Alumnos:2]Promedio_Periodo5:107:=""
	[Alumnos:2]Promedio_Anual:63:=""
	[Alumnos:2]Observaciones_en_Acta:58:=""
	[Alumnos:2]Promedio_General_Oficial:32:=""
	[Alumnos:2]Comentario_Situacion_Final:31:=""
	[Alumnos:2]Colación:52:=False:C215
	SAVE RECORD:C53([Alumnos:2])
	If ($handleTransaction)
		VALIDATE TRANSACTION:C240
	End if 
Else 
	If ($handleTransaction)
		CANCEL TRANSACTION:C241
	End if 
End if 
$0:=OK
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 
