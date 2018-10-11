//%attributes = {}
  //ACTcc_CargasALPCtasCtes

C_TEXT:C284($vt_yearHist)
$ALPActualizar:=$1
If (Count parameters:C259>=2)
	$vt_yearHist:=$2
End if 

Case of 
	: ($ALPActualizar=3)
		$tipoTrans:=Selected list items:C379(hlTab_ACT_Transacciones)
		AL_UpdateArrays (xALP_Transacciones;0)
		ACTcc_LoadTransacciones ($tipoTrans)
		AL_UpdateArrays (xALP_Transacciones;-2)
		AL_SetLine (xALP_Transacciones;0)
	: ($ALPActualizar=4)
		$RnCta:=Record number:C243([ACT_CuentasCorrientes:175])
		$RnAl:=Record number:C243([Alumnos:2])
		AL_UpdateArrays (xALP_Documentos;0)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTcc_LoadBoletas ($vt_yearHist)
		AL_UpdateArrays (xALP_Documentos;-2)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
		AL_SetLine (xALP_Documentos;1)
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RnCta)
		  //GOTO RECORD([Alumnos];$RnAl)
		KRL_GotoRecord (->[Alumnos:2];$RnAl)
		
	: ($ALPActualizar=5)
		AL_UpdateArrays (xALP_Pagos;0)
		AL_UpdateArrays (xALP_DesglosePago;0)
		ACTcc_LoadPagos ($vt_yearHist)
		AL_UpdateArrays (xALP_DesglosePago;-2)
		AL_UpdateArrays (xALP_Pagos;-2)
		For ($i;1;Size of array:C274(aACT_CtasPFecha))
			If (aACT_CtasPNulo{$i})
				AL_SetRowColor (xALP_Pagos;$i;"";15*16+8)
				AL_SetRowStyle (xALP_Pagos;$i;2)
			Else 
				AL_SetRowColor (xALP_Pagos;$i;"";16)
				AL_SetRowStyle (xALP_Pagos;$i;0)
			End if 
		End for 
		AL_UpdateArrays (xALP_Pagos;-1)
		For ($i;1;Size of array:C274(aIDCta))
			If (aIDCta{$i}=[ACT_CuentasCorrientes:175]ID:1)
				AL_SetRowColor (xALP_DesglosePago;$i;"";7;"";0)
			Else 
				AL_SetRowColor (xALP_DesGlosePago;$i;"";0;"";0)
			End if 
		End for 
		AL_UpdateArrays (xALP_DesglosePago;-1)
	: ($ALPActualizar=6)
		AL_UpdateArrays (xALP_Observaciones;0)
		ACTcc_LoadObs (vt_ObsDesde;vt_ObsHasta)
		AL_UpdateArrays (xALP_Observaciones;-2)
		AL_SetLine (xALP_Observaciones;0)
End case 