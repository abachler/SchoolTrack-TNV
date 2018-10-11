//%attributes = {}
  //ACTqrymx_SeleccionaPoliza

  //$1 fecha1
  //$2 mostrar mensaje

C_DATE:C307($vd_fecha1;$1)
C_LONGINT:C283($i;$vl_existe)
C_TEXT:C284($0;$vt_retorno)
C_BOOLEAN:C305($vb_mostrarAlerta;$2)

ARRAY TEXT:C222($at_formasPago;0)
ARRAY TEXT:C222($at_codFormasPago;0)
ARRAY TEXT:C222($at_codFormasPago2;0)
ARRAY TEXT:C222($at_formasPagoSeleccionadas;0)

$vd_fecha1:=$1
$vb_mostrarAlerta:=$2
ok:=1
ACTinit_LoadFdPago 

READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=$vd_Fecha1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Venta_Rapida:10=False:C215;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)

If (Records in selection:C76([ACT_Pagos:172])>0)
	AT_DistinctsFieldValues (->[ACT_Pagos:172]forma_de_pago_new:31;->$at_formasPago)
	For ($i;1;Size of array:C274($at_formasPago))
		$vl_existe:=Find in array:C230(atACT_FormasdePago;$at_formasPago{$i})
		If ($vl_existe#-1)
			APPEND TO ARRAY:C911($at_codFormasPago;atACT_FdPCodInterno{$vl_existe})
			If (Find in array:C230($at_codFormasPago2;atACT_FdPCodInterno{$vl_existe})=-1)
				APPEND TO ARRAY:C911($at_codFormasPago2;atACT_FdPCodInterno{$vl_existe})
			End if 
		End if 
	End for 
	If (Size of array:C274($at_codFormasPago2)>1)
		SRtbl_ShowChoiceList (0;"Seleccione el código";0;->bRepositorio;False:C215;->$at_codFormasPago2)
		If (ok=1)
			$at_codFormasPago{0}:=$at_codFormasPago2{choiceIdx}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$at_codFormasPago;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($at_formasPagoSeleccionadas;$at_formasPago{$DA_Return{$i}})
			End for 
			QRY_QueryWithArray (->[ACT_Pagos:172]forma_de_pago_new:31;->$at_formasPagoSeleccionadas;True:C214)
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Venta_Rapida:10=False:C215)
			QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14=False:C215)
		End if 
	Else 
		choiceIdx:=1
	End if 
	
	If (Size of array:C274($at_codFormasPago2)>0)
		$vt_retorno:=Substring:C12($at_codFormasPago2{choiceIdx};1;2)+String:C10(Month of:C24($vd_fecha1);"00")+String:C10(Day of:C23($vd_fecha1);"00")
	End if 
Else 
	If ($vb_mostrarAlerta)
		ok:=0
		CD_Dlog (0;__ ("No hay pagos para el día: ")+String:C10($vd_fecha1))
	End if 
End if 
$0:=$vt_retorno