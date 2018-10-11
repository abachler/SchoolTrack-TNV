

If ([Alumnos:2]Fecha_de_Ingreso:41#!00-00-00!)
	If (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
		$continuar:=True:C214
	Else 
		CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No puede ingresar castigos para esa fecha."))
		$continuar:=False:C215
	End if 
Else 
	$continuar:=True:C214
End if 



If ((dFrom#!00-00-00!) & (iiHrs>0) & (sMotivo#"") & (iProfID>0) & (sName#""))
	
	If ($continuar=True:C214)
		If (IT_TypedListValueIsOK (->atSTRal_MotivosCastigo;->sMotivo))
			If ((Size of array:C274(aBrSelect)>=1) & (vLocation="browser"))
				For ($i;1;Size of array:C274(aBrSelect))
					READ ONLY:C145([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{aBrSelect{$i}})
					If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=dFrom)
						If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
							CREATE RECORD:C68([Alumnos_Castigos:9])
							[Alumnos_Castigos:9]Fecha:9:=dFrom
							[Alumnos_Castigos:9]Alumno_Numero:8:=[Alumnos:2]numero:1
							[Alumnos_Castigos:9]Motivo:2:=sMotivo
							[Alumnos_Castigos:9]Horas_de_castigo:7:=iiHrs
							[Alumnos_Castigos:9]Profesor_Numero:6:=iProfID
							[Alumnos_Castigos:9]Observaciones:3:=vt_observaciones
							[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29
							SAVE RECORD:C53([Alumnos_Castigos:9])
							
							LOG_RegisterEvt ("Conducta - Registro de Castigo: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20)  //ABC191346 
							UNLOAD RECORD:C212([Alumnos_Castigos:9])
							ACCEPT:C269
						Else 
							CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya está registrado como inasistente en esta fecha."))
						End if 
					End if 
				End for 
			Else 
				If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=dFrom)
					If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
						CREATE RECORD:C68([Alumnos_Castigos:9])
						[Alumnos_Castigos:9]Fecha:9:=dFrom
						[Alumnos_Castigos:9]Alumno_Numero:8:=[Alumnos:2]numero:1
						[Alumnos_Castigos:9]Motivo:2:=sMotivo
						[Alumnos_Castigos:9]Horas_de_castigo:7:=iiHrs
						[Alumnos_Castigos:9]Profesor_Numero:6:=iProfID
						[Alumnos_Castigos:9]Observaciones:3:=vt_observaciones
						[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29
						SAVE RECORD:C53([Alumnos_Castigos:9])
						LOG_RegisterEvt ("Conducta - Registro de Castigo: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20)  //ABC191346 
						UNLOAD RECORD:C212([Alumnos_Castigos:9])
						ACCEPT:C269
					Else 
						CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya está registrado como inasistente en esta fecha."))
					End if 
				End if 
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Por favor complete los campos obligatorios (en rojo)"))
End if 
