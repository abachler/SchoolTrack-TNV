//%attributes = {}
  //ACTpgs_ArreglosItems

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglos")
		ARRAY PICTURE:C279(apACT_ASelectedItem;0)
		ARRAY LONGINT:C221(alACT_RefItem;0)
		ARRAY TEXT:C222(atACT_GlosaItem;0)
		ARRAY REAL:C219(arACT_MontoXItem;0)
		ARRAY BOOLEAN:C223(abACT_ASelectedItem;0)
		ARRAY REAL:C219(arACT_AMontoSeleccionadoXI;0)
		
	: ($vt_accion="EliminaElementosNoSeleccionados")
		AT_Delete ($ptr1->;1;->apACT_ASelectedItem;->alACT_RefItem;->atACT_GlosaItem;->arACT_MontoXItem;->abACT_ASelectedItem;->arACT_AMontoSeleccionadoXI)
		
	: ($vt_accion="SubirElemento")
		ACTit_MoveElementALP (ALP_ItemsXPagar;1;->apACT_ASelectedItem;->alACT_RefItem;->atACT_GlosaItem;->arACT_MontoXItem;->abACT_ASelectedItem;->arACT_AMontoSeleccionadoXI)
		
	: ($vt_accion="bajarElemento")
		ACTit_MoveElementALP (ALP_ItemsXPagar;0;->apACT_ASelectedItem;->alACT_RefItem;->atACT_GlosaItem;->arACT_MontoXItem;->abACT_ASelectedItem;->arACT_AMontoSeleccionadoXI)
		
	: ($vt_accion="InsertaElemento")
		AT_Insert ($ptr1->;1;->apACT_ASelectedItem;->alACT_RefItem;->atACT_GlosaItem;->arACT_MontoXItem;->abACT_ASelectedItem;->arACT_AMontoSeleccionadoXI)
		
End case 