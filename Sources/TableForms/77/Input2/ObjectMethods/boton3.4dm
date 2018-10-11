  //20080818 RCH Se agregó el cálculo de no de cargas para el nuevo apdo y para el ex apdo.
C_LONGINT:C283($vl_idNewApdo;$exApdo)
If (vApNme#"")
	Case of 
		: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
			$continue:=False:C215
			$al_RecNumAlumno:=Record number:C243([Alumnos:2])
			  //AS. 20110725 se agrega para manejar el cambio de apoderado de cuentas.
			If (aiACT_ChangeDeuda2NewAPdo=1)
				WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasSeleccion";0;-Palette form window:K39:9;__ ("Cuentas Corrientes"))
				DIALOG:C40([ACT_CuentasCorrientes:175];"CtasSeleccion")
				CLOSE WINDOW:C154
			Else 
				C_BOOLEAN:C305(vb_continue)
				vb_continue:=True:C214
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;al_NumAlumnos)
			End if 
			
			If (vb_continue)
				For ($x;1;Size of array:C274(al_NumAlumnos))  //se agrega para manejar el cambio de apoderado de cuentas.
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=al_NumAlumnos{$x})
					RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
					If (Records in selection:C76([Alumnos:2])=0)
						GOTO RECORD:C242([Alumnos:2];$al_RecNumAlumno)
					End if 
					If (bap2=1)
						If (viACT_ACTDecideApoderado=0)
							READ ONLY:C145([ACT_CuentasCorrientes:175])
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
							$exApdo:=[Alumnos:2]Apoderado_Cuentas_Número:28
							Case of 
								: (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
									If (Not:C34(KRL_ReadWrite (->[ACT_CuentasCorrientes:175])))
										[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
										QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
										$recNum:=Record number:C243([ACT_CuentasCorrientes:175])
										$recNumAlumno:=Record number:C243([Alumnos:2])
										$recNumPersona:=Record number:C243([Personas:7])
										$continue:=ACTcc_ChangeAccountParent 
										If ($continue)
											READ WRITE:C146([Personas:7])
											QUERY:C277([Personas:7];[Personas:7]No:1=$exApdo)
											[Personas:7]No:1:=[Personas:7]No:1
											SAVE RECORD:C53([Personas:7])
											GOTO RECORD:C242([Personas:7];$recNumPersona)
										End if 
										READ ONLY:C145([ACT_CuentasCorrientes:175])
										GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
										ACTcc_OrderCtasCtes ([ACT_CuentasCorrientes:175]ID:1)
										READ ONLY:C145([ACT_CuentasCorrientes:175])
										GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
										READ WRITE:C146([Alumnos:2])
										GOTO RECORD:C242([Alumnos:2];$recNumAlumno)
										AL_UpdateArrays (xALP_Hermano;0)
										AL_LoadBrothers 
										AL_UpdateArrays (xALP_Hermano;-2)
										GOTO RECORD:C242([Alumnos:2];$recNumAlumno)
										GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
									Else 
										$ignore:=CD_Dlog (0;__ ("No fue posible modificar el registro asociado en AccountTrack.\rPor favor intente más tarde."))
										$continue:=False:C215
									End if 
								: (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
									$continue:=True:C214
								: (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
									$ignore:=CD_Dlog (0;__ ("Se detecto más de un registro asociado en AccountTrack.\rPóngase en contacto con el administrador de AccountTrack."))
									$continue:=False:C215
							End case 
						Else 
							  //JBA 17032010
							$continue:=True:C214
						End if 
					Else 
						$continue:=True:C214
					End if 
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Alumnos:2]Familia_Número:24
					If ($continue)
						  //ABK 29/10/2008
						If (Read only state:C362([Alumnos:2]))
							READ WRITE:C146([Alumnos:2])
							LOAD RECORD:C52([Alumnos:2])
						End if 
						Case of 
							: ((bap1=1) & (bap2=1))
								[Alumnos:2]Apoderado_académico_Número:27:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=3
							: (bap1=1)
								[Alumnos:2]Apoderado_académico_Número:27:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=1
							: (bap2=1)
								[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=2
							Else 
								Case of 
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_académico_Número:27) & ([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_Cuentas_Número:28) & (bap1=0) & (bap2=0))
										[Alumnos:2]Apoderado_Cuentas_Número:28:=0
										[Alumnos:2]Apoderado_académico_Número:27:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=0
										[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_académico_Número:27) & (bap1=0))
										[Alumnos:2]Apoderado_académico_Número:27:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=[Familia_RelacionesFamiliares:77]Apoderado:5-1
										[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_Cuentas_Número:28) & (bap2=0))
										[Alumnos:2]Apoderado_Cuentas_Número:28:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=[Familia_RelacionesFamiliares:77]Apoderado:5-1
										[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3#[Alumnos:2]Apoderado_académico_Número:27) & ([Familia_RelacionesFamiliares:77]ID_Persona:3#[Alumnos:2]Apoderado_Cuentas_Número:28) & (bap1=0) & (bap2=0))
										[Familia_RelacionesFamiliares:77]Apoderado:5:=0
										[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
								End case 
						End case 
						$vl_idNewApdo:=[Alumnos:2]Apoderado_Cuentas_Número:28
						SAVE RECORD:C53([Alumnos:2])
						KRL_ReloadAsReadOnly (->[Alumnos:2])  //ABK 29/10/2008
						
						Case of 
							: ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Padre_Número:5:=0
							: ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Madre_Número:6:=0
						End case 
						
						Case of 
							: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=1)
								READ ONLY:C145([Personas:7])
								QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=2)
								READ ONLY:C145([Personas:7])
								QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
								[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
						End case 
						SAVE RECORD:C53([Familia:78])
					End if 
					If (Is new record:C668([Familia_RelacionesFamiliares:77]))
						$log:="Creación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+[Personas:7]Apellidos_y_nombres:30+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
					Else 
						$log:="Modificación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+[Personas:7]Apellidos_y_nombres:30+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
					End if 
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					LOG_RegisterEvt ($log)
					
					C_LONGINT:C283($recNumP;$recNumRF)  //para actualizar la condición de apdo de cta y apdo acad de todas las personas
					$recNumP:=Record number:C243([Personas:7])
					$recNumRF:=Record number:C243([Familia_RelacionesFamiliares:77])
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
					KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					KRL_ReloadInReadWriteMode (->[Personas:7])
					FIRST RECORD:C50([Personas:7])
					While (Not:C34(End selection:C36([Personas:7])))
						[Personas:7]No:1:=[Personas:7]No:1
						SAVE RECORD:C53([Personas:7])  //to force trigger execution
						NEXT RECORD:C51([Personas:7])
					End while 
					If ($exApdo#0)
						ACTpp_CalculaNoCargas ($exApdo)
					End if 
					If ($vl_idNewApdo#0)
						ACTpp_CalculaNoCargas ($vl_idNewApdo)
					End if 
					GOTO RECORD:C242([Personas:7];$recNumP)
					GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$recNumRF)
				End for 
			End if 
			KRL_ReloadAsReadOnly (->[ACT_CuentasCorrientes:175])
		: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
			
			  //AS. 20110725 se agrega para manejar el cambio de apoderado de cuentas.
			If (aiACT_ChangeDeuda2NewAPdo=1)
				WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasSeleccion";0;-Palette form window:K39:9;__ ("Cuentas Corrientes"))
				DIALOG:C40([ACT_CuentasCorrientes:175];"CtasSeleccion")
				CLOSE WINDOW:C154
			Else 
				C_BOOLEAN:C305(vb_continue)
				vb_continue:=True:C214
				RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;al_NumAlumnos)
			End if 
			
			If (vb_continue)
				For ($x;1;Size of array:C274(al_NumAlumnos))  //AS. 20110725 se agrega para manejar el cambio de apoderado de cuentas.
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=al_NumAlumnos{$x})  //cambio
					RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)  //AS. 20110725 se agrega para manejar el cambio de apoderado de cuentas.
					$proc:=IT_UThermometer (1;0;__ ("Cambiando apoderado de cuenta..."))
					$continue:=False:C215
					$recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
					If (changeAP)
						If (Not:C34(KRL_ReadWrite (->[Alumnos:2])))
							$exApdo:=[Alumnos:2]Apoderado_Cuentas_Número:28
							[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
							$recNum:=Record number:C243([ACT_CuentasCorrientes:175])
							$recNumAlumno:=Record number:C243([Alumnos:2])
							$recNumPersona:=Record number:C243([Personas:7])
							$continue:=ACTcc_ChangeAccountParent 
							If ($continue)
								SAVE RECORD:C53([Alumnos:2])
								READ WRITE:C146([Personas:7])
								QUERY:C277([Personas:7];[Personas:7]No:1=$exApdo)
								[Personas:7]No:1:=[Personas:7]No:1
								SAVE RECORD:C53([Personas:7])
								GOTO RECORD:C242([Personas:7];$recNumPersona)
							End if 
							READ ONLY:C145([ACT_CuentasCorrientes:175])
							GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
							ACTcc_OrderCtasCtes ([ACT_CuentasCorrientes:175]ID:1)
							GOTO RECORD:C242([Personas:7];$recNumPersona)
							READ ONLY:C145([ACT_CuentasCorrientes:175])
							GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
							READ WRITE:C146([Alumnos:2])
							GOTO RECORD:C242([Alumnos:2];$recNumAlumno)
							AL_UpdateArrays (xALP_Hermano;0)
							AL_LoadBrothers 
							AL_UpdateArrays (xALP_Hermano;-2)
						Else 
							$ignore:=CD_Dlog (0;__ ("No fue posible modificar el registro asociado en SchoolTrack.\rPor favor intente más tarde."))
							$continue:=False:C215
						End if 
					End if 
					  //GOTO RECORD([ACT_CuentasCorrientes];$recNumCta)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=al_NumAlumnos{$x})  //AS. 20110725 se agrega para manejar el cambio de apoderado de cuentas.
					[Familia_RelacionesFamiliares:77]ID_Familia:2:=[ACT_CuentasCorrientes:175]ID_Familia:2
					If ($continue)
						Case of 
							: ((bap1=1) & (bap2=1))
								[Alumnos:2]Apoderado_académico_Número:27:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=3
							: (bap1=1)
								[Alumnos:2]Apoderado_académico_Número:27:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=1
							: (bap2=1)
								[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								[Familia_RelacionesFamiliares:77]Apoderado:5:=2
							Else 
								Case of 
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_académico_Número:27) & ([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_Cuentas_Número:28) & (bap1=0) & (bap2=0))
										[Alumnos:2]Apoderado_Cuentas_Número:28:=0
										[Alumnos:2]Apoderado_académico_Número:27:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=0
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_académico_Número:27) & (bap1=0))
										[Alumnos:2]Apoderado_académico_Número:27:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=[Familia_RelacionesFamiliares:77]Apoderado:5-1
									: (([Familia_RelacionesFamiliares:77]ID_Persona:3=[Alumnos:2]Apoderado_Cuentas_Número:28) & (bap2=0))
										[Alumnos:2]Apoderado_Cuentas_Número:28:=0
										[Familia_RelacionesFamiliares:77]Apoderado:5:=[Familia_RelacionesFamiliares:77]Apoderado:5-1
								End case 
						End case 
						$vl_idNewApdo:=[Alumnos:2]Apoderado_Cuentas_Número:28
						SAVE RECORD:C53([Alumnos:2])
						Case of 
							: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=1)
								[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=2)
								[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
						End case 
						SAVE RECORD:C53([Familia:78])
					End if 
					If (Is new record:C668([Familia_RelacionesFamiliares:77]))
						$log:="Creación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+[Personas:7]Apellidos_y_nombres:30+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
					Else 
						$log:="Modificación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+[Personas:7]Apellidos_y_nombres:30+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
					End if 
					SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
					LOG_RegisterEvt ($log)
					
					C_LONGINT:C283($recNumP;$recNumRF)  //para actualizar la condición de apdo de cta y apdo acad de todas las personas
					$recNumP:=Record number:C243([Personas:7])
					$recNumRF:=Record number:C243([Familia_RelacionesFamiliares:77])
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
					KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					KRL_ReloadInReadWriteMode (->[Personas:7])
					FIRST RECORD:C50([Personas:7])
					While (Not:C34(End selection:C36([Personas:7])))
						[Personas:7]No:1:=[Personas:7]No:1
						SAVE RECORD:C53([Personas:7])  //to force trigger execution
						NEXT RECORD:C51([Personas:7])
					End while 
					If ($exApdo#0)
						ACTpp_CalculaNoCargas ($exApdo)
					End if 
					If ($vl_idNewApdo#0)
						ACTpp_CalculaNoCargas ($vl_idNewApdo)
					End if 
					GOTO RECORD:C242([Personas:7];$recNumP)
					GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$recNumRF)
					IT_UThermometer (-2;$proc)
				End for 
			End if 
		: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
			[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
			Case of 
				: ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3)
					[Familia:78]Padre_Número:5:=0
				: ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3)
					[Familia:78]Madre_Número:6:=0
			End case 
			Case of 
				: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=1)
					READ ONLY:C145([Personas:7])
					QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
					[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
				: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=2)
					READ ONLY:C145([Personas:7])
					QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
					[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
			End case 
			SAVE RECORD:C53([Familia:78])
			[Personas:7]No:1:=[Personas:7]No:1
			SAVE RECORD:C53([Personas:7])  //to force trigger execution
	End case 
	ACCEPT:C269
Else 
	BEEP:C151
End if 
