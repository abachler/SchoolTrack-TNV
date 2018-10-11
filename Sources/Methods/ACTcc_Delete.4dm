//%attributes = {}
  //ACTcc_Delete

$0:=0
If (USR_checkRights ("D";->[ACT_CuentasCorrientes:175]))
	If ([ACT_CuentasCorrientes:175]Estado:4)
		CD_Dlog (2;__ ("Esta cuenta está activa por lo que no puede ser eliminada."))
	Else 
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información de esta cuenta?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$r:=CD_Dlog (2;__ ("La eliminación es irreversible.\r ¿Eliminar la cuenta seleccionada?");__ ("");__ ("No");__ ("Eliminar"))
			If ($r=2)
				OK:=1
				$recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					CD_Dlog (2;__ ("Para esta cuenta ya hay avisos de cobranza emitidos. La cuenta no puede ser eliminada."))
					OK:=0
				End if 
				If (ok=1)
					GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
					$pID:=IT_UThermometer (1;0;__ ("Eliminando cuentas corrientes..."))
					ok:=1
					START TRANSACTION:C239
					$l_eliminados:=1  //20130730 RCH
					If (OK=1)
						KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
						$l_eliminados:=KRL_DeleteSelection (->[ACT_Documentos_de_Cargo:174])
					End if 
					If (OK=1)
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
						KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
						If ($l_eliminados=1)
							$l_eliminados:=KRL_DeleteSelection (->[ACT_Cargos:173])
						End if 
					End if 
					If (OK=1)
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
						If ($l_eliminados=1)
							$l_eliminados:=KRL_DeleteSelection (->[ACT_CuentasCorrientes:175])
						End if 
					End if 
					If ((OK=1) & ($l_eliminados=1))
						VALIDATE TRANSACTION:C240
						$0:=1
					Else 
						CANCEL TRANSACTION:C241
						CD_Dlog (2;__ ("Existen registros en uso. La cuenta no pudo ser eliminada."))
					End if 
					IT_UThermometer (-2;$pID)
				End if 
			End if 
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 