  // [Cursos].Input.Champ1()
  // Por: Alberto Bachler K.: 14-05-14, 19:46:58
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------






C_TEXT:C284($vt_curso;$abrev)
C_BOOLEAN:C305($b_ok)


Case of 
	: (Form event:C388=On Data Change:K2:15)
		If ((Old:C35([Cursos:3]Letra_del_curso:9)#"") & ([Cursos:3]Letra_del_curso:9=""))
			[Cursos:3]Letra_del_curso:9:=Old:C35([Cursos:3]Letra_del_curso:9)
			ModernUI_Notificacion (__ ("La letra de de un curso existente no puede ser dejada en blanco");__ ("Se restableció la letra del curso registrada anteriormente");__ ("Cerrar"))
			
		Else 
			START TRANSACTION:C239
			$b_ok:=True:C214
			$abrev:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura:19)
			$vt_curso:=$abrev+"-"+[Cursos:3]Letra_del_curso:9
			If (Find in array:C230(<>aCursos;$vt_curso)=-1)
				If (([Cursos:3]Letra_del_curso:9#"") & ([Cursos:3]Letra_del_curso:9#Old:C35([Cursos:3]Letra_del_curso:9)))
					If ((Size of array:C274(<>aStdWhNme)>0) | (Size of array:C274(aPAName)>0))
						$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente modificar la letra de este curso?");__ ("");__ ("Si");__ ("No"))
						If ($r=1)
							If (([Cursos:3]Nivel_Numero:7>Nivel_AdmisionDirecta) & ([Cursos:3]Nivel_Numero:7<Nivel_Egresados))
								[Cursos:3]Curso:1:=$abrev+"-"+[Cursos:3]Letra_del_curso:9
							Else 
								BEEP:C151
								[Cursos:3]Nivel_Numero:7:=0
								[Cursos:3]Curso:1:=""
								[Cursos:3]Letra_del_curso:9:=""
								GOTO OBJECT:C206([Cursos:3]Letra_del_curso:9)
								
							End if 
							$cursoAntiguo:=Old:C35([Cursos:3]Curso:1)
							$cursoNuevo:=[Cursos:3]Curso:1
							PUSH RECORD:C176([Cursos:3])
							If ($cursoAntiguo#"")
								$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando el nombre del curso…"))
								If ($b_ok)
									QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$cursoAntiguo)
									If (Records in selection:C76([Asignaturas:18])>0)
										ARRAY TEXT:C222($curso;Records in selection:C76([Asignaturas:18]))
										For ($i;1;Size of array:C274($Curso))
											$curso{$i}:=$cursoNuevo
										End for 
										CREATE SET:C116([Asignaturas:18];"LockedSet")
										UNLOAD RECORD:C212([Asignaturas:18])
										READ WRITE:C146([Asignaturas:18])
										While (Records in set:C195("LockedSet")>0)
											USE SET:C118("lockedSet")
											ARRAY TO SELECTION:C261($curso;[Asignaturas:18]Curso:5)
										End while 
										UNLOAD RECORD:C212([Asignaturas:18])
										READ ONLY:C145([Asignaturas:18])
										
										If (Records in set:C195("LockedSet")>0)
											$b_ok:=False:C215
										End if 
									End if 
								End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;30)
								If ($b_ok)
									QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursoAntiguo)
									If (Records in selection:C76([Alumnos:2])>0)
										SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$id)
										ARRAY TEXT:C222($curso;Records in selection:C76([Alumnos:2]))
										ARRAY TEXT:C222($compIdx;Records in selection:C76([Alumnos:2]))
										For ($i;1;Size of array:C274($Curso))
											$curso{$i}:=$cursoNuevo
										End for 
										CREATE SET:C116([Alumnos:2];"LockedSet")
										UNLOAD RECORD:C212([Alumnos:2])
										READ WRITE:C146([Alumnos:2])
										While (Records in set:C195("LockedSet")>0)
											USE SET:C118("lockedSet")
											ARRAY TO SELECTION:C261($curso;[Alumnos:2]curso:20)
										End while 
										UNLOAD RECORD:C212([Alumnos:2])
										READ ONLY:C145([Alumnos:2])
										If (Records in set:C195("LockedSet")>0)
											$b_ok:=False:C215
										End if 
										$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;60)
									End if 
									If ($b_ok)
										READ WRITE:C146([Alumnos_SintesisAnual:210])
										QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7=$cursoAntiguo;*)
										QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gyear)
										If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
											APPLY TO SELECTION:C70([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7:=$cursoNuevo)
											KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
											If (Records in set:C195("LockedSet")>0)
												$b_ok:=False:C215
											End if 
										End if 
									End if 
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;60)
								End if 
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;100)
								$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
								POP RECORD:C177([Cursos:3])
								$old:=Find in array:C230(<>aCursos;$cursoAntiguo)
								<>aCursos{$old}:=$cursoNuevo
								  //SAVE RECORD([Cursos])
							End if 
							
						Else 
							[Cursos:3]Letra_del_curso:9:=Old:C35([Cursos:3]Letra_del_curso:9)
						End if 
					Else 
						If (([Cursos:3]Nivel_Numero:7>Nivel_AdmisionDirecta) & ([Cursos:3]Nivel_Numero:7<Nivel_Egresados))
							$abrev:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura:19)
							[Cursos:3]Curso:1:=$abrev+"-"+[Cursos:3]Letra_del_curso:9
							
						Else 
							BEEP:C151
							[Cursos:3]Nivel_Numero:7:=0
							[Cursos:3]Curso:1:=""
							[Cursos:3]Letra_del_curso:9:=""
							GOTO OBJECT:C206([Cursos:3]Letra_del_curso:9)
						End if 
						If (Find in array:C230(<>aCursos;[Cursos:3]Curso:1)>0)
							CD_Dlog (0;__ ("Este curso ya existe."))
							[Cursos:3]Nivel_Numero:7:=0
							[Cursos:3]Curso:1:=""
							[Cursos:3]Letra_del_curso:9:=""
							GOTO OBJECT:C206([Cursos:3]Letra_del_curso:9)
						End if 
						RELATE MANY:C262([Cursos:3]Curso:1)
					End if 
				End if 
			Else 
				[Cursos:3]Letra_del_curso:9:=Old:C35([Cursos:3]Letra_del_curso:9)
				CD_Dlog (0;__ ("El curso ")+$vt_curso+__ (" ya existe."))
			End if 
			
			
			If ([Cursos:3]Nombre_Oficial_Curso:15="")
				[Cursos:3]Nombre_Oficial_Curso:15:=[Cursos:3]Curso:1
			End if 
			If ([Cursos:3]Letra_Oficial_del_Curso:18="")
				[Cursos:3]Letra_Oficial_del_Curso:18:=Self:C308->
				[Cursos:3]Nombre_Oficial_Curso:15:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+[Cursos:3]Letra_Oficial_del_Curso:18
			End if 
			
			If ($b_ok)
				SAVE RECORD:C53([Cursos:3])
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
				$el:=Find in array:C230(<>aCursos;[Cursos:3]Curso:1)
				If ($el#-1)
					<>aCursos{$el}:=Old:C35([Cursos:3]Curso:1)
				End if 
				[Cursos:3]Letra_del_curso:9:=Old:C35([Cursos:3]Letra_del_curso:9)
				[Cursos:3]Curso:1:=Old:C35([Cursos:3]Curso:1)
				CD_Dlog (0;__ ("Existen registros en uso. El cambio de letra no se ha efectuado."))
			End if 
		End if 
End case 

