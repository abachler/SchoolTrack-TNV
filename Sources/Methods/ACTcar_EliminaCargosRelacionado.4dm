//%attributes = {}
C_BOOLEAN:C305($0;$lockedP;$lockedCargo)
C_LONGINT:C283($idCargo;$1;$iddocCargo;$3)
C_POINTER:C301($vy_pointer1;$2)

$idCargo:=$1
$vy_pointer1:=$2

  // Modificado por: Saúl Ponce (27-03-2017) Ticket 178123, aparecía error en compilado al intentar acceder al 3er parámetro. 
  // $iddocCargo:=$3 // este parámetro ya no se utiliza.

If ($idCargo#0)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo)
	ARRAY LONGINT:C221($aIntereses;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aIntereses;"")
	For ($r;1;Size of array:C274($aIntereses))
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$aIntereses{$r})
		
		If (ACTcar_EsCargoEliminable ([ACT_Cargos:173]ID:1))  //(20170426 RCH
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			$lockedP:=False:C215
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum)
			For ($i;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$i})
				$pago:=Find in field:C653([ACT_Pagos:172]ID:1;[ACT_Transacciones:178]ID_Pago:4)
				If ($pago#-1)
					READ WRITE:C146([ACT_Pagos:172])
					GOTO RECORD:C242([ACT_Pagos:172];$pago)
					If (Locked:C147([ACT_Pagos:172]))
						$lockedP:=True:C214
					Else 
						[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
						SAVE RECORD:C53([ACT_Pagos:172])
					End if 
					If ($lockedP)
						$i:=Size of array:C274($al_recNum)
					End if 
				End if 
			End for 
		Else 
			$lockedP:=True:C214
			$lockedCargo:=True:C214
			$r:=Size of array:C274($aIntereses)
		End if 
		
		If (Not:C34($lockedP))
			$lockedCargo:=Locked:C147([ACT_Cargos:173])
			
			If (Not:C34($lockedCargo))
				$idCargo:=[ACT_Cargos:173]ID:1
				$iddocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3  //20170629 RCH
				DELETE RECORD:C58([ACT_Cargos:173])
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$iddocCargo)
				$avisoID:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
				$lockedDC:=Locked:C147([ACT_Documentos_de_Cargo:174])
				SET QUERY DESTINATION:C396(Into variable:K19:4;$cargosEnDoc)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=$iddocCargo)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($cargosEnDoc>0)
					ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
				Else 
					DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
				End if 
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$avisoID)
				$avisoRN:=Record number:C243([ACT_Avisos_de_Cobranza:124])
				$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
				APPEND TO ARRAY:C911($vy_pointer1->;$avisoRN)
				  //ACTac_Recalcular ($avisoRN)
				
				  //por si se elimina un descuento que podria tener un cargo asociado
				  //$lockedCargo:=ACTcar_EliminaCargosRelacionado ($idCargo;$vy_pointer1;$iddocCargo)
				
				  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determinará dentro del método
				$lockedCargo:=ACTcar_EliminaCargosRelacionado ($idCargo;$vy_pointer1)
				
				If ($lockedCargo)
					$r:=Size of array:C274($aIntereses)
				End if 
			Else 
				$r:=Size of array:C274($aIntereses)
			End if 
		Else 
			$r:=Size of array:C274($aIntereses)
		End if 
	End for 
End if 

If (($lockedP) | ($lockedCargo))
	$0:=True:C214
Else 
	$0:=False:C215
End if 