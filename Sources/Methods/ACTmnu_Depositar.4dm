//%attributes = {}
  //ACTmnu_Depositar

If (USR_GetMethodAcces (Current method name:C684))
	C_TEXT:C284($cargarDesde)
	If (vb_RecordInInputForm)
		If (Count parameters:C259=1)
			$cargarDesde:=$1
		End if 
		ACTpp_DepositarCh 
		  //ACTpp_CargaALPPersonas (7)
		If ($cargarDesde="terceros")
			ACTter_PageDocEnCartera 
		Else 
			ACTpp_CargaALPPersonas (7)
		End if 
		AL_SetLine (xALP_DocsenCartera;0)
		ACTpp_HabDesHabAcciones (False:C215)
		
	Else 
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			$encontrados:=BWR_SearchRecords 
			If ($encontrados#-1)
				ARRAY LONGINT:C221($aRecNumsDocCartera;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_en_Cartera:182];$aRecNumsDocCartera;"")
				C_LONGINT:C283($cheques;$letras)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$cheques)
				QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$letras)
				QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If (($cheques>0) & ($letras>0))
					$letraycheque:=CD_Dlog (0;__ ("En la selección de registros tiene Letras y Cheques.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
					If ($letraycheque=1)
						$proceder:=CD_Dlog (0;__ ("El depósito de un documento en cartera es una operación definitiva.\r\r¿Desea proceder?");__ ("");__ ("Si");__ ("No"))
					Else 
						$proceder:=0
					End if 
				Else 
					$proceder:=CD_Dlog (0;__ ("El depósito de un documento en cartera es una operación definitiva.\r\r¿Desea proceder?");__ ("");__ ("Si");__ ("No"))
				End if 
				If ($proceder=1)
					$afecha:=False:C215
					For ($j;1;Size of array:C274($aRecNumsDocCartera))
						GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$aRecNumsDocCartera{$j})
						If ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12>Current date:C33(*))
							$afecha:=True:C214
							$j:=Size of array:C274($aRecNumsDocCartera)+1
						End if 
					End for 
					$DepositaraFecha:=1
					If ($afecha)
						$DepositaraFecha:=CD_Dlog (0;__ ("Existen documentos a fecha en la selección.\r\r¿Desea proseguir con el depósito?");__ ("");__ ("Si");__ ("No"))
					End if 
					If ($DepositaraFecha=1)
						$banco:=""
						$codigo:=""
						$ctacte:=""
						$fechaDeposito:=Current date:C33(*)
						$depositadoPor:=<>tUSR_CurrentUser
						$comprobante:=""
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
							$comprobante:=vtACT_compDeposito
						End if 
						ARRAY TEXT:C222(atACT_CtaColegioCod;0)
						ARRAY TEXT:C222(atACT_CtaColegioBanco;0)
						ARRAY TEXT:C222(atACT_CtaColegioCta;0)
						If ($go)
							
							$vb_mensaje:=False:C215
							For ($i;1;Size of array:C274($aRecNumsDocCartera))
								READ WRITE:C146([ACT_Documentos_en_Cartera:182])
								READ WRITE:C146([ACT_Documentos_de_Pago:176])
								GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$aRecNumsDocCartera{$i})
								QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
								$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
								$lockedPagos:=Locked:C147([ACT_Documentos_de_Pago:176])
								  //$estado:=[ACT_Documentos_de_Pago]Estado
								If (Not:C34(($lockedCartera) | ($lockedPagos)))
									  //If ($estado#"Protestado@")
									If ([ACT_Documentos_de_Pago:176]id_estado:53#-2)
										  //[ACT_Documentos_de_Pago]Estado:="Depositado"
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
										[ACT_Documentos_de_Pago:176]Depositado_no_Comprobante:50:=$comprobante
										  //SAVE RECORD([ACT_Documentos_de_Pago])
										ACTdp_fSave 
										DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
										LOG_RegisterEvt ("Depósito de documento Nº "+[ACT_Documentos_de_Pago:176]NoSerie:12+" del banco "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+".")
									End if 
								Else 
									  //If ($estado#"Protestado@")
									  //$params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera]ID;->$banco;->$codigo;->$ctacte;->$fechaDeposito;->$depositadoPor)
									  //BM_CreateRequest ("ACT_DepositaCheques";$params)
									  //End if 
									$vb_mensaje:=True:C214
								End if 
								KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
								KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
							End for 
							If ($vb_mensaje)
								CD_Dlog (0;__ ("Existían algunos registros seleccionados en uso. Algunos documentos no fueron depositados."))
							End if 
							USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
							BWR_SelectTableData 
						End if 
					End if 
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Seleccione los documentos a depositar."))
		End if 
	End if 
End if 