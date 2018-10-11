//%attributes = {}
  //ACTpp_DepositarCh

$line:=AL_GetLine (xALP_DocsenCartera)
$vl_idDocCartera:=aACT_ApdosDCarID{$line}
If (ACTdc_DocumentoNoBloq ("Depositar";->$vl_idDocCartera))
	$proceder:=CD_Dlog (0;__ ("El depósito de un documento en cartera es una operación definitiva. ¿Desea proceder?");__ ("");__ ("Si");__ ("No"))
	If ($proceder=1)
		$DepositaraFecha:=1
		If ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12>Current date:C33(*))
			$DepositaraFecha:=CD_Dlog (0;__ ("El documento está a fecha. ¿Desea proseguir con el depósito?");__ ("");__ ("Si");__ ("No"))
		End if 
		If ($DepositaraFecha=1)
			$banco:=""
			$codigo:=""
			$ctacte:=""
			$fechaDeposito:=Current date:C33(*)
			$depositadoPor:=<>tUSR_CurrentUser
			WDW_OpenDialogInDrawer (->[ACT_Documentos_de_Pago:176];"ElegirCtaDeposito")
			$go:=(ok=1)
			If (ok=1)
				If (vlACT_SelectedCta#-1)
					$codigo:=atACT_CtaColegioCod{vlACT_SelectedCta}
					$banco:=atACT_CtaColegioBanco{vlACT_SelectedCta}
					$ctacte:=atACT_CtaColegioCta{vlACT_SelectedCta}
				End if 
				$fechaDeposito:=vdACT_FechaDeposito
				$depositadoPor:=vtACT_DepositadoPor
			End if 
			ARRAY TEXT:C222(atACT_CtaColegioCod;0)
			ARRAY TEXT:C222(atACT_CtaColegioBanco;0)
			ARRAY TEXT:C222(atACT_CtaColegioCta;0)
			If ($go)
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
				$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
				$lockedDPago:=Locked:C147([ACT_Documentos_de_Pago:176])
				$estado:=[ACT_Documentos_de_Pago:176]Estado:14
				If (Not:C34(($lockedCartera) | ($lockedDPago)))
					  //If ([ACT_Documentos_de_Pago]id_estado#-2)
					$vl_idNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
					If ([ACT_Documentos_de_Pago:176]id_estado:53#$vl_idNulo)
						  //[ACT_Documentos_de_Pago]id_estado:=-11
						[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoDepositado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
						[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
						[ACT_Documentos_de_Pago:176]Depositado:35:=True:C214
						[ACT_Documentos_de_Pago:176]En_cartera:34:=False:C215
						[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=$banco
						[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=$codigo
						[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=$ctacte
						[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=$fechaDeposito
						[ACT_Documentos_de_Pago:176]Depositado_Por:43:=$depositadoPor
						  //SAVE RECORD([ACT_Documentos_de_Pago])
						ACTdp_fSave 
						LOG_RegisterEvt ("Depósito de documento Nº "+[ACT_Documentos_de_Pago:176]NoSerie:12+" del banco "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+".")
						KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
						DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
						KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
					End if 
				Else 
					$vl_idProt:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
					  //If ([ACT_Documentos_de_Pago]id_estado#-2)
					If ([ACT_Documentos_de_Pago:176]id_estado:53#$vl_idProt)
						$params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera:182]ID:1;->$banco;->$codigo;->$ctacte;->$fechaDeposito;->$depositadoPor)
						BM_CreateRequest ("ACT_DepositaCheques";$params)
					End if 
				End if 
			End if 
		End if 
	End if 
Else 
	ACTdc_DocumentoNoBloq ("DepositarMensaje")
End if 
ACTdc_DocumentoNoBloq ("DepositarLiberaRegistros")
REDUCE SELECTION:C351([ACT_Documentos_en_Cartera:182];0)
REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)