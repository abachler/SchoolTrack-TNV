//%attributes = {}
  //ACTbol_ValidaEmisionDT

C_LONGINT:C283($vl_idBoleta;$1;$x)
C_REAL:C285($vr_montoCargos;$vr_montoBoleta;$vr_decimal)
C_BOOLEAN:C305($vb_retorno)
  //20131115 RCH Error con decimales en BD MX
C_TEXT:C284($t_monedaPais)
C_REAL:C285($r_decimales)

$vl_idBoleta:=$1
If ($vl_idBoleta>0)
	  //$t_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
	  //$r_decimales:=Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaPais))
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta)
	
	$t_monedaDT:=[ACT_Boletas:181]Moneda:53
	If ($t_monedaDT="")
		$t_monedaDT:=<>vtACT_monedaPais
	End if 
	$r_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_monedaDT))
	
	
	If (Records in selection:C76([ACT_Boletas:181])=1)
		  //$vr_montoBoleta:=[ACT_Boletas]Monto_Total
		$vr_montoBoleta:=Round:C94([ACT_Boletas:181]Monto_Total:6;$r_decimales)
		ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)
		ARRAY LONGINT:C221($alACT_recNumCargos;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
		$vr_montoCargos:=0
		For ($x;1;Size of array:C274($alACT_recNumCargos))
			GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargos{$x})
			  //$vr_montoCargos:=$vr_montoCargos+ACTbol_GetMontoLinea ("transacciones")
			$vr_montoCargos:=Round:C94($vr_montoCargos+ACTbol_GetMontoLinea ("transacciones");$r_decimales)
		End for 
		SET_ClearSets ("transacciones")
		
		If ($vr_montoBoleta=$vr_montoCargos)
			$vb_retorno:=True:C214
			If (<>gCountryCode="cl")
				$vr_decimal:=Dec:C9($vr_montoBoleta)
				If ($vr_decimal#0)
					$vb_retorno:=False:C215
				End if 
				
			End if 
			
		Else 
			$vb_retorno:=False:C215
		End if 
		
	Else 
		$vb_retorno:=False:C215
	End if 
	
Else 
	$vb_retorno:=False:C215
End if 

$0:=$vb_retorno