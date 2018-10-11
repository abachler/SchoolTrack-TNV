//%attributes = {}
  //ADTcdd_DeleteSelection
ARRAY LONGINT:C221($noEliminados;0)
$0:=0
$abort:=False:C215
If (USR_checkRights ("D";->[ADT_Candidatos:49]))
	If (Records in selection:C76([ADT_Candidatos:49])>0)
		$r:=CD_Dlog (0;__ ("Los registros serán eliminados definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar los registros seleccionados? (Sólo serán eliminados aquellos candidatos que no tengan una cuenta corriente asociada)");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			$r:=CD_Dlog (0;__ ("La familia de cada candidato será eliminada a menos que tenga otros alumnos asignados. Las relaciones familiares también serán eliminadas a menos que estén relacionadas con otras familias.\r\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				ARRAY LONGINT:C221($aRecNumCdds;0)
				LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$aRecNumCdds;"")
				START TRANSACTION:C239
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminando candidatos..."))
				$iterations:=Size of array:C274($aRecNumCdds)
				For ($y;1;$iterations)
					$eliminar:=True:C214
					If (Not:C34($abort))
						READ WRITE:C146([ADT_Candidatos:49])
						GOTO RECORD:C242([ADT_Candidatos:49];$aRecNumCdds{$y})
						$rnCC:=Find in field:C653([ACT_CuentasCorrientes:175]ID_Alumno:3;[ADT_Candidatos:49]Candidato_numero:1)
						If ($rnCC=-1)
							READ WRITE:C146([Alumnos:2])
							$rnAL:=Find in field:C653([Alumnos:2]numero:1;[ADT_Candidatos:49]Candidato_numero:1)
							If ($rnAL#-1)
								GOTO RECORD:C242([Alumnos:2];$rnAL)
								If (Not:C34(Locked:C147([Alumnos:2])))
									If ([Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack)
										$ok:=ADTcdd_DeleteAlumno 
										If ($ok=1)
											DELETE RECORD:C58([Alumnos:2])
										Else 
											$abort:=True:C214
										End if 
									End if 
								Else 
									$abort:=True:C214
								End if 
							End if 
						Else 
							$eliminar:=False:C215
							APPEND TO ARRAY:C911($noEliminados;[ADT_Candidatos:49]Candidato_numero:1)
						End if 
					End if 
					If ((Not:C34($abort)) & ($eliminar=True:C214))
						READ WRITE:C146([ADT_Entrevistas:121])
						QUERY:C277([ADT_Entrevistas:121];[ADT_Entrevistas:121]ID_familia:5=[ADT_Candidatos:49]Familia_numero:30)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
						QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Familia_numero:30=[ADT_Candidatos:49]Familia_numero:30)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($recs=1)
							[ADT_Entrevistas:121]ID_familia:5:=0
							SAVE RECORD:C53([ADT_Entrevistas:121])
						End if 
						KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
						READ ONLY:C145([Familia:78])
						READ ONLY:C145([Alumnos:2])
						READ ONLY:C145([Familia_RelacionesFamiliares:77])
						READ ONLY:C145([Personas:7])
						$rnFam:=Find in field:C653([Familia:78]Numero:1;[ADT_Candidatos:49]Familia_numero:30)
						$ok:=1
						If ($rnFam#-1)
							GOTO RECORD:C242([Familia:78];$rnFam)
							SET QUERY DESTINATION:C396(Into variable:K19:4;$alumnos)
							QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($alumnos=0)
								QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
								QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#0)
								KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
								ARRAY LONGINT:C221($aPersonas;0)
								LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas;"")
								$ok:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
								If ($ok=1)
									READ WRITE:C146([Familia:78])
									GOTO RECORD:C242([Familia:78];$rnFam)
									$ok:=KRL_DeleteSelection (->[Familia:78])
									KRL_UnloadReadOnly (->[Familia:78])
								End if 
								If ($ok=1)
									READ WRITE:C146([Personas:7])
									For ($u;1;Size of array:C274($aPersonas))
										GOTO RECORD:C242([Personas:7];$aPersonas{$u})
										SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
										SET QUERY LIMIT:C395(1)
										QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
										SET QUERY LIMIT:C395(0)
										SET QUERY DESTINATION:C396(Into current selection:K19:1)
										If ($recs=0)
											DELETE RECORD:C58([Personas:7])
											If (Locked:C147([Personas:7]))
												$u:=Size of array:C274($aPersonas)+1
												$ok:=0
											End if 
										End if 
									End for 
								End if 
							End if 
						End if 
						If ((Not:C34(Locked:C147([ADT_Candidatos:49]))) & ($ok=1))
							DELETE RECORD:C58([ADT_Candidatos:49])
							ADTcdd_UpdatePresentacionAsist 
						Else 
							$abort:=True:C214
						End if 
					Else 
						If ($abort)
							$y:=$iterations+1
						End if 
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/$iterations;__ ("Eliminando candidatos..."))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				If ($abort)
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("En este momento existen registros en uso. La selección no puede ser eliminada."))
				Else 
					VALIDATE TRANSACTION:C240
					$0:=1
					If (Size of array:C274($noEliminados)>0)
						CD_Dlog (0;__ ("Algunos registros no pudieron ser eliminados. Serán listados en el explorador."))
					End if 
				End if 
			End if 
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 