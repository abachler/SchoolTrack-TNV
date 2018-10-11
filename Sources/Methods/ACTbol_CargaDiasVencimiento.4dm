//%attributes = {}
  //ACTbol_CargaDiasVencimiento

C_LONGINT:C283(lACTbol_DiaVencimientoSel)
C_TEXT:C284($t_accion;$t_retorno;$0)
C_POINTER:C301($y_pointer1)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 

Case of 
	: ($t_accion="")
		
		ACTcfg_LeeBlob ("ACT_DocsTributarios")
		
		lACTbol_DiaVencimientoSel:=lACTbol_DiaVencimiento
		
	: ($t_accion="CargaVars")
		
		ACTbol_CargaDiasVencimiento ("")
		
		C_DATE:C307(vdACT_FVencimientoBol)
		C_TEXT:C284(vtACT_FVencimientoBol)
		If (vdACT_FEmisionBol#!00-00-00!)
			vdACT_FVencimientoBol:=Add to date:C393(vdACT_FEmisionBol;0;0;lACTbol_DiaVencimientoSel)
		Else 
			vdACT_FVencimientoBol:=vdACT_FEmisionBol
		End if 
		vtACT_FVencimientoBol:=String:C10(vdACT_FVencimientoBol;7)
		
	: ($t_accion="ValidaVencimiento")
		lACTbol_DiaVencimientoSel:=vdACT_FVencimientoBol-vdACT_FEmisionBol
		If ((lACTbol_DiaVencimientoSel<0) | (vdACT_FEmisionBol=!00-00-00!))  //si es fecha menor, se asigna la misma
			ACTbol_CargaDiasVencimiento ("CargaVars")
			BEEP:C151
			$t_retorno:="1"
		Else 
			$t_retorno:="2"
		End if 
		
	: ($t_accion="ValidaCambioFecha")
		$b_valida:=(ACTbol_CargaDiasVencimiento ("ValidaVencimiento")="2")
		If (Not:C34($b_valida))
			$y_pointer1->:=!00-00-00!
		End if 
End case 

$0:=$t_retorno