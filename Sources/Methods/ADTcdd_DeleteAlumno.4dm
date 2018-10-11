//%attributes = {}
  //ADTcdd_DeleteAlumno

$0:=0
OK:=AL_ClearCurrentInfo 
If (OK=1)
	QUERY:C277([Alumnos_Conducta:8];[Alumnos_Conducta:8]Número_de_Alumno:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_Conducta:8];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_SintesisAnual:210];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_FichaMedica:13];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_Vacunas:101];False:C215)
End if 

If (OK=1)
	If (OK=1)
		$key:="2."+String:C10([Alumnos:2]numero:1)
		QUERY:C277([MDATA_RegistrosDatosLocales:145];[MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6=$key)
		OK:=KRL_DeleteSelection (->[MDATA_RegistrosDatosLocales:145];False:C215)
	End if 
End if 

If (OK=1)
	QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_EventosEnfermeria:14];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_EventosPersonales:16];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Alumno_Numero:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_EventosOrientacion:21];False:C215)
End if 

If (OK=1)
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Alumnos_Historico:25];False:C215)
End if 

If (OK=1)
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1)
	OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
End if 

If (OK=1)
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
End if 
$0:=ok