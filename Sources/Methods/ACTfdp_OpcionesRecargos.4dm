//%attributes = {}
  //ACTfdp_OpcionesRecargos
C_TEXT:C284(vt_accion;$1)
C_REAL:C285($vrACT_MontoRecargo;$vrACT_MontoAPagar)
C_LONGINT:C283($vl_RecNumCargo;$id_FormaPago;$decimales)
C_REAL:C285(vl_SelectedListItem)
C_POINTER:C301($ptr1;$2;$ptr2;$3)
C_BLOB:C604(xBlob)
vt_accion:=$1

Case of 
	: (Count parameters:C259=2)
		$ptr1:=$2
	: (Count parameters:C259=3)
		$ptr1:=$2
		$ptr2:=$3
End case 

Case of 
	: (vt_accion="DeclaraVars")
		C_LONGINT:C283(cs_ItemSeleccionado;cs_MontoSeleccionado;crPermitirRecargoItem;crPermitirModificarMonto)
		C_TEXT:C284(vt_CargoSeleccionado)
		C_REAL:C285(vr_MontoRecargo)
		C_REAL:C285(vrACT_MontoRecargo)
		C_BOOLEAN:C305(vb_MontoModificado)
	: (vt_accion="InicializaVars")
		ACTfdp_OpcionesRecargos ("DeclaraVars")
		vt_CargoSeleccionado:=""
		vr_MontoRecargo:=0
		cs_ItemSeleccionado:=0
		cs_MontoSeleccionado:=0
		crPermitirRecargoItem:=0
		crPermitirModificarMonto:=0
		vrACT_MontoRecargo:=0
	: (vt_accion="CargaVariables")
		ADTcfg_LoadItemsACT 
		ACTfdp_OpcionesRecargos ("InicializaVars")
		$id_FormaPago:=$ptr1->
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$id_FormaPago)
		BLOB_Blob2Vars (->[ACT_Formas_de_Pago:287]Opciones_Recargos:16;0;->crPermitirRecargoItem;->cs_ItemSeleccionado;->cs_MontoSeleccionado;->vr_MontoRecargo;->crPermitirModificarMonto)
		If (crPermitirRecargoItem=1)
			$el:=Find in array:C230(alACT_ID;[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15)
			If ($el#-1)
				vt_CargoSeleccionado:=atACT_Glosa{$el}
			End if 
		End if 
		
	: (vt_accion="GuardaConfRecargos")
		KRL_ReloadInReadWriteMode (->[ACT_Formas_de_Pago:287])
		BLOB_Variables2Blob (->xBlob;0;->crPermitirRecargoItem;->cs_ItemSeleccionado;->cs_MontoSeleccionado;->vr_MontoRecargo;->crPermitirModificarMonto)
		[ACT_Formas_de_Pago:287]Opciones_Recargos:16:=xBlob
		If (crPermitirRecargoItem=1)
			If (vl_SelectedListItem>0)
				[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15:=alACT_ID{vl_SelectedListItem}
			End if 
		End if 
		SAVE RECORD:C53([ACT_Formas_de_Pago:287])
		KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])
	: (vt_accion="CargaMontoRecargo")
		$id_FormaPago:=$ptr1->
		$vrACT_MontoAPagar:=$ptr2->
		ACTfdp_OpcionesRecargos ("CargaVariables";->$id_FormaPago)
		$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
		$decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPago))
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$id_FormaPago)
		
		If (crPermitirRecargoItem=1)
			OBJECT SET ENTERABLE:C238(*;"multaCfg4";True:C214)
			If ([ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15>0)
				If (cs_ItemSeleccionado=1)
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15)
					If (Not:C34([xxACT_Items:179]EsRelativo:5))
						$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
						$vr_monto:=ACTut_retornaMontoEnMoneda ([xxACT_Items:179]Monto:7;[xxACT_Items:179]Moneda:10;Current date:C33(*);$vt_monedaPago)
						$vrACT_MontoRecargo:=$vr_monto
					Else 
						$vrACT_MontoRecargo:=Round:C94($vrACT_MontoAPagar*([xxACT_Items:179]Monto:7/100);$decimales)
					End if 
				Else 
					If (vr_MontoRecargo>0)
						$vrACT_MontoRecargo:=Round:C94(($vrACT_MontoAPagar*vr_MontoRecargo)/100;$decimales)
					Else 
						$vrACT_MontoRecargo:=0
					End if 
				End if 
			Else 
				$vrACT_MontoRecargo:=0
				CD_Dlog (0;__ ("No existe Item seleccionado en la configuración de recargos de Formas de Pago. ")+"\r\r"+__ ("El recargo no será generado."))
			End if 
		End if 
		
		$0:=$vrACT_MontoRecargo
		
	: (vt_accion="CreaItemRecargo")
		$id_FormaPago:=$ptr1->
		$vrACT_MontoAPagar:=$ptr2->
		If ($vrACT_MontoAPagar>0)
			READ ONLY:C145([ACT_Formas_de_Pago:287])
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$id_FormaPago)
			  //$vl_RecNumCargo:=ACTpgs_CreaCargo (True;[Personas]No;Abs($vrACT_MontoAPagar);[ACT_Formas_de_Pago]Id_Item_Seleccionado;False)
			  //20141117 ASM agrego la fecha de vencimiento para cuando se está creando el recargo
			$vl_RecNumCargo:=ACTpgs_CreaCargo (True:C214;[Personas:7]No:1;Abs:C99($vrACT_MontoAPagar);[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15;False:C215;vdACT_FechaPago)
			ACTpgs_AppendCarToArray ($vl_RecNumCargo)
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			ACTfdp_OpcionesRecargos ("SumaMontos")
		End if 
	: (vt_accion="SumaMontos")
		C_REAL:C285(vrACT_MontoSeleccionado;vrACT_MontoPago;vrACT_MontoRecargo;vrACTpgs_MontoAPagar)
		If (Not:C34(vb_MontoModificado))
			vrACT_MontoPago:=vrACT_MontoSeleccionado+vrACT_MontoRecargo+vrACT_MontoMulta
			vrACTpgs_MontoAPagar:=vrACT_MontoSeleccionado+vrACT_MontoRecargo+vrACT_MontoMulta
		Else 
			vrACTpgs_MontoAPagar:=vrACT_MontoSeleccionado+vrACT_MontoRecargo+vrACT_MontoMulta
		End if 
		vrACTpgs_MontoMoneda:=vrACTpgs_MontoAPagar
		
	: (vt_accion="CargaMontoRecargoDocumentar")
		If (rCheques=1)
			vlACT_FormasdePago:=-4
		Else 
			vlACT_FormasdePago:=-8
		End if 
		If (cbMultaXCaja=1)
			$vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoSeleccionado)
			vrACT_MontoMulta:=vrACT_MontoMulta+$vrACT_MontoRecargo
			vrACT_MontoAPagarApdo:=vrACT_MontoSeleccionado+vrACT_MontoMulta
		Else 
			$vrACT_MontoRecargo:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->vlACT_FormasdePago;->vrACT_MontoAPagarApdo)
			vrACT_MontoMulta:=vrACT_MontoMulta+$vrACT_MontoRecargo
			vrACT_MontoAPagarApdo:=vrACT_MontoAPagarApdo+vrACT_MontoMulta
		End if 
	: (vt_accion="ReseteaValores")
		ACTfdp_OpcionesRecargos ("inicializaVars")
		[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15:=0
		
	: (vt_accion="CalculaMulaArreglosPago")
		C_REAL:C285($r_idfdp)
		C_DATE:C307($d_fecha)
		$r_idfdp:=$ptr1->
		$d_fecha:=$ptr2->
		ACTfdp_OpcionesRecargos ("CargaVariables";->$r_idfdp)
		If (crPermitirRecargoItem=1)
			For ($i;1;Size of array:C274(alACT_AIDAviso))
				ARRAY LONGINT:C221($DA_Return;0)
				C_REAL:C285($vrACT_SeleccionadoExento;$vrACT_SeleccionadoAfecto)
				
				For ($l_indiceAC;1;Size of array:C274(alACT_AIDAviso))
					alACT_CIdsAvisos{0}:=alACT_AIDAviso{$l_indiceAC}
					AT_SearchArray (->alACT_CIdsAvisos;"=";->$DA_Return)
					For ($l_indice;1;Size of array:C274($DA_Return))
						abACT_ASelectedCargo{$DA_Return{$l_indice}}:=True:C214
					End for 
					If (Size of array:C274($DA_Return)>0)
						$vrACT_SeleccionadoExento:=0
						$vrACT_SeleccionadoAfecto:=0
						$r_monto:=ACTpgs_RetornaMontoXAviso ("MontoDesdeNoAvisos";True:C214;String:C10(alACT_AIDAviso{$l_indiceAC});$d_fecha;->$vrACT_SeleccionadoAfecto;->$vrACT_SeleccionadoExento)
						
						$r_montoMulta:=ACTfdp_OpcionesRecargos ("CargaMontoRecargo";->$r_idfdp;->$r_monto)
						If ($r_montoMulta#0)
							For ($i;1;Size of array:C274(ap_arrays2Pay))
								AT_Insert (0;1;ap_arrays2Pay{$i})
							End for 
							READ ONLY:C145([ACT_Formas_de_Pago:287])
							QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$r_idfdp)
							atACT_CGlosa{Size of array:C274(atACT_CGlosa)}:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15;->[xxACT_Items:179]Glosa:2)
							arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}:=Abs:C99($r_montoMulta)
							arACT_CSaldo{Size of array:C274(arACT_CSaldo)}:=Abs:C99($r_montoMulta)*-1
							alACT_CIdsAvisos{Size of array:C274(alACT_CIdsAvisos)}:=alACT_AIDAviso{$l_indiceAC}
							alACT_CRefs{Size of array:C274(alACT_CRefs)}:=[ACT_Formas_de_Pago:287]Id_Item_Seleccionado:15
							alACT_CIDCtaCte{Size of array:C274(alACT_CIDCtaCte)}:=alACT_CIDCtaCte{$DA_Return{1}}
							atACT_CAlumno{Size of array:C274(atACT_CAlumno)}:=atACT_CAlumno{$DA_Return{1}}
							atACT_MonedaCargo{Size of array:C274(atACT_CAlumno)}:=ST_GetWord (ACT_DivisaPais ;1;";")
						End if 
					End if 
				End for 
			End for 
		End if 
End case 