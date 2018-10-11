//%attributes = {}
  //AL_JustificaInasistencias
ARRAY LONGINT:C221($alSTR_recNumInasistencias;0)
ARRAY LONGINT:C221($alSTR_asigInasis;0)

$id:=$1
READ ONLY:C145([Alumnos_Licencias:73])
QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]ID:6=$id)
$success:=True:C214

If (Records in selection:C76([Alumnos_Licencias:73])=1)
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Licencias:73]Alumno_numero:1;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=[Alumnos_Licencias:73]Desde:2;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=[Alumnos_Licencias:73]Hasta:3)
	If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];$alSTR_recNumInasistencias;"")
		For ($i;1;Size of array:C274($alSTR_recNumInasistencias))
			READ WRITE:C146([Alumnos_Inasistencias:10])
			GOTO RECORD:C242([Alumnos_Inasistencias:10];$alSTR_recNumInasistencias{$i})
			If (Not:C34(Locked:C147([Alumnos_Inasistencias:10])))
				[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
				[Alumnos_Inasistencias:10]Justificación:2:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
				If ([Alumnos_Inasistencias:10]Observaciones:3#"")
					[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Inasistencias:10]Observaciones:3+"\r"+[Alumnos_Licencias:73]Observaciones:5
				Else 
					[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Licencias:73]Observaciones:5
				End if 
				SAVE RECORD:C53([Alumnos_Inasistencias:10])
			Else 
				$i:=Size of array:C274($alSTR_recNumInasistencias)
				$success:=False:C215
			End if 
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		End for 
	End if 
	
	If ($success)
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
		$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
		
		READ ONLY:C145([Asignaturas_Inasistencias:125])
		If ($modoRegistroAsistencia=2)
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Licencias:73]Alumno_numero:1;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos_Licencias:73]Desde:2;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=[Alumnos_Licencias:73]Hasta:3)
			If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$alSTR_asigInasis;"")
				For ($i;1;Size of array:C274($alSTR_asigInasis))
					READ WRITE:C146([Asignaturas_Inasistencias:125])
					GOTO RECORD:C242([Asignaturas_Inasistencias:125];$alSTR_asigInasis{$i})
					If (Not:C34(Locked:C147([Asignaturas_Inasistencias:125])))
						[Asignaturas_Inasistencias:125]ID_Licencia:9:=[Alumnos_Licencias:73]ID:6
						[Asignaturas_Inasistencias:125]Justificacion:3:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
						If ([Asignaturas_Inasistencias:125]Observaciones:5#"")
							[Asignaturas_Inasistencias:125]Observaciones:5:=[Asignaturas_Inasistencias:125]Observaciones:5+"\r"+[Alumnos_Licencias:73]Observaciones:5
						Else 
							[Asignaturas_Inasistencias:125]Observaciones:5:=[Alumnos_Licencias:73]Observaciones:5
						End if 
						SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					Else 
						$i:=Size of array:C274($alSTR_asigInasis)
						$succes:=False:C215
					End if 
					KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
				End for 
			End if 
		End if 
	End if 
End if 

$0:=$success