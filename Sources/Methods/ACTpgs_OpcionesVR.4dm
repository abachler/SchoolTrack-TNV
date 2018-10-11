//%attributes = {}
  //ACTpgs_OpcionesVR

C_TEXT:C284($vt_accion;$1)
C_LONGINT:C283($vl_line;$vlACTpgs_SelectedItemId)
C_POINTER:C301($ptr1;$2;$ptr2;$3)
C_BOOLEAN:C305($0;$vb_go)
C_BOOLEAN:C305($b_generaMonto0)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($vt_accion="SetALP")
		ACTpgs_OpcionesVR ("ACT_initArrays")
		C_LONGINT:C283($Error)
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (ALP_AreaVR;AT_Inc ;"arACT_PgsVRCantidad";__ ("Cantidad");80;"######0"+<>tXS_RS_DecimalSeparator+"##";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_AreaVR;AT_Inc ;"atACT_PgsVRDetalle";__ ("Detalle");280;"";0;0;0)
		$error:=ALP_DefaultColSettings (ALP_AreaVR;AT_Inc ;"arACT_PgsVRMonto";__ ("Valor Unitario");100;"|Despliegue_ACT_Pagos";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_AreaVR;AT_Inc ;"arACT_PgsVRTotal";__ ("Monto Total");100;"|Despliegue_ACT_Pagos";0;0;0)
		$error:=ALP_DefaultColSettings (ALP_AreaVR;AT_Inc ;"alACT_PgsVRIDItem";__ ("ID ITEM");10;"";0;0;0)
		
		ALP_SetDefaultAppareance (ALP_AreaVR;9;1;6;2;8)
		AL_SetColOpts (ALP_AreaVR;1;1;1;1;0)
		AL_SetRowOpts (ALP_AreaVR;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_AreaVR;0;1;1)
		AL_SetMainCalls (ALP_AreaVR;"";"")
		AL_SetCallbacks (ALP_AreaVR;"";"xALP_ACT_CB_VRPagos")
		AL_SetScroll (ALP_AreaVR;0;-3)
		AL_SetEntryOpts (ALP_AreaVR;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (ALP_AreaVR;0;30;0)
		
	: ($vt_accion="ACT_initArrays")
		ARRAY REAL:C219(arACT_PgsVRCantidad;0)
		ARRAY TEXT:C222(atACT_PgsVRDetalle;0)
		ARRAY REAL:C219(arACT_PgsVRMonto;0)
		ARRAY REAL:C219(arACT_PgsVRTotal;0)
		ARRAY LONGINT:C221(alACT_PgsVRIDItem;0)
		
		ARRAY LONGINT:C221(alACT_PgsVDRecNumCargos;0)
		
	: ($vt_accion="BuscaItem")
		READ ONLY:C145([xxACT_Items:179])
		$vlACTpgs_SelectedItemId:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vlACTpgs_SelectedItemId)
		If (Records in selection:C76([xxACT_Items:179])=1)
			$vb_go:=True:C214
		End if 
		
	: ($vt_accion="ACT_InsertaElemento")
		AL_UpdateArrays (ALP_AreaVR;0)
		$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->vlACTpgs_SelectedItemId)
		If ($vb_go)
			$vb_imputacionUnica:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->vlACTpgs_SelectedItemId;->[xxACT_Items:179]Imputacion_Unica:24)
			If ($vb_imputacionUnica)
				$vl_existe:=Find in array:C230(alACT_PgsVRIDItem;vlACTpgs_SelectedItemId)
				If ($vl_existe#-1)
					$vb_go:=False:C215
					CD_Dlog (0;__ ("El ítem ")+ST_Qte ([xxACT_Items:179]Glosa:2)+__ (" ya está dentro de la lista. No puede ser agregado nuevamente porque es un ítem de imputación única.\r\rSi necesita emitirlo más de una vez, cambie la configuración de ítem de imputación única."))
				End if 
			End if 
			If ($vb_go)
				$vl_line:=1
				AT_Insert ($vl_line;1;->arACT_PgsVRCantidad;->atACT_PgsVRDetalle;->arACT_PgsVRMonto;->arACT_PgsVRTotal;->alACT_PgsVRIDItem)
				arACT_PgsVRCantidad{$vl_line}:=1
				atACT_PgsVRDetalle{$vl_line}:=[xxACT_Items:179]Glosa:2
				arACT_PgsVRMonto{$vl_line}:=[xxACT_Items:179]Monto:7
				alACT_PgsVRIDItem{$vl_line}:=vlACTpgs_SelectedItemId
				ACTpgs_OpcionesVR ("Calcula";->$vl_line)
			End if 
		End if 
		AL_UpdateArrays (ALP_AreaVR;-2)
		
	: ($vt_accion="ACT_EliminaElemento")
		$vl_line:=AL_GetLine (ALP_AreaVR)
		If ($vl_line>0)
			AL_UpdateArrays (ALP_AreaVR;0)
			AT_Delete ($vl_line;1;->arACT_PgsVRCantidad;->atACT_PgsVRDetalle;->arACT_PgsVRMonto;->arACT_PgsVRTotal;->alACT_PgsVRIDItem)
			AL_UpdateArrays (ALP_AreaVR;-2)
			ACTpgs_OpcionesVR ("CalculaTotal")
		End if 
		
	: ($vt_accion="Calcula")
		$vl_line:=$ptr1->
		$vt_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
		If ($vl_line>0)
			$vlACTpgs_SelectedItemId:=alACT_PgsVRIDItem{$vl_line}
			$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->$vlACTpgs_SelectedItemId)
			If ($vb_go)
				arACT_PgsVRTotal{$vl_line}:=ACTut_retornaMontoEnMoneda (arACT_PgsVRMonto{$vl_line};[xxACT_Items:179]Moneda:10;vdACT_FechaPago;$vt_monedaPais)
				arACT_PgsVRTotal{$vl_line}:=Round:C94(arACT_PgsVRTotal{$vl_line}*arACT_PgsVRCantidad{$vl_line};Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPais)))
				ACTpgs_OpcionesVR ("CalculaTotal")
			End if 
		End if 
		
	: ($vt_accion="RecalculaTodo")
		AL_UpdateArrays (ALP_AreaVR;0)
		For ($i;1;Size of array:C274(arACT_PgsVRCantidad))
			ACTpgs_OpcionesVR ("Calcula";->$i)
		End for 
		AL_UpdateArrays (ALP_AreaVR;-2)
		
	: ($vt_accion="TextoImputacionUnica")
		OBJECT SET VISIBLE:C603(*;"vtACTvd_ImputacionUnica";False:C215)
		For ($i;1;Size of array:C274(alACT_PgsVRIDItem))
			$vl_idItem:=alACT_PgsVRIDItem{$i}
			If (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]Imputacion_Unica:24))
				OBJECT SET VISIBLE:C603(*;"vtACTvd_ImputacionUnica";True:C214)
				$i:=Size of array:C274(alACT_PgsVRIDItem)
			End if 
		End for 
		
	: ($vt_accion="CalculaTotal")
		vr_Total:=AT_GetSumArray (->arACT_PgsVRTotal)
		ACTpgs_OpcionesVR ("TextoImputacionUnica")
		
	: ($vt_accion="CargaMontoMoneda")
		$vlACTpgs_SelectedItemId:=$ptr1->
		$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->$vlACTpgs_SelectedItemId)
		If ($vb_go)
			vr_monto:=[xxACT_Items:179]Monto:7
			vt_moneda:=[xxACT_Items:179]Moneda:10
		Else 
			vr_monto:=0
			vt_moneda:=""
		End if 
	: ($vt_accion="AgregaRecNum")
		If (Find in array:C230(alACT_PgsVDRecNumCargos;$ptr1->)=-1)
			APPEND TO ARRAY:C911(alACT_PgsVDRecNumCargos;$ptr1->)
		End if 
		
	: ($vt_accion="InsertaCargoAPagar")
		For ($i;1;Size of array:C274(alACT_PgsVDRecNumCargos))
			ACTpgs_AppendCarToArray (alACT_PgsVDRecNumCargos{$i})
		End for 
		
	: ($vt_accion="LimpiaCampos")
		AL_UpdateArrays (ALP_AreaVR;0)
		ACTpgs_OpcionesVR ("ACT_initArrays")
		ACTpgs_OpcionesVR ("LimpiaVarsForm")
		AL_UpdateArrays (ALP_AreaVR;-2)
		KRL_UnloadReadOnly (ptrACTpgs_Table)
		
	: ($vt_accion="LimpiaVarsForm")
		ARRAY LONGINT:C221(alACTvd_IdsItems;0)
		ARRAY TEXT:C222(atACTvd_GlosasItems;0)
		C_TEXT:C284(vsACT_NomApellido;vtACTpgs_SelectedItem;vt_moneda)
		C_REAL:C285(vr_monto;vr_Total)
		C_LONGINT:C283(vlACTpgs_SelectedItemId)
		vsACT_NomApellido:=""
		vtACTpgs_SelectedItem:=""
		vt_moneda:=""
		vr_monto:=0
		vr_Total:=0
		vlACTpgs_SelectedItemId:=0
		vrACT_MontoAdeudado:=0
		vrACT_MontoDescto:=0
		ACTpgs_DeclarationsFormasPago 
		
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoInteresesVD";->[xxACT_Items:179]ID:1;->alACTvd_IdsItems;->[xxACT_Items:179]Glosa:2;->atACTvd_GlosasItems)
		
	: ($vt_accion="CargaRegistro")
		Case of 
			: (RNApdo#-1)
				READ ONLY:C145([Personas:7])
				GOTO RECORD:C242([Personas:7];RNApdo)
				btn_apdo:=1
				btn_tercero:=0
				vsACT_NomApellido:=[Personas:7]Apellidos_y_nombres:30
				
			: (RNTercero#-1)
				READ ONLY:C145([ACT_Terceros:138])
				GOTO RECORD:C242([ACT_Terceros:138];RNTercero)
				btn_apdo:=0
				btn_tercero:=1
				vsACT_NomApellido:=[ACT_Terceros:138]Nombre_Completo:9
				
		End case 
		If ((RNApdo#-1) | (RNTercero#-1))
			GOTO OBJECT:C206(vtACTpgs_SelectedItem)
		Else 
			btn_apdo:=1
			btn_tercero:=0
		End if 
		ACTpgs_OpcionesVR ("SetBotonNuevoTercero")
		ACTpgs_OpcionesVR ("SetEstadoBasurero")
		ACTpgs_OpcionesVR ("SetPointers")
		ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
		
	: ($vt_accion="SetBotonNuevoTercero")
		If (btn_tercero=1)
			_O_ENABLE BUTTON:C192(btn_NuevoTercero)
		Else 
			_O_DISABLE BUTTON:C193(btn_NuevoTercero)
		End if 
		
	: ($vt_accion="SetEstadoBasurero")
		$line:=AL_GetLine (ALP_AreaVR)
		If ($line>0)
			_O_ENABLE BUTTON:C192(bDelCargos)
		Else 
			_O_DISABLE BUTTON:C193(bDelCargos)
		End if 
		
	: ($vt_accion="SetPointers")
		C_POINTER:C301(ptrACTpgs_Table;ptrACTpgs_FieldID;ptrACTpgs_VarRecNum;ptrACTpgs_FieldDT)
		Case of 
			: (btn_apdo=1)
				ptrACTpgs_Table:=->[Personas:7]
				ptrACTpgs_FieldID:=->[Personas:7]No:1
				ptrACTpgs_VarRecNum:=->RNApdo
				ptrACTpgs_FieldDT:=->[Personas:7]ACT_DocumentoTributario:45
				
			: (btn_tercero=1)
				ptrACTpgs_Table:=->[ACT_Terceros:138]
				ptrACTpgs_FieldID:=->[ACT_Terceros:138]Id:1
				ptrACTpgs_VarRecNum:=->RNTercero
				ptrACTpgs_FieldDT:=->[ACT_Terceros:138]id_CatDocTrib:55
				
		End case 
		
	: ($vt_accion="CambiaTipoRegistro")
		vsACT_NomApellido:=""
		GOTO OBJECT:C206(vsACT_NomApellido)
		RNApdo:=-1
		RNTercero:=-1
		ACTpgs_OpcionesVR ("SetPointers")
		ACTpgs_OpcionesVR ("SetEstadoBasurero")
		ACTpgs_OpcionesVR ("SetBotonNuevoTercero")
		
	: ($vt_accion="GeneraAvisos")
		C_LONGINT:C283($vlACT_idItem;$vl_idCtaCte;$vl_idApdo;$vl_idTercero)
		  //20130626 RCH NF CANTIDAD
		C_REAL:C285($vr_cantidad)
		C_BOOLEAN:C305($vb_monedaNacional;$vb_mismoAviso;$vb_noIncluirEnDT;$vb_avisoMulta;$vb_avisoXCta;$vb_campoVD)
		C_REAL:C285($vrACT_Monto)
		C_DATE:C307($vdACT_FechaE)
		C_LONGINT:C283($proc)
		
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$b_generaMonto0:=$ptr2->
		End if 
		
		$proc:=IT_UThermometer (1;0;__ ("Generando deuda..."))
		Case of 
			: (KRL_isSameField (->[Personas:7]No:1;ptrACTpgs_FieldID))
				$vl_idApdo:=ptrACTpgs_FieldID->
				$vl_idTercero:=0
			: (KRL_isSameField (->[ACT_Terceros:138]Id:1;ptrACTpgs_FieldID))
				$vl_idApdo:=0
				$vl_idTercero:=ptrACTpgs_FieldID->
		End case 
		$vb_monedaNacional:=True:C214
		$vb_mismoAviso:=False:C215
		$vl_idCtaCte:=0
		$vb_noIncluirEnDT:=False:C215
		$vb_avisoMulta:=False:C215
		$vb_avisoXCta:=False:C215
		$vb_campoVD:=True:C214
		  //20120118 RCH se saca del for porque cuando hay 2 avisos para el mismo periodo, el cargo queda en un aviso que no corresponde...
		$vl_idCargo:=0
		
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		For ($i;1;Size of array:C274(arACT_PgsVRCantidad))
			  //$vl_iteracion:=arACT_PgsVRCantidad{$i}
			$vr_cantidad:=arACT_PgsVRCantidad{$i}
			$vlACT_idItem:=alACT_PgsVRIDItem{$i}
			  //$vl_idCargo:=0
			$vb_noIncluirEnDT:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vlACT_idItem;->[xxACT_Items:179]No_incluir_en_DocTributario:31)  //20120817 ASM para respetar la configuración.
			$vb_go:=ACTpgs_OpcionesVR ("BuscaItem";->$vlACT_idItem)
			If ($vb_go)
				
				$vt_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
				$l_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPais))
				  //$vrACT_Monto:=arACT_PgsVRMonto{$i}
				$vrACT_Monto:=ACTut_retornaMontoEnMoneda (arACT_PgsVRMonto{$i};[xxACT_Items:179]Moneda:10;vdACT_FechaPago;$vt_monedaPais)
				$vrACT_Monto:=Round:C94($vrACT_Monto*$vr_cantidad;$l_decimales)
				$vdACT_FechaE:=vdACT_FechaE
				  //For ($j;1;$vl_iteracion)
				If ($i#1)
					$vb_mismoAviso:=True:C214
				End if 
				  //$vl_idCargoXCaja:=ACTac_CreateCargoDocCargoImp ($vb_monedaNacional;$vlACT_idItem;$vrACT_Monto;$vdACT_FechaE;$vb_mismoAviso;$vl_idCtaCte;$vl_idApdo;$vb_noIncluirEnDT;$vb_avisoMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo;$vb_campoVD;0;$vr_cantidad;$b_generaMonto0)
				$vl_idCargoXCaja:=ACTac_CreateCargoDocCargoImp ($vb_monedaNacional;$vlACT_idItem;$vrACT_Monto;$vdACT_FechaE;$vb_mismoAviso;$vl_idCtaCte;$vl_idApdo;$vb_noIncluirEnDT;$vb_avisoMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo;$vb_campoVD;0;$vr_cantidad;$b_generaMonto0;($i<Size of array:C274(arACT_PgsVRCantidad)))  //20180816 RCH Para recalcular AC solo al final
				If ($vl_idCargoXCaja#-1)
					ACTpgs_OpcionesVR ("AgregaRecNum";->$vl_idCargoXCaja)
					READ ONLY:C145([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_Cargos:173];$vl_idCargoXCaja)
					$vl_idCargo:=[ACT_Cargos:173]ID:1
					  //If ([ACT_Cargos]Monto_Neto>0)
					If (([ACT_Cargos:173]Monto_Neto:5>0) | ($b_generaMonto0 & ([ACT_Cargos:173]Monto_Neto:5>=0)))
						vrACT_MontoAdeudado:=vrACT_MontoAdeudado+[ACT_Cargos:173]Monto_Neto:5
						ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
					End if 
					$vb_go:=True:C214
				Else 
					$vb_go:=False:C215
					  //$j:=$vl_iteracion
					CD_Dlog (0;__ ("Se produjo un problema en la creación del ítem de cargo."))
				End if 
				  //End for 
			End if 
		End for 
		  //ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")  //20160318 RCH Se recalcula en bash por evitar la espera
		IT_UThermometer (-2;$proc)
		
	: ($vt_accion="ValidaSoloEmitir")
		$vb_go:=True:C214
		Case of 
			: (vsACT_NomApellido="")
				$vb_go:=False:C215
				CD_Dlog (0;__ ("Seleccione un apoderado o tercero."))
				
			: (vdACT_FechaPago=!00-00-00!)
				$vb_go:=False:C215
				CD_Dlog (0;__ ("Seleccione una fecha para el pago."))
				
			: (vdACT_FechaE=!00-00-00!)
				$vb_go:=False:C215
				CD_Dlog (0;__ ("Seleccione una fecha de emisión."))
				
			: (Size of array:C274(arACT_PgsVRTotal)=0)
				$vb_go:=False:C215
				CD_Dlog (0;__ ("Debe agregar cargos a la lista antes de continuar."))
				
			: (vr_Total=0)
				$vb_go:=False:C215
				CD_Dlog (0;__ ("El monto a emitir y/o pagar debe ser superior a 0."))
				
			: (ACTpgs_OpcionesVR ("HayItemImputacionUnicaNoEmitible"))
				$vb_go:=False:C215
				CD_Dlog (0;__ ("Dentro de los cargos a generar hay un cargo de imputación única ya cobrado."))
				
		End case 
		
	: ($vt_accion="HayItemImputacionUnicaNoEmitible")
		For ($i;1;Size of array:C274(alACT_PgsVRIDItem))
			$vl_idItem:=alACT_PgsVRIDItem{$i}
			READ ONLY:C145([ACT_Cargos:173])
			If (KRL_isSameField (ptrACTpgs_FieldID;->[ACT_Terceros:138]Id:1))
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=[ACT_Terceros:138]Id:1)
			Else 
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			End if 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=0;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=$vl_idItem;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=Month of:C24(vdACT_FechaE);*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=Year of:C25(vdACT_FechaE))
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
			If (Records in selection:C76([ACT_Cargos:173])>0) & (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]Imputacion_Unica:24))
				$vb_go:=True:C214
				$i:=Size of array:C274(alACT_PgsVRIDItem)
			End if 
		End for 
	: ($vt_accion="ObtieneNombreProceso")
		$ptr1->:="Ventas Directas"
		
End case 
$0:=$vb_go
