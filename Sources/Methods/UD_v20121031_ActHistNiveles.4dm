//%attributes = {}
  //UD_v20121031_ActHistNiveles

READ ONLY:C145([Asignaturas_Historico:84])
READ ONLY:C145([Alumnos_SintesisAnual:210])
READ ONLY:C145([Alumnos_Inasistencias:10])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ WRITE:C146([xxSTR_HistoricoNiveles:191])

C_LONGINT:C283($i;$nivel;$year)
ARRAY LONGINT:C221($RecNumNiveles;0)

ALL RECORDS:C47([xxSTR_HistoricoNiveles:191])
SELECTION TO ARRAY:C260([xxSTR_HistoricoNiveles:191];$RecNumNiveles)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando campo [xxSTR_HistoricoNiveles]ModoRegistroAsistencia  ")
For ($i;1;Size of array:C274($RecNumNiveles))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($RecNumNiveles))
	GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$RecNumNiveles{$i})
	$year:=[xxSTR_HistoricoNiveles:191]Año:2
	$nivel:=[xxSTR_HistoricoNiveles:191]NumeroNivel:3
	QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5=$year;*)
	QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Nivel:4=$nivel)
	KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas_Historico:84]ID_AsignaturaOriginal:30;"")
	QUERY SELECTION BY FORMULA:C207([Asignaturas_RegistroSesiones:168];Year of:C25([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)=$year)
	
	If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
		KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;"")
		If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
			  // por hora detallado
			[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=2
		Else 
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=$nivel;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=$year;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33#0)
			If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
				  //hora acumulado
				[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=4
			End if 
		End if 
	Else 
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Nivel_Numero:9=$nivel;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=$year)
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			  //Diario
			[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=1
		Else 
			  //Anual
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=$nivel;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=$year;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33#0)
			If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
				  //hora acumulado
				[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=3
			Else 
				[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=1
			End if 
		End if 
	End if 
	SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
