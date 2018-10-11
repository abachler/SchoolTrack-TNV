
Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		C_LONGINT:C283($l_recs)
		ARRAY LONGINT:C221($alACT_posActivos;0)
		ARRAY LONGINT:C221($alACT_posTipoDcto;0)
		ARRAY LONGINT:C221($alACT_posFinales;0)
		
		$b_valorOrg:=abACT_InactivosT{0}
		
		abACT_InactivosT{0}:=False:C215
		AT_SearchArray (->abACT_InactivosT;"=";->$alACT_posActivos)
		
		alACT_DescuentosIdsCFG_T{0}:=alACT_DescuentosIdsCFG_T{lb_descuentosTodos}
		AT_SearchArray (->alACT_DescuentosIdsCFG_T;"=";->$alACT_posTipoDcto)
		
		AT_intersect (->$alACT_posActivos;->$alACT_posTipoDcto;->$alACT_posFinales)
		
		If (Size of array:C274($alACT_posFinales)>1)
			abACT_InactivosT{lb_descuentosTodos}:=True:C214
			CD_Dlog (0;"Solo es posible configurar 1 descuento activo por cada tipo.")
		End if 
		
		$l_descuentoIngresado:=Num:C11(ACTcc_OpcionesDctos ("ObtieneSumaDescuentos";->abACT_InactivosT;->arACT_DescuentosT))
		If ($l_descuentoIngresado>100)
			abACT_InactivosT{lb_descuentosTodos}:=$b_valorOrg
			CD_Dlog (0;"Al activar el descuento, se sobrepasa el 100% de descuento. No es posible activar el descuento.")
		End if 
		
		  //verifica num maximo de descuentos 
		$l_cuantos:=Count in array:C907(abACT_InactivosT;False:C215)
		If (($l_cuantos>lACTcfgdctos_maximoDescuento) & (lACTcfgdctos_maximoDescuento#0))
			abACT_InactivosT{lb_descuentosTodos}:=$b_valorOrg
			CD_Dlog (0;"Al activar el descuento, se sobrepasa el número máximo de descuentos configurados ("+String:C10(lACTcfgdctos_maximoDescuento)+"). No es posible activar el descuento.")
		End if 
		
		
		ACTcc_OpcionesDctos ("CargaResumen")
		
		vb_guardarCambios:=True:C214  //20181005 RCH Ticket 217907
		
End case 