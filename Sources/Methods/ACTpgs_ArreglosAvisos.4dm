//%attributes = {}
  //ACTpgs_ArreglosAvisos

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACT_AIDAviso;0)
		ARRAY DATE:C224(adACT_AFechaEmision;0)
		ARRAY DATE:C224(adACT_AFechaVencimiento;0)
		ARRAY REAL:C219(arACT_ASaldoAnterior;0)
		ARRAY REAL:C219(arACT_AIntereses;0)
		ARRAY REAL:C219(arACT_AMontoaPagar;0)
		ARRAY TEXT:C222(atACT_AMoneda;0)
		ARRAY REAL:C219(arACT_AMontoMoneda;0)
		ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
		ARRAY BOOLEAN:C223(abACT_ASelectedAvisos;0)
		ARRAY PICTURE:C279(apACT_ASelectedAvisos;0)
		ARRAY REAL:C219(arACT_AMontoAfecto;0)
		ARRAY REAL:C219(arACT_AMontoBruto;0)
		ARRAY REAL:C219(arACT_AMontoIVA;0)
		ARRAY REAL:C219(arACT_AMontoNeto;0)
		ARRAY LONGINT:C221(alACT_AIDAvisoOrder;0)
		ARRAY REAL:C219(arACT_AMontoSeleccionado;0)
		  //20120724 RCH Se agrega columna a ventana de pagos
		ARRAY LONGINT:C221(alACT_ANoPagare;0)
		
	: ($vt_accion="EliminaElementosNoSeleccionados")
		AT_Delete ($ptr1->;1;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoAfecto;->arACT_AMontoBruto;->arACT_AMontoIVA;->arACT_AMontoNeto;->alACT_AIDAvisoOrder;->arACT_AMontoSeleccionado;->alACT_ANoPagare)
		
	: ($vt_accion="SubirAviso")
		ACTit_MoveElementALP (ALP_AvisosXPagar;1;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoAfecto;->arACT_AMontoBruto;->arACT_AMontoIVA;->arACT_AMontoNeto;->alACT_AIDAvisoOrder;->arACT_AMontoSeleccionado;->alACT_ANoPagare)
		
	: ($vt_accion="bajarAviso")
		ACTit_MoveElementALP (ALP_AvisosXPagar;0;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoAfecto;->arACT_AMontoBruto;->arACT_AMontoIVA;->arACT_AMontoNeto;->alACT_AIDAvisoOrder;->arACT_AMontoSeleccionado;->alACT_ANoPagare)
		
	: ($vt_accion="InsertaElemento")
		AT_Insert ($ptr1->;1;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoAfecto;->arACT_AMontoBruto;->arACT_AMontoIVA;->arACT_AMontoNeto;->alACT_AIDAvisoOrder;->arACT_AMontoSeleccionado;->alACT_ANoPagare)
		
End case 