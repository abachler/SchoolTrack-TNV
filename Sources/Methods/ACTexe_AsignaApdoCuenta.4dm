//%attributes = {}
  //ACTexe_AsignaApdoCuenta

READ ONLY:C145([ACT_CuentasCorrientes:175])
ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
C_LONGINT:C283($l_indice)
C_LONGINT:C283($l_bloqueado;$l_bloqueadoOrg)
C_LONGINT:C283($l_asignado;$l_resp;$l_proc)
C_TEXT:C284($t_mensaje)

QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
	$l_resp:=CD_Dlog (0;"Esta acción asignará al padre o la madre como apoderado de cuenta solo si el alumno no tiene Apoderado de Cuenta actual."+"\r\r"+"Se intentará asignar el apoderado a todas las Cuentas Corrientes."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
	If ($l_resp=1)
		$l_proc:=IT_UThermometer (1;0;"Asignando Apoderado de Cuenta...")
		LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];aQR_Longint1;"")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Asignando Apoderado de Cuenta...")
		For ($l_indice;1;Size of array:C274(aQR_Longint1))
			START TRANSACTION:C239
			$l_bloqueadoOrg:=$l_bloqueado
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];aQR_Longint1{$l_indice})
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;True:C214)
			If (ok=1)
				READ WRITE:C146([Familia_RelacionesFamiliares:77])
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
				If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
					CREATE SET:C116([Familia_RelacionesFamiliares:77];"setRelaciones")
					QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4=2)  //busco al padre
					If (Records in selection:C76([Familia_RelacionesFamiliares:77])=1)
						If (Not:C34(Locked:C147([Familia_RelacionesFamiliares:77])))
							[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
							SAVE RECORD:C53([Alumnos:2])
							READ WRITE:C146([ACT_CuentasCorrientes:175])
							KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;True:C214)
							If (ok=1)
								[ACT_CuentasCorrientes:175]ID_Apoderado:9:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								SAVE RECORD:C53([ACT_CuentasCorrientes:175])
								$l_asignado:=$l_asignado+1
							Else 
								If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
									$l_bloqueado:=$l_bloqueado+1
								Else 
									
								End if 
							End if 
						Else 
							$l_bloqueado:=$l_bloqueado+1
						End if 
					Else 
						
						USE SET:C118("setRelaciones")
						QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4=1)  //busco madre
						If (Records in selection:C76([Familia_RelacionesFamiliares:77])=1)
							If (Not:C34(Locked:C147([Familia_RelacionesFamiliares:77])))
								[Alumnos:2]Apoderado_Cuentas_Número:28:=[Familia_RelacionesFamiliares:77]ID_Persona:3
								SAVE RECORD:C53([Alumnos:2])
								
								READ WRITE:C146([ACT_CuentasCorrientes:175])
								KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;True:C214)
								If (ok=1)
									[ACT_CuentasCorrientes:175]ID_Apoderado:9:=[Familia_RelacionesFamiliares:77]ID_Persona:3
									SAVE RECORD:C53([ACT_CuentasCorrientes:175])
									
									$l_asignado:=$l_asignado+1
									
								Else 
									If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
										$l_bloqueado:=$l_bloqueado+1
									Else 
										
									End if 
								End if 
							Else 
								$l_bloqueado:=$l_bloqueado+1
							End if 
						Else 
							  //no tiene ni padre ni madre
							APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$l_indice})
						End if 
						
					End if 
					SET_ClearSets ("setRelaciones")
					
				Else 
					  //no tiene relaciones familiares
					APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$l_indice})
				End if 
				
				KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
			Else 
				If (Records in selection:C76([Alumnos:2])>0)
					$l_bloqueado:=$l_bloqueado+1
				End if 
			End if 
			
			KRL_UnloadReadOnly (->[Alumnos:2])
			KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
			
			If ($l_bloqueadoOrg=$l_bloqueado)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274(aQR_Longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		  //repara tipo apoderado
		dbuSTR_ReparaTipoApoderadoRF 
		
		IT_UThermometer (-2;$l_proc)
		
		If ($l_bloqueado=0)
			$t_mensaje:="El proceso fue ejecutado correctamente. De un total de "+String:C10(Size of array:C274(aQR_Longint1))+" alumnos sin apoderado de cuenta, fueron actualizados los apoderados de "+String:C10($l_asignado)+" alumno(s). "+String:C10(Size of array:C274(aQR_Longint2))+" no tenían ni padre ni madre. Estos últimos registros serán cargados en el explorador."
		Else 
			$t_mensaje:="Habían registros en uso durante la ejecución del proceso. El apoderado no fue asignado a todos los alumnos."+"\r\r"+"De un total de "+String:C10(Size of array:C274(aQR_Longint1))+" alumnos sin apoderado de cuenta, fueron actualizados los apoderados de "+String:C10($l_asignado)+" alumno(s). "+String:C10(Size of array:C274(aQR_Longint2))+" no tenían ni padre ni madre. Estos últimos registros serán cargados en el explorador."
		End if 
		
		CD_Dlog (0;$t_mensaje)
		LOG_RegisterEvt ("Asignación de padre o madre como Apoderado de Cuenta. Mensaje: "+$t_mensaje+".")
		
		  //carga panel de alumnos con alumnos que no tienen apoderados de cuenta
		yBWR_currentTable:=->[ACT_CuentasCorrientes:175]
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aQR_Longint2;"")
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		SELECT LIST ITEMS BY POSITION:C381(vlXS_BrowserTab;1)
		
		BWR_PanelSettings 
		BWR_SelectTableData 
		_O_REDRAW LIST:C382(vlXS_BrowserTab)
	End if 
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
Else 
	CD_Dlog (0;"No hay Cuentas Corrientes con id de Apoderado en 0.")
End if 
