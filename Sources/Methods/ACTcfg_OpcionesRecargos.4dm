//%attributes = {}
  //ACTcfg_OpcionesRecargos

C_TEXT:C284($vt_accion;$1;$filter)
$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="BuscaItemsADesplegar")
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACTcfg_SelectedItemName)
		C_LONGINT:C283(vlACTcfg_SelectedItemId;cbMultaXProtesto;b_MultaProtFija;b_MultaProtPorc;cbMultaPermiteMod)
		C_REAL:C285(vr_PctMontoMulta)
		ARRAY LONGINT:C221(al_IdsItems;0)
		ARRAY TEXT:C222(at_GlosasItems;0)
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesRecargos ("DeclaraVars")
		cbMultaXProtesto:=0
		b_MultaProtFija:=0
		b_MultaProtPorc:=0
		vr_PctMontoMulta:=0
		vlACTcfg_SelectedItemId:=0
		cbMultaPermiteMod:=0
		vtACTcfg_SelectedItemName:=""
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_MultasRecargos")
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_MultasRecargos")
		
	: ($vt_accion="CargaDatosMulta")
		C_LONGINT:C283(vlACT_idItemMulta)
		C_REAL:C285(vrACT_MontoMulta)
		vlACT_idItemMulta:=0
		vrACT_MontoMulta:=0
		ACTcfg_OpcionesRecargos ("LeeBlob")
		If (cbMultaXProtesto=1)
			If (vlACTcfg_SelectedItemId#0)
				If ((b_MultaProtFija#0) | (b_MultaProtPorc#0))
					REDUCE SELECTION:C351([xxACT_Items:179];0)
					KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemId)
					If (Records in selection:C76([xxACT_Items:179])=1)
						vlACT_idItemMulta:=[xxACT_Items:179]ID:1
						Case of 
							: (b_MultaProtFija=1)
								vrACT_MontoMulta:=[xxACT_Items:179]Monto:7
								
							: (b_MultaProtPorc=1)
								If (vr_PctMontoMulta>0)
									vrACT_MontoMulta:=Round:C94([ACT_Documentos_de_Pago:176]MontoPago:6*(vr_PctMontoMulta/100);<>vlACT_Decimales)
								Else 
									LOG_RegisterEvt ("La multa automática no pudo ser generada porque se tiene configurado obtener el m"+"onto desde un porcentaje del monto del documento protestado pero el porcentaje no"+" fue ingresado o está en 0eb la configuración.")
								End if 
						End case 
					Else 
						LOG_RegisterEvt ("La multa automática no pudo ser generada porque el ítem de cargo seleccionado no "+"existe.")
					End if 
				Else 
					LOG_RegisterEvt ("La multa automática no pudo ser generada porque no existe configuración para dete"+"rminar el monto.")
				End if 
			Else 
				LOG_RegisterEvt ("La multa automática no pudo ser generada porque no se tiene configurado el ítem d"+"e cargo a"+"l cual asociar el monto del  recargo o multa.")
			End if 
		End if 
		
	: ($vt_accion="GeneraMultaXProtesto")
		ACTcfg_OpcionesRecargos ("LeeBlob")
		If (cbMultaXProtesto=1)
			If (vlACT_idItemMulta#0)
				If (vrACT_MontoMulta>0)
					ACTcfg_ItemsMatricula ("InicializaYLee")
					READ ONLY:C145([Personas:7])
					READ ONLY:C145([ACT_Cargos:173])
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([ACT_Terceros:138])
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					FIRST RECORD:C50([ACT_CuentasCorrientes:175])
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Documentos_de_Pago:176]ID_Tercero:48)
					If ((Records in selection:C76([ACT_CuentasCorrientes:175])>0) & (Records in selection:C76([Personas:7])>0))
						$v_idcargo:=ACTac_CreateCargoDocCargoImp (False:C215;vlACT_idItemMulta;vrACT_MontoMulta;Current date:C33(*);False:C215;[ACT_CuentasCorrientes:175]ID:1;[Personas:7]No:1;False:C215;False:C215;[ACT_Terceros:138]Id:1)
						If ($v_idcargo<=0)
							LOG_RegisterEvt ("La multa automática no pudo ser generada.")
						End if 
					Else 
						LOG_RegisterEvt ("La multa automática no pudo ser generada debido a que no fueron encontradas cuent"+"as y/o apoderados a los cuales hacer el cargo.")
					End if 
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
				Else 
					LOG_RegisterEvt ("La multa automática no pudo ser generada porque el monto del movimiento no es may"+"or a 0.")
				End if 
			Else 
				LOG_RegisterEvt ("La multa automática no pudo ser generada porque no fue seleccionado un ítem de ca"+"rgo.")
			End if 
		End if 
		
	: ($vt_accion="SeteaFiltroYFormatoCampoPct")
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235($ptr1->;$filter)
		OBJECT SET FORMAT:C236($ptr1->;"###0"+<>tXS_RS_DecimalSeparator+"###")
		
	: ($vt_accion="ValidacionesForm")
		If (cbMultaXProtesto=1)
			_O_ENABLE BUTTON:C192(*;"multaProt@")
			OBJECT SET ENTERABLE:C238(*;"multaProt@";True:C214)
			If ((b_MultaProtFija=0) & (b_MultaProtPorc=0))
				b_MultaProtFija:=1
			End if 
			If (b_MultaProtPorc=1)
				OBJECT SET ENTERABLE:C238(vr_PctMontoMulta;True:C214)
			Else 
				vr_PctMontoMulta:=0
				OBJECT SET ENTERABLE:C238(vr_PctMontoMulta;False:C215)
			End if 
			If (Size of array:C274(at_GlosasItems)=0)
				ACTcfg_OpcionesRecargos ("BuscaItemsADesplegar")
			End if 
		Else 
			_O_DISABLE BUTTON:C193(*;"multaProt@")
			OBJECT SET ENTERABLE:C238(*;"multaProt@";False:C215)
			ACTcfg_OpcionesRecargos ("InitVars")
		End if 
		If (vtACTcfg_SelectedItemName="")
			vlACTcfg_SelectedItemId:=0
		End if 
		If (b_MultaProtPorc=0)
			vr_PctMontoMulta:=0
		End if 
		OBJECT SET ENTERABLE:C238(*;"multaProt10";False:C215)
End case 
