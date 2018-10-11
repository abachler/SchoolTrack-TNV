  //Método de Objeto: Botón invisible1




C_BOOLEAN:C305($crearAtraso;$eliminarInasis)
C_BOOLEAN:C305($vb_intersesion)
C_TEXT:C284($vRUT)
C_TEXT:C284($vHoraSTR)
C_TIME:C306($vHora)
If (vRut#"")
	  //ticket 161114 JVP 
	If (vl_OptSearch#1)
		vRUT:=Replace string:C233(Replace string:C233(vRUT;".";"");"-";"")
	End if 
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([BBL_Lectores:72])
	QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=vRUT)
	If (Records in selection:C76([Alumnos:2])=0)
		QUERY:C277([Alumnos:2];[Alumnos:2]IDNacional_2:71=vRUT)
		If (Records in selection:C76([Alumnos:2])=0)
			QUERY:C277([Alumnos:2];[Alumnos:2]IDNacional_3:70=vRUT)
			If (Records in selection:C76([Alumnos:2])=0)
				QUERY:C277([Alumnos:2];[Alumnos:2]NoPasaporte:87=vRUT)
				If (Records in selection:C76([Alumnos:2])=0)
					QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6=vRUT)
					If (Records in selection:C76([Alumnos:2])=0)
						$vRUT:="*"+vRUT+"*"
						QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Código_de_barra:10=$vRUT)
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[BBL_Lectores:72]Número_de_alumno:6)
						If (Records in selection:C76([Alumnos:2])=0)
							QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=vRUT)
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
	Case of 
		: (Records in selection:C76([Alumnos:2])>1)  //Si hay más de un alumno encontrado
			CD_Dlog (0;__ ("Existen")+String:C10(Records in selection:C76([Alumnos:2]))+__ (" alumnos con el mismo RUT. El atraso no puede ser ingresado"))
			vRUT:=""
			GOTO OBJECT:C206(vRut)
		: (Records in selection:C76([Alumnos:2])=1)  //Si encontró un alumno
			READ ONLY:C145([xxSTR_Niveles:6])
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
			If ([xxSTR_Niveles:6]Lates_Mode:16=1)
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				If (Size of array:C274(alSTR_Horario_Desde)>0)
					If (DateIsValid (vFecha;0))
						$vHoraSTR:=String:C10(vHora;HH MM SS:K7:1)
						$vHora:=Time:C179($vHoraSTR)
						If (($vHora>=alSTR_Horario_Desde{1}) & ($vHora<=alSTR_Horario_Hasta{Size of array:C274(alSTR_Horario_Hasta)}))
							READ ONLY:C145([Alumnos_Inasistencias:10])
							QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
							QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=vFecha)
							If (Records in selection:C76([Alumnos_Inasistencias:10])=0)  //Alumno se encuentra presente y atrasado
								minutos_de_atraso:=Round:C94(Abs:C99($vHora-alSTR_Horario_Desde{1})/60;0)
								AL_UpdateArrays (xALP_Cond_Atrasos;0)
								AL_SetLine (xALP_Cond_Atrasos;0)
								If (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite"))
									QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1)
									QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=vFecha)
									If (Records in selection:C76([Alumnos_Atrasos:55])=0)
										$crearAtraso:=True:C214
									Else 
										  //20121122 RCH Para manejar los atrasos intersesion.
										  //CD_Dlog (0;[Alumnos]Nombres+__ (" ")+[Alumnos]Apellido_paterno+__ (" ")+[Alumnos]Apellido_materno+__ ("  ya tiene ingresado un atraso el día de hoy."))
										If (Num:C11(PREF_fGet (0;"AllowMultipleLates";"0"))=1)
											$crearAtraso:=True:C214
											$vb_intersesion:=True:C214
										Else 
											CD_Dlog (0;[Alumnos:2]Nombres:2+__ (" ")+[Alumnos:2]Apellido_paterno:3+__ (" ")+[Alumnos:2]Apellido_materno:4+__ ("  ya tiene ingresado un atraso el día de hoy."))
										End if 
									End if 
								End if 
							Else 
								$resp:=CD_Dlog (0;[Alumnos:2]Nombres:2+__ (" ")+[Alumnos:2]Apellido_paterno:3+__ (" ")+[Alumnos:2]Apellido_materno:4+__ ("  ya está registrado como inasistente en esta fecha.\rDesea eliminar la inasistencia e ingresar el atraso?");__ ("");__ ("Si");__ ("No"))
								If ($resp=1)
									$eliminarInasis:=True:C214
									$crearAtraso:=True:C214
								End if 
							End if 
							If ($crearAtraso)
								If ($eliminarInasis)
									READ WRITE:C146([Alumnos_Inasistencias:10])
									QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
									QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=vFecha)
									DELETE RECORD:C58([Alumnos_Inasistencias:10])
									KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
									LOG_RegisterEvt ("Eliminación de Inasistencia ("+String:C10([Alumnos_Inasistencias:10]Fecha:1;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40)
								End if 
								CREATE RECORD:C68([Alumnos_Atrasos:55])
								[Alumnos_Atrasos:55]Fecha:2:=vFecha
								[Alumnos_Atrasos:55]HoradeAtraso:12:=$vHora
								[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
								[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
								  //20121122 RCH Para manejar atraso intersesion
								  //[Alumnos_Atrasos]EsAtrasoInterSesiones:=False
								[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=$vb_intersesion
								[Alumnos_Atrasos:55]MinutosAtraso:5:=minutos_de_atraso  //EMA 05/10/06
								$id_alumno:=[Alumnos_Atrasos:55]Alumno_numero:1
								SAVE RECORD:C53([Alumnos_Atrasos:55])
								KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
								LOG_RegisterEvt ("Conducta - Registro de atraso: "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;Table:C252(->[Alumnos:2]);[Alumnos:2]numero:1)
								AT_Insert (1;1;->at_STR_Apellidos_Nombres;->at_STR_Curso;->ad_STR_Fecha;->al_STR_Minutos_Atrasos)
								at_STR_Apellidos_Nombres{1}:=[Alumnos:2]apellidos_y_nombres:40
								at_STR_Curso{1}:=[Alumnos:2]curso:20
								ad_STR_Fecha{1}:=vFecha
								al_STR_Minutos_Atrasos{1}:=minutos_de_atraso
								
								If (cbImprimirReport=1)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$id_alumno)
									QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[Alumnos:2]);*)
									QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=atSTR_Modelos{atSTR_Modelos})
									If (Records in selection:C76([xShell_Reports:54])=1)
										$reportRecNum:=Record number:C243([xShell_Reports:54])
										C_POINTER:C301($ptrCurrentTable)
										$ptrCurrentTable:=yBWR_currentTable
										READ ONLY:C145(*)
										GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
										$reportName:=[xShell_Reports:54]FormName:17
										$specialConfig:=[xShell_Reports:54]SpecialParameter:18
										$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
										$tablePointer:=Table:C252($tableNumber)
										yBWR_currentTable:=$tablePointer
										xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
										COPY NAMED SELECTION:C331([Alumnos:2];"◊Editions")
										  //MONO Ticket 179726
										SRP_ValidaAjustesImpresion ($reportRecNum)
										  //If (SR Validate (xSR_ReportBlob)=0)
										  //OK:=SR Page Setup (xSR_ReportBlob)
										  //If (OK=1)
										  //READ WRITE([xShell_Reports])
										  //LOAD RECORD([xShell_Reports])
										  //[xShell_Reports]xReportData_:=xSR_ReportBlob
										  //SAVE RECORD([xShell_Reports])
										  //KRL_ReloadAsReadOnly (->[xShell_Reports])
										  //End if 
										  //Else 
										  //OK:=1
										  //End if 
										If (ok=1)
											GET AUTOMATIC RELATIONS:C899($one;$many)
											$err:=SR Print Report (xSR_ReportBlob;4;65535)
											SET AUTOMATIC RELATIONS:C310($one;$many)
										End if 
										yBWR_currentTable:=$ptrCurrentTable
									Else 
										CD_Dlog (0;__ ("El modelo seleccionado ha sido eliminado por otro usuario. Intente la impresión más tarde."))
									End if 
								End if 
								
							End if 
							AL_UpdateArrays (xALP_Cond_Atrasos;-2)
							vRUT:=""
							GOTO OBJECT:C206(vRut)
						Else 
							CD_Dlog (0;__ ("Atraso fuera del horario académico."))
							vRUT:=""
							GOTO OBJECT:C206(vRut)
						End if 
					Else 
						CD_Dlog (0;__ ("La fecha no corresponde al período académico configurado."))
						vRUT:=""
						GOTO OBJECT:C206(vRut)
					End if 
				Else 
					CD_Dlog (0;__ ("No hay horario definido en la configuración de períodos asignada al nivel del alumno."))
				End if 
			Else 
				CD_Dlog (0;__ ("El nivel del alumno no permite registrar atrasos diarios."))
				vRUT:=""
				GOTO OBJECT:C206(vRut)
			End if 
		: (Records in selection:C76([Alumnos:2])=0)  //NO existe el Alumno
			CD_Dlog (0;__ ("Alumno no existe."))
			vRUT:=""
			GOTO OBJECT:C206(vRut)
	End case 
Else 
	CD_Dlog (0;__ ("No existen datos ingresados."))
End if 