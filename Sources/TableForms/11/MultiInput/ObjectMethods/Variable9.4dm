C_BOOLEAN:C305($vb_registrar_anotacion)
$vb_registrar_anotacion:=(((Current date:C33(*)-dFrom)<=<>vi_nd_reg_anotacion) | (<>vi_nd_reg_anotacion=0))


If ((dFrom#!00-00-00!) & (sMotivo#"") & (iProfId>0) & (sName#"") & (vtSTRal_CategoriaAnotacion#""))
	_O_C_INTEGER:C282(siInasistente)
	siInasistente:=1
	$motivo:=sMotivo
	$prof:=iProfId
	If ((Size of array:C274(abrSelect)>1) & (vLocation="Browser"))
		
		C_BOOLEAN:C305($vb_ValidDate4All)
		  //ARRAY INTEGER($al_num_niv;0)  `el arreglo debe ser long desde 10.4
		ARRAY LONGINT:C221($al_num_niv;0)
		ARRAY LONGINT:C221($al_IdConfigPeriodo;0)
		For ($i;1;Size of array:C274(aBrSelect))
			KRL_GotoRecord (->[Alumnos:2];alBWR_recordNumber{aBrSelect{$i}})
			APPEND TO ARRAY:C911($al_num_niv;[Alumnos:2]nivel_numero:29)
		End for 
		AT_DistinctsArrayValues (->$al_num_niv)
		$vb_ValidDate4All:=True:C214
		
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;$al_num_niv)
		AT_DistinctsFieldValues (->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;->$al_IdConfigPeriodo)
		
		If (Size of array:C274($al_IdConfigPeriodo)>1)
			For ($i;1;Size of array:C274($al_IdConfigPeriodo))
				If ($vb_ValidDate4All)
					$vb_ValidDate4All:=DateIsValid (dFrom;0;$al_IdConfigPeriodo{$i})
				End if 
			End for 
		End if 
		
		If ($vb_ValidDate4All)
			For ($i;1;Size of array:C274(aBrSelect))
				READ ONLY:C145([Alumnos:2])
				KRL_GotoRecord (->[Alumnos:2];alBWR_recordNumber{aBrSelect{$i}})
				If (OK=1)
					If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
						QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=dFrom)
						If ((Records in selection:C76([Alumnos_Inasistencias:10])=0) & (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom) | ([Alumnos:2]Fecha_de_Ingreso:41=!00-00-00!)))
							If ($vb_registrar_anotacion)
								CREATE RECORD:C68([Alumnos_Anotaciones:11])
								[Alumnos_Anotaciones:11]Fecha:1:=dfrom
								[Alumnos_Anotaciones:11]Alumno_Numero:6:=[Alumnos:2]numero:1
								[Alumnos_Anotaciones:11]Motivo:3:=$motivo
								[Alumnos_Anotaciones:11]Categoria:8:=vtSTRal_CategoriaAnotacion
								[Alumnos_Anotaciones:11]Puntos:9:=vlSTRal_PuntosAnotación
								[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos:2]nivel_numero:29  //ASM 20130806 No se estaba guardando el numero del nivel
								Case of 
									: ([Alumnos_Anotaciones:11]Puntos:9>0)
										[Alumnos_Anotaciones:11]Signo:7:="+"
									: ([Alumnos_Anotaciones:11]Puntos:9=0)
										[Alumnos_Anotaciones:11]Signo:7:="="
									: ([Alumnos_Anotaciones:11]Puntos:9<0)
										[Alumnos_Anotaciones:11]Signo:7:="-"
								End case 
								[Alumnos_Anotaciones:11]Profesor_Numero:5:=$prof
								[Alumnos_Anotaciones:11]Observaciones:4:=vt_observaciones
								  //If (aAsignaturasProfesor>0)
								If (aAsignaturasProfesor>1)  //20160716 RCH Se agregó Sin Asignatura en posición 1
									[Alumnos_Anotaciones:11]Observaciones:4:=vt_observaciones+" ("+aAsignaturasProfesor{aAsignaturasProfesor}+")"
									[Alumnos_Anotaciones:11]Asignatura:10:=aAsignaturasProfesor{aAsignaturasProfesor}
								End if 
								SAVE RECORD:C53([Alumnos_Anotaciones:11])
								UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
								
								LOG_RegisterEvt ("Conducta - Registro de anotaciones: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20)
								If ((<>gNegCumul>0) & ([Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27>=<>gNegCumul) & ([Alumnos_Anotaciones:11]Signo:7="-"))
									autDetTxt:=[Alumnos:2]apellidos_y_nombres:40+" tiene "+String:C10([Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)+" anotaciones negativas acumuladas."
									autDetTxt:=autDetTxt+"\r"+"¿Que desea Ud. hacer?"
									QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1)
									QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7="-")
									SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Fecha:1;aAntDate;[Alumnos_Anotaciones:11]Motivo:3;aAntMot)
									SORT ARRAY:C229(aAntDate;aAntMot;<)
									If (Size of array:C274(aAntDate)>[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
										DELETE FROM ARRAY:C228(aAntDate;[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27+1;Size of array:C274(aAntDate)-[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
										DELETE FROM ARRAY:C228(aAntMot;[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27+1;Size of array:C274(aAntMot)-[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
									End if 
									WDW_OpenDialogInDrawer (->[Alumnos_Castigos:9];"AutDetention")
									CLOSE WINDOW:C154
								End if 
							Else 
								$t_mensaje:=__ ("El registro de anotaciones después de más ^0 días de la fecha del evento no está autorizado.\r\rPor favor consulte con el administrador si piensa que esto es un error.")
								$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(<>vi_nd_reg_anotacion))
								CD_Dlog (0;$t_mensaje)
							End if 
						Else 
							  //CD_Dlog (0;[Alumnos]Apellidos_y_Nombres+" está registrado como inasistente en esta fecha.")
							  //siInasistente:=0
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("No fue posible acceder al registro del alumno #")+String:C10(alBWR_recordNumber{aBrSelect{$i}})+__ (".\r\rPor favor seleccione en la lista los alumnos que desea anotar."))
				End if 
			End for 
		Else 
			CD_Dlog (0;"La fecha: "+String:C10(dFrom)+" no es válida para las distintas configuraciones de peridos de los alumnos selecc"+"ionados. Revise las configuraciones o ingrese de manera separada la anotación.")
		End if 
		
	Else 
		If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
			QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=dFrom)
			If ((Records in selection:C76([Alumnos_Inasistencias:10])=0) & (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom) | ([Alumnos:2]Fecha_de_Ingreso:41=!00-00-00!)))
				
				If ($vb_registrar_anotacion)
					CREATE RECORD:C68([Alumnos_Anotaciones:11])
					[Alumnos_Anotaciones:11]Fecha:1:=dfrom
					[Alumnos_Anotaciones:11]Alumno_Numero:6:=[Alumnos:2]numero:1
					[Alumnos_Anotaciones:11]Motivo:3:=$motivo
					[Alumnos_Anotaciones:11]Categoria:8:=vtSTRal_CategoriaAnotacion
					[Alumnos_Anotaciones:11]Puntos:9:=vlSTRal_PuntosAnotación
					[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos:2]nivel_numero:29  //ASM 20130806 No se estaba guardando el numero del nivel
					Case of 
						: ([Alumnos_Anotaciones:11]Puntos:9>0)
							[Alumnos_Anotaciones:11]Signo:7:="+"
						: ([Alumnos_Anotaciones:11]Puntos:9=0)
							[Alumnos_Anotaciones:11]Signo:7:="="
						: ([Alumnos_Anotaciones:11]Puntos:9<0)
							[Alumnos_Anotaciones:11]Signo:7:="-"
					End case 
					[Alumnos_Anotaciones:11]Profesor_Numero:5:=$prof
					[Alumnos_Anotaciones:11]Observaciones:4:=vt_observaciones
					  //If (aAsignaturasProfesor>0)
					If (aAsignaturasProfesor>1)  //20160716 RCH Se agregó Sin Asignatura en posición 1
						[Alumnos_Anotaciones:11]Observaciones:4:=vt_observaciones+" ("+aAsignaturasProfesor{aAsignaturasProfesor}+")"
						[Alumnos_Anotaciones:11]Asignatura:10:=aAsignaturasProfesor{aAsignaturasProfesor}
					Else 
						If (aAsignaturasProfesor=1)
							  //
							  // Modificado por: Alexis Bustamante (17-07-2017)
							  //para que quede igual que STWA
							  //TICKET 185635 
							[Alumnos_Anotaciones:11]Observaciones:4:=vt_observaciones+" ("+aAsignaturasProfesor{aAsignaturasProfesor}+")"
						End if 
					End if 
					SAVE RECORD:C53([Alumnos_Anotaciones:11])
					  // Modificado por: Alexis Bustamante (08-06-2017)
					  //agrego log
					LOG_RegisterEvt ("Conducta - Registro de anotaciones: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20)
					
					UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
					LOAD RECORD:C52([Alumnos_Conducta:8])
					
					
					
					
					If ((<>gNegCumul>0) & ([Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27>=<>gNegCumul) & ([Alumnos_Anotaciones:11]Signo:7="-"))
						autDetTxt:=[Alumnos:2]apellidos_y_nombres:40+" tiene "+String:C10([Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)+" anotaciones negativas acumuladas."
						autDetTxt:=autDetTxt+"\r"+"¿ Que desea Ud. hacer ?"
						QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1)
						QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7="-")
						SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Fecha:1;aAntDate;[Alumnos_Anotaciones:11]Motivo:3;aAntMot)
						SORT ARRAY:C229(aAntDate;aAntMot;<)
						If (Size of array:C274(aAntDate)>[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
							DELETE FROM ARRAY:C228(aAntDate;[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27+1;Size of array:C274(aAntDate)-[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
							DELETE FROM ARRAY:C228(aAntMot;[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27+1;Size of array:C274(aAntMot)-[Alumnos_Conducta:8]Cumulo_de_anotaciones_negativas:27)
						End if 
						  //WDW_Open (350;250;0;4;"Generación de castigo")
						WDW_OpenFormWindow (->[Alumnos_Castigos:9];"AutDetention";0;4;__ ("Generación de castigo"))
						DIALOG:C40([Alumnos_Castigos:9];"AutDetention")
						CLOSE WINDOW:C154
					End if 
				Else 
					$t_mensaje:=__ ("El registro de anotaciones después de más ^0 días de la fecha del evento no está autorizado.\r\rPor favor consulte con el administrador si piensa que esto es un error.")
					$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(<>vi_nd_reg_anotacion))
					CD_Dlog (0;$t_mensaje)
				End if 
			Else 
				
				Case of 
					: (Records in selection:C76([Alumnos_Inasistencias:10])>0)
						CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" está registrado como inasistente en esta fecha."))
					: ([Alumnos:2]Fecha_de_Ingreso:41>dFrom)
						CD_Dlog (0;__ ("La fecha de ingreso del alumno es mayor a la seleccionada. No es posible ingresar la anotación."))
				End case 
				siInasistente:=0
			End if 
		End if 
	End if 
	If (siInasistente=1)
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("Por favor complete los campos obligatorios (en rojo)"))
End if 
