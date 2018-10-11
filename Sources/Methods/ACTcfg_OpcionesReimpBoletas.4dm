//%attributes = {}
  //ACTcfg_OpcionesReimpBoletas

C_TEXT:C284($vt_accion;$1)
C_BOOLEAN:C305($vb_limpiar)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="BuscaItemsADesplegar")
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACTcfg_SelectedItemName)
		C_LONGINT:C283(vlACTcfg_SelectedItemId;cbMultaXReimprimir;btn_MultaProtFija;btn_MultaProtPorc;cbMultaPermiteMod)
		C_REAL:C285(vr_PctMontoMulta)
		ARRAY LONGINT:C221(al_IdsItems;0)
		ARRAY TEXT:C222(at_GlosasItems;0)
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesReimpBoletas ("DeclaraVars")
		cbMultaXReimprimir:=0
		btn_MultaProtFija:=0
		btn_MultaProtPorc:=0
		vr_PctMontoMulta:=0
		vlACTcfg_SelectedItemId:=0
		cbMultaPermiteMod:=0
		vtACTcfg_SelectedItemName:=""
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_ReimpresionBoletas")
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_ReimpresionBoletas")
		
	: ($vt_accion="CargaDatosRecargo")
		C_LONGINT:C283(vlACT_idItemMulta)
		C_REAL:C285(vrACT_MontoMulta;vrACT_MontoMultaOrig)
		vlACT_idItemMulta:=0
		vrACT_MontoMulta:=0
		vrACT_MontoMultaOrig:=0
		If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
			ACTcfg_OpcionesReimpBoletas ("LeeBlob")
			If (cbMultaXReimprimir=1)
				If (vlACTcfg_SelectedItemId#0)
					If ((btn_MultaProtFija#0) | (btn_MultaProtPorc#0))
						REDUCE SELECTION:C351([xxACT_Items:179];0)
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemId)
						If (Records in selection:C76([xxACT_Items:179])=1)
							vlACT_idItemMulta:=[xxACT_Items:179]ID:1
							Case of 
								: (btn_MultaProtFija=1)
									vrACT_MontoMulta:=[xxACT_Items:179]Monto:7
									
								: (btn_MultaProtPorc=1)
									If (vr_PctMontoMulta>0)
										If (Size of array:C274(aACT_Ptrs)>0)
											If (Size of array:C274(aACT_Ptrs{1}->)>0)
												If (Count parameters:C259=1)
													KRL_GotoRecord (->[ACT_Boletas:181];aACT_Ptrs{1}->{1})
													vrACT_MontoMulta:=Round:C94([ACT_Boletas:181]Monto_Total:6*(vr_PctMontoMulta/100);<>vlACT_Decimales)
												Else 
													vrACT_MontoMulta:=Round:C94([ACT_Boletas:181]Monto_Total:6*(vr_PctMontoMulta/100);<>vlACT_Decimales)
												End if 
											End if 
										End if 
										If (vrACT_MontoMulta=0)
											vrACT_MontoMulta:=vr_PctMontoMulta
										End if 
									Else 
										LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque se tiene configurado obtener el m"+"onto desde un porcentaje del monto del documento pero el porcentaje no"+" fue ingresado o está en 0 en la configuración.")
									End if 
							End case 
							vrACT_MontoMultaOrig:=vrACT_MontoMulta
						Else 
							LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque el ítem de cargo seleccionado no "+"existe.")
						End if 
					Else 
						LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque no existe configuración para dete"+"rminar el monto.")
					End if 
				Else 
					LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque no se tiene configurado el ítem d"+"e cargo a"+"l cual asociar el monto.")
				End if 
			Else 
				$vb_limpiar:=True:C214
			End if 
		Else 
			$vb_limpiar:=True:C214
		End if 
		If ($vb_limpiar)
			$vb_desdeImpresorNoOcultar:=False:C215
			ACTcfg_OpcionesReimpBoletas ("InitVars")
			ACTcfg_OpcionesReimpBoletas ("SeteaVisibilidadObjetosForm";->$vb_desdeImpresorNoOcultar)
		End if 
	: ($vt_accion="GeneraRecargo")
		ACTcfg_OpcionesReimpBoletas ("LeeBlob")
		If (cbMultaXReimprimir=1)
			If (vlACT_idItemMulta#0)
				If (vrACT_MontoMulta>0)
					ACTcfg_ItemsMatricula ("InicializaYLee")
					READ ONLY:C145([Personas:7])
					READ ONLY:C145([ACT_Cargos:173])
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([ACT_Terceros:138])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					FIRST RECORD:C50([ACT_CuentasCorrientes:175])
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]ID_Tercero:21)
					If ((Records in selection:C76([ACT_CuentasCorrientes:175])>0) & (Records in selection:C76([Personas:7])>0))
						$v_idcargo:=ACTac_CreateCargoDocCargoImp (False:C215;vlACT_idItemMulta;vrACT_MontoMulta;Current date:C33(*);False:C215;[ACT_CuentasCorrientes:175]ID:1;[Personas:7]No:1;False:C215;False:C215;[ACT_Terceros:138]Id:1)
						If ($v_idcargo<=0)
							LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o.")
						End if 
					Else 
						LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o debido a que no fueron encontradas cuent"+"as y/o apoderados a los cuales hacer el cargo.")
					End if 
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
				Else 
					LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque el monto del movimiento no es may"+"or a 0.")
				End if 
			Else 
				LOG_RegisterEvt ("El cobro adicional por reimpresión de un documento tributario no pudo ser generad"+"o porque no fue seleccionado un ítem de ca"+"rgo.")
			End if 
		End if 
		
	: ($vt_accion="SeteaFiltroYFormatoCampoPct")
		ACTcfg_OpcionesRecargos ("SeteaFiltro";$ptr1)
		ACTcfg_OpcionesReimpBoletas ("SeteaVisibilidadObjetosForm")
		ACTcfg_OpcionesReimpBoletas ("ValidacionesForm")
		
	: ($vt_accion="ValidacionesForm")
		If (cbMultaXReimprimir=1)
			_O_ENABLE BUTTON:C192(*;"multa@")
			OBJECT SET ENTERABLE:C238(*;"multa@";True:C214)
			If ((btn_MultaProtFija=0) & (btn_MultaProtPorc=0))
				btn_MultaProtFija:=1
			End if 
			If (btn_MultaProtPorc=1)
				OBJECT SET ENTERABLE:C238(vr_PctMontoMulta;True:C214)
			Else 
				vr_PctMontoMulta:=0
				OBJECT SET ENTERABLE:C238(vr_PctMontoMulta;False:C215)
			End if 
			If (Size of array:C274(at_GlosasItems)=0)
				ACTcfg_OpcionesReimpBoletas ("BuscaItemsADesplegar")
			End if 
		Else 
			_O_DISABLE BUTTON:C193(*;"multa@")
			OBJECT SET ENTERABLE:C238(*;"multa@";False:C215)
			ACTcfg_OpcionesReimpBoletas ("InitVars")
		End if 
		If (vtACTcfg_SelectedItemName="")
			vlACTcfg_SelectedItemId:=0
		End if 
		If (btn_MultaProtPorc=0)
			vr_PctMontoMulta:=0
		End if 
		_O_ENABLE BUTTON:C192(cbMultaXReimprimir)
	: ($vt_accion="SeteaVisibilidadObjetosForm")
		If (<>gCountryCode="mx") & (Count parameters:C259=1)
			OBJECT SET VISIBLE:C603(*;"multa@";True:C214)
		Else 
			If (Count parameters:C259=2)
				If ($ptr1->) & (<>gCountryCode#"mx")
					OBJECT SET VISIBLE:C603(*;"multa@";True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*;"multa@";False:C215)
				End if 
			Else 
				OBJECT SET VISIBLE:C603(*;"multa@";False:C215)
			End if 
		End if 
		
	: ($vt_accion="BuscaDeudaCreaCargo")
		C_LONGINT:C283(vlACT_idItemMulta)
		C_REAL:C285(vrACT_MontoMulta)
		ACTcfg_OpcionesReimpBoletas ("LeeBlob")
		If (cbMultaXReimprimir=1)
			If (vlACT_idItemMulta#0) & (vrACT_MontoMulta#0)
				If (vrACT_MontoMultaOrig=vrACT_MontoMulta)
					$buscaElPrimero:=False:C215
					ACTcfg_OpcionesReimpBoletas ("CargaDatosRecargo";->$buscaElPrimero)
				End if 
				ACTcfg_OpcionesReimpBoletas ("GeneraRecargo")
			End if 
		End if 
		
	: ($vt_accion="OnLoadEvent")
		ACTcfg_OpcionesReimpBoletas ("SeteaVisibilidadObjetosForm")
		ACTcfg_OpcionesReimpBoletas ("SeteaFiltro";$ptr1)
		If (cbMultaPermiteMod=1)
			OBJECT SET ENTERABLE:C238(*;"multa4Mod@";True:C214)
			_O_ENABLE BUTTON:C192(*;"multa4Mod@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"multa4Mod@";False:C215)
			_O_DISABLE BUTTON:C193(*;"multa4Mod@")
		End if 
		ACTcfg_OpcionesReimpBoletas ("SeteaVisibilidadObjetosForm")
		
	: ($vt_accion="SeteaFiltro")
		If (<>vlACT_Decimales>0)
			$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
			$format:="#####0"+<>tXS_RS_DecimalSeparator+("#"*<>vlACT_Decimales)
		Else 
			$filter:="&"+ST_Qte ("0-9")
			$format:="#####0"
		End if 
		OBJECT SET FILTER:C235($ptr1->;$filter)
		OBJECT SET FORMAT:C236($ptr1->;$format)
		
	: ($vt_accion="InitAllVars")
		ACTcfg_OpcionesReimpBoletas ("InitVars")
		vlACT_idItemMulta:=0
		vrACT_MontoMulta:=0
		vrACT_MontoMultaOrig:=0
		
End case 
