//%attributes = {}
  //ACTexe_CopiaMailPersonal2DTE
If (USR_GetMethodAcces (Current method name:C684))
	$r:=CD_Dlog (0;__ ("Este comando escribirá la información de los correos electrónicos para DTE con los correos electrónicos personales de todos los Apoderados de Cuenta y Terceros. Además marcará al Apoderado y Tercero para enviar los DTE por mail.")+"\r\r"+__ ("¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		  //con bloqueo de teclas activado y shift presionado se reemplaza todo. De lo contrario solo se escribe si el campo está vacío
		IT_MODIFIERS 
		READ ONLY:C145([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214;*)
		QUERY:C277([Personas:7]; & ;[Personas:7]eMail:34#"")
		
		C_LONGINT:C283($l_locked)
		ARRAY LONGINT:C221($alACT_recNumPersonas;0)
		LONGINT ARRAY FROM SELECTION:C647([Personas:7];$alACT_recNumPersonas;"")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando información de cuentas de correo para apoderados..."))
		For ($l_indice;1;Size of array:C274($alACT_recNumPersonas))
			READ WRITE:C146([Personas:7])
			GOTO RECORD:C242([Personas:7];$alACT_recNumPersonas{$l_indice})
			If (Not:C34(Locked:C147([Personas:7])))
				[Personas:7]ACT_DTE_Enviar_Mail:110:=True:C214
				If (<>CapsLock & <>Shift)
					[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111:=ACTdte_VerificaEmail ([Personas:7]eMail:34;False:C215)
				Else 
					If ([Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111="")
						[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111:=ACTdte_VerificaEmail ([Personas:7]eMail:34;False:C215)
					End if 
				End if 
				SAVE RECORD:C53([Personas:7])
			Else 
				$l_locked:=$l_locked+1
			End if 
			KRL_UnloadReadOnly (->[Personas:7])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($alACT_recNumPersonas))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		READ ONLY:C145([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]EMail:13#"")
		
		ARRAY LONGINT:C221($alACT_recNum;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$alACT_recNum;"")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando información de cuentas de correo para terceros..."))
		For ($l_indice;1;Size of array:C274($alACT_recNum))
			READ WRITE:C146([ACT_Terceros:138])
			GOTO RECORD:C242([ACT_Terceros:138];$alACT_recNum{$l_indice})
			If (Not:C34(Locked:C147([ACT_Terceros:138])))
				[ACT_Terceros:138]DTE_enviar_por_mail:74:=True:C214
				If (<>CapsLock & <>Shift)
					[ACT_Terceros:138]DTE_email_envio_dte:75:=ACTdte_VerificaEmail ([ACT_Terceros:138]EMail:13;False:C215)
				Else 
					If ([ACT_Terceros:138]DTE_email_envio_dte:75="")
						[ACT_Terceros:138]DTE_email_envio_dte:75:=ACTdte_VerificaEmail ([ACT_Terceros:138]EMail:13;False:C215)
					End if 
				End if 
			Else 
				$l_locked:=$l_locked+1
			End if 
			SAVE RECORD:C53([ACT_Terceros:138])
			KRL_UnloadReadOnly (->[ACT_Terceros:138])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($alACT_recNum))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		If ($l_locked=0)
			CD_Dlog (0;"Los datos fueron copiados exitósamente.")
		Else 
			CD_Dlog (0;"Algunos correos no pudieron ser actualizados debido a que habían registros en uso durante el proceso.")
		End if 
		LOG_RegisterEvt ("Copia de datos de correos electrónicos desde correo personal a correo DTE.")
	End if 
	
End if 