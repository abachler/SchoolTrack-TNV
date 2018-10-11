If (Self:C308->=True:C214)
	OBJECT SET VISIBLE:C603(*;"muerte@";True:C214)
	If (Old:C35(Self:C308->)=False:C215)
		$Fechafecha:=DT_PopCalendar 
		If ($Fechafecha#!00-00-00!)
			[Alumnos:2]Fecha_Deceso:98:=$Fechafecha
		Else 
			[Alumnos:2]Fecha_Deceso:98:=!00-00-00!
			OBJECT SET VISIBLE:C603(*;"muerte@";False:C215)
			Self:C308->:=False:C215
		End if 
		If ([Alumnos:2]Fecha_Deceso:98>Current date:C33(*))
			CD_Dlog (0;__ ("El deceso no puede producirse en una fecha posterior a hoy."))
			[Alumnos:2]Fecha_Deceso:98:=!00-00-00!
			OBJECT SET VISIBLE:C603(*;"muerte@";False:C215)
			Self:C308->:=False:C215
		End if 
		If (Self:C308->)
			  //retirar
			$oldStatus:=[Alumnos:2]Status:50
			$newStatus:="Retirado"
			$fia:=Find in array:C230(<>al_NumeroNivelesActivos;[Alumnos:2]nivel_numero:29)
			
			Case of 
				: (<>vtXS_CountryCode="cl")
					$date:=[Alumnos:2]Fecha_Deceso:98
					If ($date<(DT_GetDateFromDayMonthYear (1;5;<>gYear)))
						If ($fia>0)
							OK:=CD_Dlog (0;__ ("La fecha de retiro de este alumno implica que no debe figurar en actas. \rPuede retirarlo definitivamente de la lista del curso borrando la información del año corriente.\r¿Desea retirarlo ahora y moverlo al grupo de retirados?");__ ("");__ ("Retirar ahora");__ ("Dejar en el curso");__ ("Cancelar"))
						Else 
							ok:=1
						End if 
						Case of 
							: (OK=1)
								OK:=AL_ClearCurrentInfo 
								If (OK=1)
									
									If ($fia>0)
										[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
										[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
										[Alumnos:2]curso:20:="RET"+String:C10(Year of:C25($date))
										[Alumnos:2]nivel_numero:29:=Nivel_Retirados
										[Alumnos:2]Nivel_Nombre:34:="Retirados"
										[Alumnos:2]Sección:26:="Retirados"
										[Alumnos:2]Fecha_de_retiro:42:=$date
										[Alumnos:2]Status:50:=$newStatus
										[Alumnos:2]Situacion_final:33:="Y"
										[Alumnos:2]Motivo_de_retiro:43:="Fallecimiento"
									End if 
									[Alumnos:2]Tutor_numero:36:=0
									SAVE RECORD:C53([Alumnos:2])
									If ($fia>0)
										LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$oldStatus+" a "+$newStatus+" por fallecimiento.")
									End if 
								End if 
							: (OK=2)
								
								If ($fia>0)
									[Alumnos:2]Tutor_numero:36:=0
									[Alumnos:2]Fecha_de_retiro:42:=$date
									[Alumnos:2]Status:50:=$newStatus
									[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
									[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
									[Alumnos:2]Motivo_de_retiro:43:="Fallecimiento"
								End if 
								SAVE RECORD:C53([Alumnos:2])
								$recNum:=Record number:C243([Alumnos:2])
								QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
								If (Records in selection:C76([Cursos:3])=1)
									CU_CalculaPromedios (Record number:C243([Cursos:3]))
								End if 
								GOTO RECORD:C242([Alumnos:2];$recNum)
								If ($fia>0)
									LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$oldStatus+" a "+$newStatus+" por fallecimiento.")
								End if 
							Else 
								[Alumnos:2]Fecha_Deceso:98:=!00-00-00!
								OBJECT SET VISIBLE:C603(*;"muerte@";False:C215)
								Self:C308->:=False:C215
						End case 
					Else 
						If ($fia>0)
							OK:=CD_Dlog (0;__ ("Este alumno debe permanecer en el listado del curso ya que por la fecha de salida debe figurar en el acta (sin notas).\rSerá marcado como retirado y conservará toda la información del año corriente.\r¿Desea marcar al alumno como retirado?");__ ("");__ ("Sí");__ ("No"))
						Else 
							ok:=1
						End if 
						If (Ok=1)
							If ($fia>0)
								[Alumnos:2]Fecha_de_retiro:42:=$date
								[Alumnos:2]Status:50:=$newStatus
								[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
								[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
								[Alumnos:2]Motivo_de_retiro:43:="Fallecimiento"
							End if 
							SAVE RECORD:C53([Alumnos:2])
							$recNum:=Record number:C243([Alumnos:2])
							QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
							If (Records in selection:C76([Cursos:3])=1)
								CU_CalculaPromedios (Record number:C243([Cursos:3]))
							End if 
							GOTO RECORD:C242([Alumnos:2];$recNum)
							If ($fia>0)
								LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$oldStatus+" a "+$newStatus+" por fallecimiento.")
							End if 
						Else 
							[Alumnos:2]Fecha_Deceso:98:=!00-00-00!
							OBJECT SET VISIBLE:C603(*;"muerte@";False:C215)
							Self:C308->:=False:C215
						End if 
					End if 
				: (<>vtXS_CountryCode="co")
					
					If ($fia>0)
						[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
						[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
						[Alumnos:2]curso:20:="RET"+String:C10(<>gYear)
						[Alumnos:2]nivel_numero:29:=Nivel_Retirados
						[Alumnos:2]Nivel_Nombre:34:="Retirados"
						[Alumnos:2]Sección:26:="Retirados"
						[Alumnos:2]Fecha_de_retiro:42:=$date
						[Alumnos:2]Status:50:=$newStatus
						[Alumnos:2]Situacion_final:33:="Y"
						[Alumnos:2]Motivo_de_retiro:43:="Fallecimiento"
					End if 
					[Alumnos:2]Tutor_numero:36:=0
					SAVE RECORD:C53([Alumnos:2])
					If ($fia>0)
						LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$oldStatus+" a "+$newStatus+" por fallecimiento.")
					End if 
					  //`verificar si pais es Colombia
					If (<>vtXS_CountryCode="co")
						  //para saber si hay registros tomados
						QUERY:C277([Alumnos:2];[Alumnos:2]NumeroDeFolio:103#"")
						ARRAY TEXT:C222($aText;Records in selection:C76([Alumnos:2]))
						
						READ WRITE:C146([Alumnos:2])
						CREATE EMPTY SET:C140([Alumnos:2];"lockedSet")
						ARRAY TO SELECTION:C261($aText;[Alumnos:2]NumeroDeFolio:103)
						
						If (Records in set:C195("lockedSet")>0)  //`si hay registros tomados
							$r:=CD_Dlog (0;__ ("La actualización de números de folio involucra a muchos registros de alumnos, por lo que es posible \rque no pueda realizarse mientras otros usuarios estén en Schooltrack. \rQue desea hacer?");__ ("");__ ("Seguir intentando");__ ("Dejar como tarea de fin de día"))
							
							Case of 
								: ($r=2)
									  //`tarea de fin de dia, no sigo intentando, seteo la preferencia en 0
									PREF_Set (0;"AsignacionNumeroFolio";"1")  //para ejecutarse en las tareas de fin de dia
								Else 
									  //`asigno la tarea a las tareas programadas
									BM_CreateRequest ("co-AsignaNumerosDeFolio")
									  //AL_AsignaNoDeFolio
							End case 
						Else 
							BM_CreateRequest ("co-AsignaNumerosDeFolio")
						End if 
					End if 
				Else 
					
					If ($fia>0)
						[Alumnos:2]NoNIvel_alRetirarse:84:=[Alumnos:2]nivel_numero:29
						[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
						[Alumnos:2]curso:20:="RET"+String:C10(<>gYear)
						[Alumnos:2]nivel_numero:29:=Nivel_Retirados
						[Alumnos:2]Nivel_Nombre:34:="Retirados"
						[Alumnos:2]Sección:26:="Retirados"
						[Alumnos:2]Fecha_de_retiro:42:=$date
						[Alumnos:2]Status:50:=$newStatus
						[Alumnos:2]Situacion_final:33:="Y"
						[Alumnos:2]Motivo_de_retiro:43:="Fallecimiento"
					End if 
					[Alumnos:2]Tutor_numero:36:=0
					SAVE RECORD:C53([Alumnos:2])
					If ($fia>0)
						LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$oldStatus+" a "+$newStatus+" por fallecimiento.")
					End if 
			End case 
		End if 
	End if 
Else 
	OBJECT SET VISIBLE:C603(*;"muerte@";False:C215)
	[Alumnos:2]Fecha_Deceso:98:=!00-00-00!
End if 
OBJECT SET VISIBLE:C603(*;"muerte@";[Alumnos:2]Fallecido:97)
IT_SetEnterable (Not:C34([Alumnos:2]Fallecido:97);0;->[Alumnos:2]Status:50;->[Alumnos:2]Motivo_de_retiro:43)
IT_SetButtonState ((Not:C34([Alumnos:2]Fallecido:97));->bStatus)
OBJECT SET VISIBLE:C603(*;"fechaRetiro@";(([Alumnos:2]Fecha_de_retiro:42#!00-00-00!) | ([Alumnos:2]Status:50="Retirado@")))