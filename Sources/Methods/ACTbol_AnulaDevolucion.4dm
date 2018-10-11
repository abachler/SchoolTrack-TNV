//%attributes = {}
  //ACTbol_AnulaDevolucion

ARRAY LONGINT:C221($al_idsCargos;0)
ARRAY LONGINT:C221($al_recNumPagos;0)

ARRAY LONGINT:C221($alACT_RecNumPagos;0)
ARRAY REAL:C219($arACT_SaldoPagos;0)

COPY ARRAY:C226($1->;$al_recNumPagos)
COPY ARRAY:C226($2->;$al_idsCargos)

$vb_salir:=False:C215
For ($y;1;Size of array:C274($al_recNumPagos))
	READ WRITE:C146([ACT_Pagos:172])
	GOTO RECORD:C242([ACT_Pagos:172];$al_recNumPagos{$y})
	If (Locked:C147([ACT_Pagos:172]))
		$vb_salir:=True:C214
		$y:=Size of array:C274($al_recNumPagos)
	End if 
End for 

If (Not:C34($vb_salir))
	ARRAY LONGINT:C221($al_noDctoAsociado;0)
	$cb_EliminarPagosAsociados:=cb_EliminarPagosAsociados
	cb_EliminarPagosAsociados:=1
	vbACT_SaltarValidacion:=True:C214
	For ($y;1;Size of array:C274($al_recNumPagos))
		READ WRITE:C146([ACT_Pagos:172])
		GOTO RECORD:C242([ACT_Pagos:172];$al_recNumPagos{$y})
		$vr_monto:=[ACT_Pagos:172]Monto_Pagado:5
		READ ONLY:C145([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
		DISTINCT VALUES:C339([ACT_Transacciones:178]No_Boleta:9;$al_noDctoAsociado)
		If (Size of array:C274($al_noDctoAsociado)>0)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=$al_noDctoAsociado{1})
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			If (Records in selection:C76([ACT_Pagos:172])>0)
				LOAD RECORD:C52([ACT_Pagos:172])
				If (Not:C34(Locked:C147([ACT_Pagos:172])))
					If (Find in array:C230($alACT_RecNumPagos;Record number:C243([ACT_Pagos:172]))=-1)
						APPEND TO ARRAY:C911($alACT_RecNumPagos;Record number:C243([ACT_Pagos:172]))
						APPEND TO ARRAY:C911($arACT_SaldoPagos;$vr_monto)
					End if 
					  //[ACT_Pagos]Saldo:=[ACT_Pagos]Saldo+$vr_monto
					  //SAVE RECORD([ACT_Pagos])
				Else 
					$vb_salir:=True:C214
					$y:=Size of array:C274($al_recNumPagos)
				End if 
			End if 
			If (Not:C34($vb_salir))
				vbACT_noPrepagar:=True:C214
				  //20130904 RCH NO se recibia retorno por si la transaccion debia ser abortada...
				  //ACTpgs_AnulaPago ($al_recNumPagos{$y})
				$vb_salir:=(ACTpgs_AnulaPago ($al_recNumPagos{$y})=0)
				vbACT_noPrepagar:=False:C215
			End if 
		Else 
			$vb_salir:=True:C214
			$y:=Size of array:C274($al_recNumPagos)
		End if 
	End for 
	If (Not:C34($vb_salir))
		vbACT_SaltarValidacion:=False:C215
		cb_EliminarPagosAsociados:=$cb_EliminarPagosAsociados
		
		ARRAY LONGINT:C221($al_idsDocCargo;0)
		ARRAY LONGINT:C221($al_idsAvisos;0)
		For ($y;1;Size of array:C274($al_idsCargos))
			READ WRITE:C146([ACT_Cargos:173])
			If (Application version:C493>="11@")
				vb_Modificado_4Dv11:=True:C214
				$index:=Find in field:C653([ACT_Cargos:173]ID:1;$al_idsCargos{$y})
			Else 
				  //$index:=Find in field([ACT_Cargos]ID;$al_idsCargos{$y})
			End if 
			If ($index#-1)
				GOTO RECORD:C242([ACT_Cargos:173];$index)
				APPEND TO ARRAY:C911($al_idsDocCargo;[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				DELETE RECORD:C58([ACT_Cargos:173])
			End if 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End for 
		
		For ($y;1;Size of array:C274($al_idsDocCargo))
			If (Application version:C493>="11@")
				vb_Modificado_4Dv11:=True:C214
				$index:=Find in field:C653([ACT_Documentos_de_Cargo:174]ID_Documento:1;$al_idsDocCargo{$y})
			Else 
				  //$index:=Find in field([ACT_Documentos_de_Cargo]ID_Documento;$al_idsDocCargo{$y})
			End if 
			If ($index#-1)
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$index)
				APPEND TO ARRAY:C911($al_idsAvisos;[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
			End if 
		End for 
		
		For ($y;1;Size of array:C274($al_idsAvisos))
			If (Application version:C493>="11@")
				vb_Modificado_4Dv11:=True:C214
				$index:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos{$y})
			Else 
				  //$index:=Find in field([ACT_Avisos_de_Cobranza]ID_Aviso;$al_idsAvisos{$y})
			End if 
			If ($index#-1)
				READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
				GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$index)
				ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]))
				KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
			End if 
		End for 
		
		For ($i;1;Size of array:C274($alACT_RecNumPagos))
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$alACT_RecNumPagos{$i})
			[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+$arACT_SaldoPagos{$i}
			SAVE RECORD:C53([ACT_Pagos:172])
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
		End for 
	End if 
End if 
$0:=$vb_salir
