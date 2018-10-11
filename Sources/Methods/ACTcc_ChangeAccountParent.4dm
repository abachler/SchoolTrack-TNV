//%attributes = {}
  //ACTcc_ChangeAccountParent

C_BOOLEAN:C305($continue)

  //20120524 RCH Se comenta la sgte linea porque produce problemas de cambio de configuracion...
  //ACTinit_CreateGenerationPrefs ("setPrefAvisos")

If (USR_GetMethodAcces (Current method name:C684;0))
	ARRAY LONGINT:C221(aNuevoIdApdo;0)
	ARRAY LONGINT:C221($al_idsAvisos;0)
	idApdo:=[Alumnos:2]Apoderado_Cuentas_Número:28
	$oldApdo:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
	If (aiACT_ChangeDeuda2NewAPdo=0)
		If ((idApdo#[ACT_CuentasCorrientes:175]ID_Apoderado:9) & ([ACT_CuentasCorrientes:175]ID_Apoderado:9#0))
			START TRANSACTION:C239
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			C_REAL:C285($vr_saldo)
			C_LONGINT:C283($vl_recnum)
			$vl_recnum:=Record number:C243([Personas:7])
			$vr_saldo:=KRL_GetNumericFieldData (->[Personas:7]No:1;->$oldApdo;->[Personas:7]Saldo_Ejercicio:85)
			If ($vl_recnum#-1)
				GOTO RECORD:C242([Personas:7];$vl_recnum)
			End if 
			  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=[ACT_CuentasCorrientes]ID_Apoderado)
			  //KRL_RelateSelection (->[ACT_Transacciones]No_Comprobante;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
			  //SET QUERY DESTINATION(Into variable ;$avisos)
			  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID)
			  //SET QUERY DESTINATION(Into current selection )
			  //If ($avisos#0)
			  //If ($vr_saldo#0)
			
			  //20120807 RCH reviso si hay cargos con saldo asociados a la cuenta para crear el registro de ex apoderado
			C_LONGINT:C283($vl_cargos)
			SET QUERY LIMIT:C395(1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_cargos)
			READ ONLY:C145([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$oldApdo;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			
			If (($vr_saldo#0) & ($vl_cargos>0))
				
				READ WRITE:C146([ACT_Apoderados_de_Cuenta:107])
				QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
				If (Records in selection:C76([ACT_Apoderados_de_Cuenta:107])=0)
					CREATE RECORD:C68([ACT_Apoderados_de_Cuenta:107])
					[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
					[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2:=[ACT_CuentasCorrientes:175]ID:1
					SAVE RECORD:C53([ACT_Apoderados_de_Cuenta:107])
				End if 
			End if 
			READ WRITE:C146([ACT_Cargos:173])
			READ WRITE:C146([ACT_Transacciones:178])
			READ WRITE:C146([ACT_Documentos_de_Cargo:174])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			$lockedTransacciones:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Transacciones:178];->[ACT_Transacciones:178]ID_Apoderado:11;->idApdo)
			$lockedCargos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Cargos:173];->[ACT_Cargos:173]ID_Apoderado:18;->idApdo)
			$lockedDocumentos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_de_Cargo:174];->[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;->idApdo)
			
			
			  //Agrego script para validar la forma de pago y si es PAC o PAT realizar 
			  //preguntar si desean copiar la modalidad de pago
			  //JVP 145506 20160809
			QUERY:C277([Personas:7];[Personas:7]No:1=$oldApdo)
			If ([Personas:7]ACT_id_modo_de_pago:94=-9) | ([Personas:7]ACT_id_modo_de_pago:94=-10)
				$t_mensaje:=""
				$t_mensaje:="\r"+__ ("¿Desea Copiar los datos de la modalidad de pago?")
				$l_resp:=CD_Dlog (0;$t_mensaje;"";__ ("Si");__ ("No"))
				If ($l_resp=1)
					If ([Personas:7]ACT_id_modo_de_pago:94=-9)  //paT
						$l_id_forma_pago:=[Personas:7]ACT_id_modo_de_pago:94
						$t_forma_pago:=[Personas:7]ACT_modo_de_pago_new:95
						$t_tipo_tarjeta:=[Personas:7]ACT_Tipo_TC:52
						$t_apellidopaterno:=[Personas:7]ACT_Apellido_Paterno_TC:71
						$t_apellidomaterno:=[Personas:7]ACT_Apellido_Materno_TC:72
						$t_nombres:=[Personas:7]ACT_Nombres_TC:73
						$t_rut_cta:=[Personas:7]ACT_RUTTitular_TC:56
						$t_bancoemisor:=[Personas:7]ACT_Banco_TC:53
						$t_mandato:=[Personas:7]ACT_CodMandatoPAT:63
						$t_mes:=[Personas:7]ACT_MesVenc_TC:57
						$t_año:=[Personas:7]ACT_AñoVenc_TC:58
						$b_international:=[Personas:7]ACT_TCEsInternacional:86
						$t_numtar:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TC:54)
						$b_tarjeta:=[Personas:7]ACT_xPass:91
						  //$t_numtar:=[Personas]ACT_Numero_TC
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]No:1=idApdo)
						[Personas:7]ACT_id_modo_de_pago:94:=$l_id_forma_pago
						[Personas:7]ACT_modo_de_pago_new:95:=$t_forma_pago
						[Personas:7]ACT_Modo_de_pago:39:=$t_forma_pago
						[Personas:7]ACT_Tipo_TC:52:=$t_tipo_tarjeta
						[Personas:7]ACT_RUTTitular_TC:56:=$t_rut_cta
						[Personas:7]ACT_Apellido_Paterno_TC:71:=$t_apellidopaterno
						[Personas:7]ACT_Apellido_Materno_TC:72:=$t_apellidomaterno
						[Personas:7]ACT_Nombres_TC:73:=$t_nombres
						[Personas:7]ACT_Banco_TC:53:=$t_bancoemisor
						[Personas:7]ACT_CodMandatoPAT:63:=$t_mandato
						[Personas:7]ACT_MesVenc_TC:57:=$t_mes
						[Personas:7]ACT_AñoVenc_TC:58:=$t_año
						[Personas:7]ACT_TCEsInternacional:86:=$b_international
						[Personas:7]ACT_Numero_TC:54:=$t_numtar
						[Personas:7]ACT_xPass:91:=$b_tarjeta
						SAVE RECORD:C53([Personas:7])
					Else 
						$l_id_forma_pago:=[Personas:7]ACT_id_modo_de_pago:94
						$t_forma_pago:=[Personas:7]ACT_modo_de_pago_new:95
						$t_tipo_tarjeta:=[Personas:7]ACT_Tipo_TD:106
						$t_apellidopaterno:=[Personas:7]ACT_Apellido_Paterno_TD:99
						$t_apellidomaterno:=[Personas:7]ACT_Apellido_Materno_TD:98
						$t_nombres:=[Personas:7]ACT_Nombres_TD:103
						$t_rut_cta:=[Personas:7]ACT_RUTTitular_TD:105
						$t_bancoemisor:=[Personas:7]ACT_Banco_TD:101
						$t_mandato:=[Personas:7]ACT_CodMandatoPAC:62
						$t_mes:=[Personas:7]ACT_MesVenc_TD:102
						$t_año:=[Personas:7]ACT_AñoVenc_TD:100
						$b_international:=[Personas:7]ACT_TDesInternacional:108
						$t_numtar:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TD:104)
						$b_tarjeta:=[Personas:7]ACT_xPass_TD:109
						  //$t_numtar:=[Personas]ACT_Numero_TD
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]No:1=idApdo)
						[Personas:7]ACT_id_modo_de_pago:94:=$l_id_forma_pago
						[Personas:7]ACT_modo_de_pago_new:95:=$t_forma_pago
						[Personas:7]ACT_Modo_de_pago:39:=$t_forma_pago
						[Personas:7]ACT_Tipo_TD:106:=$t_tipo_tarjeta
						[Personas:7]ACT_RUTTitular_TD:105:=$t_rut_cta
						[Personas:7]ACT_Apellido_Paterno_TD:99:=$t_apellidopaterno
						[Personas:7]ACT_Apellido_Materno_TD:98:=$t_apellidomaterno
						[Personas:7]ACT_Nombres_TD:103:=$t_nombres
						[Personas:7]ACT_Banco_TD:101:=$t_bancoemisor
						[Personas:7]ACT_CodMandatoPAC:62:=$t_mandato
						[Personas:7]ACT_MesVenc_TD:102:=$t_mes
						[Personas:7]ACT_AñoVenc_TD:100:=$t_año
						[Personas:7]ACT_TDesInternacional:108:=$b_international
						[Personas:7]ACT_Numero_TD:104:=$t_numtar
						[Personas:7]ACT_xPass_TD:109:=$b_tarjeta
						SAVE RECORD:C53([Personas:7])
					End if 
				End if 
			End if 
			
			
			
			
			
			READ WRITE:C146([ACT_Apoderados_de_Cuenta:107])
			QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=idApdo;*)
			QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
			DELETE RECORD:C58([ACT_Apoderados_de_Cuenta:107])
			$lockedApdoCta:=Locked:C147([ACT_Apoderados_de_Cuenta:107])
			KRL_UnloadReadOnly (->[ACT_Apoderados_de_Cuenta:107])
			If (($lockedCargos=0) & ($lockedDocumentos=0) & ($lockedTransacciones=0) & (Not:C34($lockedApdoCta)))
				BM_CreateRequest ("ACT_Calcula_Montos_Ejercicio";String:C10([ACT_CuentasCorrientes:175]ID:1))
				BM_CreateRequest ("ACT_RecalculaCargas";String:C10($oldApdo))
				BM_CreateRequest ("ACT_RecalculaCargas";String:C10(idApdo))
				VALIDATE TRANSACTION:C240
				$0:=True:C214
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("En este momento hay registros en uso. Intente cambiar el apoderado de cuentas en otro momento."))
				$0:=False:C215
			End if 
		Else 
			$0:=True:C214
		End if 
		AT_Initialize (->aNuevoIdApdo)
	Else 
		If ((idApdo#[ACT_CuentasCorrientes:175]ID_Apoderado:9) & ([ACT_CuentasCorrientes:175]ID_Apoderado:9#0))
			  //Agrego script para validar la forma de pago y si es PAC o PAT realizar 
			  //preguntar si desean copiar la modalidad de pago
			  //JVP 145506 20160809
			QUERY:C277([Personas:7];[Personas:7]No:1=$oldApdo)
			If ([Personas:7]ACT_id_modo_de_pago:94=-9) | ([Personas:7]ACT_id_modo_de_pago:94=-10)
				$t_mensaje:=""
				$t_mensaje:="\r"+__ ("¿Desea Copiar los datos de la modalidad de pago?")
				$l_resp:=CD_Dlog (0;$t_mensaje;"";__ ("Si");__ ("No"))
				If ($l_resp=1)
					If ([Personas:7]ACT_id_modo_de_pago:94=-9)  //paT
						$l_id_forma_pago:=[Personas:7]ACT_id_modo_de_pago:94
						$t_forma_pago:=[Personas:7]ACT_modo_de_pago_new:95
						$t_tipo_tarjeta:=[Personas:7]ACT_Tipo_TC:52
						$t_apellidopaterno:=[Personas:7]ACT_Apellido_Paterno_TC:71
						$t_apellidomaterno:=[Personas:7]ACT_Apellido_Materno_TC:72
						$t_nombres:=[Personas:7]ACT_Nombres_TC:73
						$t_rut_cta:=[Personas:7]ACT_RUTTitular_TC:56
						$t_bancoemisor:=[Personas:7]ACT_Banco_TC:53
						$t_mandato:=[Personas:7]ACT_CodMandatoPAT:63
						$t_mes:=[Personas:7]ACT_MesVenc_TC:57
						$t_año:=[Personas:7]ACT_AñoVenc_TC:58
						$b_international:=[Personas:7]ACT_TCEsInternacional:86
						$t_numtar:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TC:54)
						$b_tarjeta:=[Personas:7]ACT_xPass:91
						  //$t_numtar:=[Personas]ACT_Numero_TC
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]No:1=idApdo)
						[Personas:7]ACT_id_modo_de_pago:94:=$l_id_forma_pago
						[Personas:7]ACT_modo_de_pago_new:95:=$t_forma_pago
						[Personas:7]ACT_Modo_de_pago:39:=$t_forma_pago
						[Personas:7]ACT_Tipo_TC:52:=$t_tipo_tarjeta
						[Personas:7]ACT_RUTTitular_TC:56:=$t_rut_cta
						[Personas:7]ACT_Apellido_Paterno_TC:71:=$t_apellidopaterno
						[Personas:7]ACT_Apellido_Materno_TC:72:=$t_apellidomaterno
						[Personas:7]ACT_Nombres_TC:73:=$t_nombres
						[Personas:7]ACT_Banco_TC:53:=$t_bancoemisor
						[Personas:7]ACT_CodMandatoPAT:63:=$t_mandato
						[Personas:7]ACT_MesVenc_TC:57:=$t_mes
						[Personas:7]ACT_AñoVenc_TC:58:=$t_año
						[Personas:7]ACT_TCEsInternacional:86:=$b_international
						[Personas:7]ACT_Numero_TC:54:=$t_numtar
						[Personas:7]ACT_xPass:91:=$b_tarjeta
						SAVE RECORD:C53([Personas:7])
					Else 
						$l_id_forma_pago:=[Personas:7]ACT_id_modo_de_pago:94
						$t_forma_pago:=[Personas:7]ACT_modo_de_pago_new:95
						$t_tipo_tarjeta:=[Personas:7]ACT_Tipo_TD:106
						$t_apellidopaterno:=[Personas:7]ACT_Apellido_Paterno_TD:99
						$t_apellidomaterno:=[Personas:7]ACT_Apellido_Materno_TD:98
						$t_nombres:=[Personas:7]ACT_Nombres_TD:103
						$t_rut_cta:=[Personas:7]ACT_RUTTitular_TD:105
						$t_bancoemisor:=[Personas:7]ACT_Banco_TD:101
						$t_mandato:=[Personas:7]ACT_CodMandatoPAC:62
						$t_mes:=[Personas:7]ACT_MesVenc_TD:102
						$t_año:=[Personas:7]ACT_AñoVenc_TD:100
						$b_international:=[Personas:7]ACT_TDesInternacional:108
						$t_numtar:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TD:104)
						$b_tarjeta:=[Personas:7]ACT_xPass_TD:109
						  //$t_numtar:=[Personas]ACT_Numero_TD
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]No:1=idApdo)
						[Personas:7]ACT_id_modo_de_pago:94:=$l_id_forma_pago
						[Personas:7]ACT_modo_de_pago_new:95:=$t_forma_pago
						[Personas:7]ACT_Modo_de_pago:39:=$t_forma_pago
						[Personas:7]ACT_Tipo_TD:106:=$t_tipo_tarjeta
						[Personas:7]ACT_RUTTitular_TD:105:=$t_rut_cta
						[Personas:7]ACT_Apellido_Paterno_TD:99:=$t_apellidopaterno
						[Personas:7]ACT_Apellido_Materno_TD:98:=$t_apellidomaterno
						[Personas:7]ACT_Nombres_TD:103:=$t_nombres
						[Personas:7]ACT_Banco_TD:101:=$t_bancoemisor
						[Personas:7]ACT_CodMandatoPAC:62:=$t_mandato
						[Personas:7]ACT_MesVenc_TD:102:=$t_mes
						[Personas:7]ACT_AñoVenc_TD:100:=$t_año
						[Personas:7]ACT_TDesInternacional:108:=$b_international
						[Personas:7]ACT_Numero_TD:104:=$t_numtar
						[Personas:7]ACT_xPass_TD:109:=$b_tarjeta
						SAVE RECORD:C53([Personas:7])
					End if 
				End if 
			End if 
			
			
			
			
			
			
			$continue:=True:C214
			START TRANSACTION:C239
			SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
			SET QUERY LIMIT:C395(2)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
			SET QUERY LIMIT:C395(0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$lockedPagos:=0
			$lockedDocPago:=0
			$lockedDocCartera:=0
			If ($recs=2)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
				SET QUERY LIMIT:C395(1)
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
				SET QUERY LIMIT:C395(0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($recs=1)
					CD_Dlog (0;__ ("Los pagos con saldo a favor de este apoderado no pueden ser traspasados hasta que deje de ser apoderado de cuentas."))
				End if 
			Else 
				READ WRITE:C146([ACT_Pagos:172])
				READ WRITE:C146([ACT_Documentos_de_Pago:176])
				READ WRITE:C146([ACT_Documentos_en_Cartera:182])
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
				KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
				KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]ID:1;"")
				$lockedPagos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Pagos:172];->[ACT_Pagos:172]ID_Apoderado:3;->idApdo)
				$lockedDocPago:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_de_Pago:176];->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;->idApdo)
				$lockedDocCartera:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_en_Cartera:182];->[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;->idApdo)
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
				KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
				AT_Initialize (->aNuevoIdApdo)
			End if 
			If (($lockedPagos>0) | ($lockedDocPago>0) | ($lockedDocCartera>0))
				$continue:=False:C215
			Else 
				ARRAY LONGINT:C221($aAvisosconSaldo;0)
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				  //***** cuando habian avisos para un apoderado y estaba emitido por cuenta, se pasaba todo para el nuevo apoderado no solo lo de la cuenta seleccionada *****
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_avisosPorCTa)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_CuentasCorrientes:175]ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_avisosPorCTa>0)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_CuentasCorrientes:175]ID:1)
				End if 
				  //***** cuando habian avisos para un apoderado y estaba emitido por cuenta, se pasaba todo para el nuevo apoderado no solo lo de la cuenta seleccionada *****
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;>)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aAvisosconSaldo;"")
				If (Size of array:C274($aAvisosconSaldo)>3)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Traspasando deuda..."))
				End if 
				For ($i;1;Size of array:C274($aAvisosconSaldo))
					READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
					READ WRITE:C146([ACT_Transacciones:178])
					READ WRITE:C146([ACT_Cargos:173])
					READ WRITE:C146([ACT_Documentos_de_Cargo:174])
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aAvisosconSaldo{$i})
					If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
						[ACT_Avisos_de_Cobranza:124]Observaciones:15:="Modificado por el sistema por cambio de apoderado de cuentas con traspaso de deud"+"a."
						SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=[ACT_CuentasCorrientes:175]ID:1)
						$lockedAvisos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Avisos_de_Cobranza:124];->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->idApdo)
						$lockedTransacciones:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Transacciones:178];->[ACT_Transacciones:178]ID_Apoderado:11;->idApdo)
						$lockedCargos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Cargos:173];->[ACT_Cargos:173]ID_Apoderado:18;->idApdo)
						$lockedDocumentos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_de_Cargo:174];->[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;->idApdo)
						$rnCta:=Record number:C243([ACT_CuentasCorrientes:175])
						ARRAY LONGINT:C221($aAvisos;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aAvisos;"")
						For ($o;1;Size of array:C274($aAvisos))
							ACTac_Prepagar ($aAvisos{$o})
						End for 
						READ WRITE:C146([ACT_CuentasCorrientes:175])
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rnCta)
						KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						KRL_UnloadReadOnly (->[ACT_Cargos:173])
						KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
						If (($lockedAvisos>0) | ($lockedTransacciones>0) | ($lockedCargos>0) | ($lockedDocumentos>0))
							$i:=Size of array:C274($aAvisosconSaldo)+1
							$continue:=False:C215
						End if 
					Else 
						$date:=[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4
						$fechaVencimiento:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
						$fechaPago2:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18
						$fechaPago3:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19
						$fechaPago4:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20
						$month:=[ACT_Avisos_de_Cobranza:124]Mes:6
						$year:=[ACT_Avisos_de_Cobranza:124]Agno:7
						$idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
						$rnAvisoViejo:=Record number:C243([ACT_Avisos_de_Cobranza:124])
						$modoCreacionACViejo:=[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24
						
						If (bAvisoAlumno=1)
							
							CREATE RECORD:C68([ACT_Avisos_de_Cobranza:124])
							[ACT_Avisos_de_Cobranza:124]CreadoPor:29:=<>tUSR_CurrentUser
							[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24:=$modoCreacionACViejo
							[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							$newAvisoID:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$date
							[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$fechaVencimiento
							[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18:=$fechaPago2
							[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19:=$fechaPago3
							[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20:=$fechaPago4
							[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3:=idApdo
							[ACT_Avisos_de_Cobranza:124]Observaciones:15:="Creado por el sistema por cambio de apoderado de cuentas con traspaso de deuda."
							[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=[ACT_CuentasCorrientes:175]ID:1
							[ACT_Avisos_de_Cobranza:124]Mes:6:=$month
							[ACT_Avisos_de_Cobranza:124]Agno:7:=$year
							[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio
							ACTac_ActualizaNombre ("AsignaValorACampo")
							SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							
						Else 
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=idApdo;*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=$month;*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$year)
							
							If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
								CREATE RECORD:C68([ACT_Avisos_de_Cobranza:124])
								[ACT_Avisos_de_Cobranza:124]CreadoPor:29:=<>tUSR_CurrentUser
								[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24:=$modoCreacionACViejo
								[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
								$newAvisoID:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$date
								[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$fechaVencimiento
								[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18:=$fechaPago2
								[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19:=$fechaPago3
								[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20:=$fechaPago4
								[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3:=idApdo
								[ACT_Avisos_de_Cobranza:124]Observaciones:15:="Creado por el sistema por cambio de apoderado de cuentas con traspaso de deuda."
								[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=0
								[ACT_Avisos_de_Cobranza:124]Mes:6:=$month
								[ACT_Avisos_de_Cobranza:124]Agno:7:=$year
								[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio
								ACTac_ActualizaNombre ("AsignaValorACampo")
								SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							Else 
								$newAvisoID:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							End if 
							
						End if 
						
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$idAviso;*)
						QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
						KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						
						APPLY TO SELECTION:C70([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$newAvisoID)
						$lockedDocs4IDAviso:=Records in set:C195("lockedSet")
						APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10:=$newAvisoID)
						$lockedTrans4IDAviso:=Records in set:C195("lockedSet")
						$rnAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
						$rnCta:=Record number:C243([ACT_CuentasCorrientes:175])
						$id_avisoNuevo:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
						ACTac_Recalcular ($rnAviso)
						ACTac_Recalcular ($rnAvisoViejo)
						APPEND TO ARRAY:C911($al_idsAvisos;$id_avisoNuevo)
						APPEND TO ARRAY:C911($al_idsAvisos;$idAviso)
						
						READ WRITE:C146([ACT_CuentasCorrientes:175])
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rnCta)
						READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
						KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$rnAviso)
						READ WRITE:C146([ACT_Cargos:173])
						READ WRITE:C146([ACT_Transacciones:178])
						READ WRITE:C146([ACT_Documentos_de_Cargo:174])
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$newAvisoID;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=[ACT_CuentasCorrientes:175]ID:1)
						$lockedTransacciones:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Transacciones:178];->[ACT_Transacciones:178]ID_Apoderado:11;->idApdo)
						$lockedCargos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Cargos:173];->[ACT_Cargos:173]ID_Apoderado:18;->idApdo)
						$lockedDocumentos:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_de_Cargo:174];->[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;->idApdo)
						READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
						KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$rnAviso)
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
						$lockedAvisoNew:=False:C215
						$lockedAvisoOld:=False:C215
						If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
							DELETE RECORD:C58([ACT_Avisos_de_Cobranza:124])
							$lockedAvisoNew:=Locked:C147([ACT_Avisos_de_Cobranza:124])
						Else 
							  // 20120320 AS  cuando ya estaba eliminado el Aviso de cobranza se generaba error.
							$vb_go:=KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$rnAviso)
							If ($vb_go)
								ACTac_Prepagar ($rnAviso)
							End if 
							READ WRITE:C146([ACT_CuentasCorrientes:175])
							GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rnCta)
						End if 
						KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$rnAvisoViejo)
						If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
							[ACT_Avisos_de_Cobranza:124]Observaciones:15:="Modificado por el sistema por cambio de apoderado de cuentas con traspaso de deud"+"a."
							SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
								DELETE RECORD:C58([ACT_Avisos_de_Cobranza:124])
								$lockedAvisoOld:=Locked:C147([ACT_Avisos_de_Cobranza:124])
							End if 
						End if 
						  //20110825 RCH actualizara posibles referencias que existan
						$vl_recCargosT:=ACTcfg_OpcionesRecargosAut ("ValidaReferenciasCambioApdo";->$newAvisoID)
						If (($lockedDocs4IDAviso>0) | ($lockedTrans4IDAviso>0) | ($lockedTransacciones>0) | ($lockedCargos>0) | ($lockedDocumentos>0) | ($lockedAvisoNew) | ($lockedAvisoOld) | ($vl_recCargosT>0))
							  //If (($lockedDocs4IDAviso>0) | ($lockedTrans4IDAviso>0) | ($lockedTransacciones>0) | ($lockedCargos>0) | ($lockedDocumentos>0) | ($lockedAvisoNew) | ($lockedAvisoOld))
							$i:=Size of array:C274($aAvisosconSaldo)+1
							$continue:=False:C215
						End if 
					End if 
					KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
					KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
					If (Size of array:C274($aAvisosconSaldo)>3)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aAvisosconSaldo);__ ("Traspasando deuda..."))
					End if 
				End for 
				If (Size of array:C274($aAvisosconSaldo)>3)
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				End if 
			End if 
			If ($continue)
				READ WRITE:C146([ACT_Cargos:173])
				READ WRITE:C146([ACT_Transacciones:178])
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				$lockedTransP:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Transacciones:178];->[ACT_Transacciones:178]ID_Apoderado:11;->idApdo)
				$lockedCargosP:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Cargos:173];->[ACT_Cargos:173]ID_Apoderado:18;->idApdo)
				$lockedDocCargosP:=ACTcc_AsignNewIDApdo (->aNuevoIdApdo;->[ACT_Documentos_de_Cargo:174];->[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;->idApdo)
				
				READ WRITE:C146([ACT_Apoderados_de_Cuenta:107])
				QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=idApdo;*)
				QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
				DELETE RECORD:C58([ACT_Apoderados_de_Cuenta:107])
				$lockedApdoCta:=Locked:C147([ACT_Apoderados_de_Cuenta:107])
				KRL_UnloadReadOnly (->[ACT_Apoderados_de_Cuenta:107])
				KRL_UnloadReadOnly (->[ACT_Transacciones:178])
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
				If (($lockedCargosP=0) & ($lockedTransP=0) & ($lockedDocCargosP=0) & (Not:C34($lockedApdoCta)))
					BM_CreateRequest ("ACT_Calcula_Montos_Ejercicio";String:C10([ACT_CuentasCorrientes:175]ID:1))
					BM_CreateRequest ("ACT_RecalculaCargas";String:C10($oldApdo))
					BM_CreateRequest ("ACT_RecalculaCargas";String:C10(idApdo))
					VALIDATE TRANSACTION:C240
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_idsAvisos;"")
					ACTmnu_RecalcularSaldosAvisos (->$al_idsAvisos)
					$0:=True:C214
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("En este momento hay registros en uso. Intente cambiar el apoderado de cuentas en otro momento."))
					$0:=False:C215
				End if 
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("En este momento hay registros en uso. Intente cambiar el apoderado de cuentas en otro momento."))
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado a cambiar el apoderado de cuentas de una cuenta corriente."))
	$0:=False:C215
End if 