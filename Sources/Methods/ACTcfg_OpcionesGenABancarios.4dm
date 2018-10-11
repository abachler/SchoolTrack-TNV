//%attributes = {}
C_TEXT:C284($1;$vt_accion;$vt_nombrePref)
C_BLOB:C604($xBlob)
C_POINTER:C301($ptr1;$ptr2)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_idApdo;$vl_idModoPago)

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
Case of 
	: ($vt_accion="DeclaraVars")
		C_LONGINT:C283(csACTcfg_ModosPagoXCuenta)
		
	: ($vt_accion="InicializaVars")
		csACTcfg_ModosPagoXCuenta:=0
		
	: ($vt_accion="$vt_nombrePref")
		$ptr1->:="ACT_CFG_Gen_Archivos_Bancarios"
		
	: ($vt_accion="LeeBlob")
		ACTcfg_OpcionesGenABancarios ("DeclaraVars")
		ACTcfg_OpcionesGenABancarios ("InicializaVars")
		ACTcfg_OpcionesGenABancarios ("CreaBlob";->$xBlob)
		ACTcfg_OpcionesGenABancarios ("$vt_nombrePref";->$vt_nombrePref)
		$xBlob:=PREF_fGetBlob (0;$vt_nombrePref;$xBlob)
		ACTcfg_OpcionesGenABancarios ("DesarmaBlob";->$xBlob)
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="DesarmaBlob")
		BLOB_Blob2Vars ($ptr1;0;->csACTcfg_ModosPagoXCuenta)
		
	: ($vt_accion="CreaBlob")
		BLOB_Variables2Blob ($ptr1;0;->csACTcfg_ModosPagoXCuenta)
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_OpcionesGenABancarios ("CreaBlob";->$xBlob)
		ACTcfg_OpcionesGenABancarios ("$vt_nombrePref";->$vt_nombrePref)
		PREF_SetBlob (0;$vt_nombrePref;$xBlob)
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="CopiaModoPago")
		$vl_idModoPago:=$ptr1->
		Case of 
			: ($vl_idModoPago=-9)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_Apellidos:34:=[Personas:7]ACT_Apellido_Paterno_TC:71+" "+[Personas:7]ACT_Apellido_Materno_TC:72)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_banco_emisor:41:=[Personas:7]ACT_Banco_TC:53)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_cod_mandato:42:=[Personas:7]ACT_CodMandatoPAT:63)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_identificador:36:=[Personas:7]ACT_RUTTitular_TC:56)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39:=[Personas:7]ACT_MesVenc_TC:57)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_nombres:35:=[Personas:7]ACT_Nombres_TC:73)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_num_t_c:38:=[Personas:7]ACT_Numero_TC:54)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tarjeta_internacional:43:=[Personas:7]ACT_TCEsInternacional:86)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tipo_tc:37:=[Personas:7]ACT_Tipo_TC:52)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_year_venc:40:=[Personas:7]ACT_AñoVenc_TC:58)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]x_Pass:52:=[Personas:7]ACT_xPass:91)
				
			: ($vl_idModoPago=-10)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_apellidos:44:=[Personas:7]ACT_Apellido_Paterno_Cta:74+" "+[Personas:7]ACT_Apellido_Materno_Cta:75)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_banco_id:48:=[Personas:7]ACT_ID_Banco_Cta:48)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_banco_nombre:47:=[Personas:7]ACT_Nombres_Cta:76)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_codigo_mandato:51:=[Personas:7]ACT_CodMandatoPAC:62)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_identificador:49:=[Personas:7]ACT_RUTTitutal_Cta:50)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_nombres:45:=[Personas:7]ACT_Nombres_Cta:76)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_numero_de_cuenta:50:=[Personas:7]ACT_Numero_Cta:51)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_titular_cuenta:46:=[Personas:7]ACT_Titular_Cta:49)
				
		End case 
		
	: ($vt_accion="ActualizaModoPagoEnCuentas")
		If (csACTcfg_ModosPagoXCuenta=1)
			$vl_idApdo:=$ptr1->
			$vl_idModoPago:=$ptr2->
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$vl_idApdo)
			APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=$vl_idModoPago)
			
			  //If (($vl_idModoPago=-9) | ($vl_idModoPago=-10)) // que hacemos con los rut de tarjeta...
			  //$resp:=CD_Dlog (0;__ ("¿Desea copiar los datos de tarjeta de crédito y cuenta a las cuentas corrientes asociadas?");"";__ ("Si");__ ("No"))
			  //If ($resp=1)
			  //ACTcfg_OpcionesGenABancarios ("CopiaModoPago";->$vl_idModoPago)
			  //End if 
			  //End if 
			LOG_RegisterEvt ("Modo de pago de cuentas corrientes asignado desde el apoderado, para el apoderado "+KRL_GetTextFieldData (->[Personas:7]No:1;->$vl_idApdo;->[Personas:7]Apellidos_y_nombres:30)+" (número:"+String:C10($vl_idApdo)+")")
			KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
		End if 
		
	: ($vt_accion="LimpiaDatosCta")
		C_BLOB:C604($xBlob)
		C_LONGINT:C283($vl_proc)
		$vl_proc:=IT_UThermometer (1;0;"Limpiando cuentas...")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_Apellidos:34:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_banco_emisor:41:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_cod_mandato:42:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_identificador:36:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_nombres:35:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_num_t_c:38:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tarjeta_internacional:43:=False:C215)
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tipo_tc:37:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_year_venc:40:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]x_Pass:52:=$xBlob)
		
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_apellidos:44:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_banco_id:48:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_banco_nombre:47:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_codigo_mandato:51:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_identificador:49:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_nombres:45:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_numero_de_cuenta:50:="")
		APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAC_titular_cuenta:46:="")
		IT_UThermometer (-2;$vl_proc)
		
	: ($vt_accion="CopiaDatosACta")
		If ($ptr1->=1)
			C_LONGINT:C283($resp;$vl_proc)
			$resp:=CD_Dlog (0;__ ("¿Desea copiar los  modos de pagos desde los apoderados a las cuentas corrientes?");"";__ ("Si");__ ("No"))
			If ($resp=1)
				$vl_proc:=IT_UThermometer (1;0;__ ("Copiando formas de pagos..."))
				ARRAY LONGINT:C221($alACT_idCtaCte;0)
				
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Personas:7])
				
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9;>)
				LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$alACT_idCtaCte;"")
				For ($i;1;Size of array:C274($alACT_idCtaCte))
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					GOTO RECORD:C242([ACT_CuentasCorrientes:175];$alACT_idCtaCte{$i})
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=[Personas:7]ACT_id_modo_de_pago:94
					SAVE RECORD:C53([ACT_CuentasCorrientes:175])
					ACTcfg_OpcionesGenABancarios ("CopiaModoPago";->$vl_idModoPago)
					KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				End for 
				IT_UThermometer (-2;$vl_proc)
			Else 
				If (cbFPXDefecto=1)
					$resp:=CD_Dlog (0;__ (__ ("¿Desea asignar el modo de pago por defecto ")+ST_Qte (vt_FormadePagoXDef)+__ (" a todas las Cuentas Corrientes?"));"";__ ("Si");__ ("No"))
					If ($resp=1)
						ACTcfgfdp_OpcionesGenerales ("aplicaATodosFDPXDef")
						LOG_RegisterEvt ("Aplicación de comando Aplicar forma de pago ahora. Modo de pago asignado: "+ST_Qte (vt_FormadePagoXDef)+"2")
					End if 
				End if 
			End if 
		Else 
			vlACT_PageCuentas:=1  // por si se esta en la pestaña antes de deshabilitar esta opcion
			$resp:=CD_Dlog (0;__ ("¿Desea limpiar los datos de info para pagos en cuentas corrientes?");"";__ ("Si");__ ("No"))
			If ($resp=1)
				READ WRITE:C146([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcfg_OpcionesGenABancarios ("LimpiaDatosCta")
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
			End if 
		End if 
End case 