//%attributes = {}
  //ACTpgs_ArreglosAgrupado

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglos")
		ARRAY PICTURE:C279(apACT_ASelectedAgrupado;0)
		ARRAY LONGINT:C221(alACT_AYearAgrupado;0)
		ARRAY TEXT:C222(atACT_AMesAgrupado;0)
		ARRAY REAL:C219(arACT_AMontoXAgrupado;0)
		ARRAY REAL:C219(arACT_AMontoSelXAgrup;0)
		ARRAY BOOLEAN:C223(abACT_ASelectedAgrupado;0)
		ARRAY TEXT:C222(atACT_YearMonthAgrupado;0)
		
	: ($vt_accion="EliminaElementosNoSeleccionados")
		AT_Delete ($ptr1->;1;->apACT_ASelectedAgrupado;->alACT_AYearAgrupado;->atACT_AMesAgrupado;->arACT_AMontoXAgrupado;->arACT_AMontoSelXAgrup;->abACT_ASelectedAgrupado;->atACT_YearMonthAgrupado)
		
	: ($vt_accion="SubirElement")
		ACTit_MoveElementALP (ALP_AvisosAgrupadosXPagar;1;->apACT_ASelectedAgrupado;->alACT_AYearAgrupado;->atACT_AMesAgrupado;->arACT_AMontoXAgrupado;->arACT_AMontoSelXAgrup;->abACT_ASelectedAgrupado;->atACT_YearMonthAgrupado)
		
	: ($vt_accion="bajarElemento")
		ACTit_MoveElementALP (ALP_AvisosAgrupadosXPagar;0;->apACT_ASelectedAgrupado;->alACT_AYearAgrupado;->atACT_AMesAgrupado;->arACT_AMontoXAgrupado;->arACT_AMontoSelXAgrup;->abACT_ASelectedAgrupado;->atACT_YearMonthAgrupado)
		
	: ($vt_accion="InsertaElemento")
		AT_Insert ($ptr1->;1;->apACT_ASelectedAgrupado;->alACT_AYearAgrupado;->atACT_AMesAgrupado;->arACT_AMontoXAgrupado;->arACT_AMontoSelXAgrup;->abACT_ASelectedAgrupado;->atACT_YearMonthAgrupado)
		
	: ($vt_accion="SetAreaList")
		C_LONGINT:C283($Error)
		
		AT_Inc (0)
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"apACT_ASelectedAgrupado";__ ("Pagar/No Pagar");100;"1")
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"alACT_AYearAgrupado";__ ("Año");105;"######";2)
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"atACT_AMesAgrupado";__ ("Mes");200)
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"arACT_AMontoXAgrupado";__ ("Monto del período");170;"|Despliegue_ACT_Pagos")
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"arACT_AMontoSelXAgrup";__ ("Monto(s) Seleccionado(s)");170;"|Despliegue_ACT_Pagos")
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"abACT_ASelectedAgrupado";"")
		$Error:=ALP_DefaultColSettings (ALP_AvisosAgrupadosXPagar;AT_Inc ;"atACT_YearMonthAgrupado";"")
		
		  //general options
		ALP_SetDefaultAppareance (ALP_AvisosAgrupadosXPagar;9;1;6;2;8)
		AL_SetColOpts (ALP_AvisosAgrupadosXPagar;1;1;1;2;0)
		AL_SetRowOpts (ALP_AvisosAgrupadosXPagar;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_AvisosAgrupadosXPagar;0;1;1)
		AL_SetMainCalls (ALP_AvisosAgrupadosXPagar;"";"")
		AL_SetScroll (ALP_AvisosAgrupadosXPagar;0;-3)
		AL_SetEntryOpts (ALP_AvisosAgrupadosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (ALP_AvisosAgrupadosXPagar;0;30;0)
		  //xALSet_ACT_AvisosAgrupadosPagos
End case 