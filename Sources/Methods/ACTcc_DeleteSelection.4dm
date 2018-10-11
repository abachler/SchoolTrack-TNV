//%attributes = {}
  //ACTcc_DeleteSelection

$0:=0
If (USR_checkRights ("D";->[ACT_CuentasCorrientes:175]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información de todas las cuentas seleccionadas?\rSólo serán eliminadas las cuentas inactivas.");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		$r:=CD_Dlog (2;__ ("La eliminación es irreversible.\r ¿Eliminar a todas las cuentas seleccionadas?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=False:C215)
			ARRAY LONGINT:C221($aCtas2Delete;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aCtas2Delete)
			COPY ARRAY:C226($aCtas2Delete;$aCtas2DeleteTemp)
			For ($i;1;Size of array:C274($aCtas2Delete))
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aCtas2Delete{$i})
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					DELETE FROM ARRAY:C228($aCtas2DeleteTemp;Find in array:C230($aCtas2DeleteTemp;$aCtas2Delete{$i});1)
				End if 
			End for 
			If (Size of array:C274($aCtas2Delete)#Size of array:C274($aCtas2DeleteTemp))
				If (Size of array:C274($aCtas2DeleteTemp)>0)
					CD_Dlog (2;__ ("Existen cuentas para las cuales ya se emitieron avisos de cobranza. Dichas cuentas no serán eliminadas."))
				Else 
					CD_Dlog (2;__ ("Las cuentas seleccionadas no pueden ser eliminadas puesto que ya se emitieron aviso de cobranza para ellas."))
				End if 
			End if 
			If (Size of array:C274($aCtas2DeleteTemp)>0)
				CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$aCtas2DeleteTemp)
				OK:=1
				$pID:=IT_UThermometer (1;0;__ ("Eliminando cuentas corrientes..."))
				START TRANSACTION:C239
				$l_eliminados:=1
				If (OK=1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					$l_eliminados:=KRL_DeleteSelection (->[ACT_Documentos_de_Cargo:174])
				End if 
				If (OK=1)
					CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$aCtas2DeleteTemp)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
					If ($l_eliminados=1)
						$l_eliminados:=KRL_DeleteSelection (->[ACT_Cargos:173])
					End if 
				End if 
				If (OK=1)
					CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$aCtas2DeleteTemp)
					If ($l_eliminados=1)
						$l_eliminados:=KRL_DeleteSelection (->[ACT_CuentasCorrientes:175])
					End if 
				End if 
				If ((OK=1) & ($l_eliminados=1))
					VALIDATE TRANSACTION:C240
					$0:=1
				Else 
					CANCEL TRANSACTION:C241
				End if 
				IT_UThermometer (-2;$pID)
			End if 
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 