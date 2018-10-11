//%attributes = {}
XALSet_PP_ACT_AreaPagos 
C_TEXT:C284($vt_yearHist)

If (Count parameters:C259=1)
	$vt_yearHist:=$1
End if 

AL_UpdateArrays (xALP_Pagos;0)
AL_UpdateArrays (xALP_DesglosePago;0)
ACTpp_LoadPagos ($vt_yearHist;"terceros")
AL_UpdateArrays (xALP_Pagos;-2)
AL_UpdateArrays (xALP_DesglosePago;-2)

For ($i;1;Size of array:C274(aACT_ApdosPFecha))
	If (aACT_ApdosPNulo{$i})
		AL_SetRowColor (xALP_Pagos;$i;"";15*16+8)
		AL_SetRowStyle (xALP_Pagos;$i;2)
	Else 
		AL_SetRowColor (xALP_Pagos;$i;"";16)
		AL_SetRowStyle (xALP_Pagos;$i;0)
	End if 
End for 
AL_UpdateArrays (xALP_Pagos;-1)

$0:=1