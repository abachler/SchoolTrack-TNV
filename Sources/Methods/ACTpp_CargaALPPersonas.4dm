//%attributes = {}
  //ACTpp_CargaALPPersonas

C_LONGINT:C283($1;$ALPActualizar)
C_TEXT:C284($vt_yearHist)
$ALPActualizar:=$1
If (Count parameters:C259>=2)
	$vt_yearHist:=$2
End if 

ACTpp_HabDesHabAcciones (False:C215)
Case of 
	: ($ALPActualizar=3)
		$tipoTrans:=Selected list items:C379(hlTab_ACT_Transacciones)
		AL_UpdateArrays (xALP_Transacciones;0)
		ACTpp_LoadTransacciones ($tipoTrans)
		AL_UpdateArrays (xALP_Transacciones;-2)
		AL_SetLine (xALP_Transacciones;0)
	: ($ALPActualizar=4)
		AL_UpdateArrays (xALP_Documentos;0)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTpp_LoadBoletas ($vt_yearHist)
		AL_UpdateArrays (xALP_Documentos;-2)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
	: ($ALPActualizar=5)
		AL_UpdateArrays (xALP_Pagos;0)
		AL_UpdateArrays (xALP_DesglosePago;0)
		ACTpp_LoadPagos ($vt_yearHist)
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
	: ($ALPActualizar=6)
		AL_UpdateArrays (xALP_DocsTributarios;0)
		ACTpp_LoadDocsTributarios ($vt_yearHist)
		AL_UpdateArrays (xALP_DocsTributarios;-2)
		$line:=AL_GetLine (xALP_DocsTributarios)
		IT_SetButtonState (($line#0);->bAnular)
		For ($i;1;Size of array:C274(abACT_ApdosDTNula))
			If (abACT_ApdosDTNula{$i})
				AL_SetRowColor (xALP_DocsTributarios;$i;"";15*16+8)
				AL_SetRowStyle (xALP_DocsTributarios;$i;2)
			Else 
				AL_SetRowColor (xALP_DocsTributarios;$i;"";16)
				AL_SetRowStyle (xALP_DocsTributarios;$i;0)
			End if 
		End for 
	: ($ALPActualizar=7)
		AL_UpdateArrays (xALP_DocsenCartera;0)
		ACTpp_LoadDocsenCartera (1)
		AL_UpdateArrays (xALP_DocsenCartera;-2)
		ACTdc_OnExplorerLoad (xALP_DocsenCartera;->aACT_ApdosDCarRecNum)
		atACT_TipoDocumentoCartera:=1
		vsACT_TipoDocumento:=atACT_TipoDocumentoCartera{1}
		AL_SetLine (xALP_DocsenCartera;0)
	: ($ALPActualizar=8)
		AL_UpdateArrays (xALP_DocsDepositados;0)
		ACTpp_LoadDocsDepositados ($vt_yearHist)
		AL_UpdateArrays (xALP_DocsDepositados;-2)
		AL_SetLine (xALP_DocsDepositados;0)
	: ($ALPActualizar=9)
		AL_UpdateArrays (xALP_Observaciones;0)
		ACTpp_LoadObs (vt_ObsDesde;vt_ObsHasta)
		AL_UpdateArrays (xALP_Observaciones;-2)
		AL_SetLine (xALP_Observaciones;0)
	: ($ALPActualizar=10)
		AL_UpdateArrays (xALP_Pagares;0)
		AL_UpdateArrays (xALP_PagareCuotas;0)
		ACTpp_OpcionesPagares ("CargaArreglos")
		AL_UpdateArrays (xALP_Pagares;-2)
		
		ACTcfg_OpcionesPagares ("SetEstilos")
		
		If (Size of array:C274(alACTp_IDPagare)>0)
			AL_SetLine (xALP_Pagares;1)
		Else 
			AL_SetLine (xALP_Pagares;0)
		End if 
		$line:=AL_GetLine (xALP_Pagares)
		$vl_idPagare:=alACTp_IDPagare{$line}
		ACTpp_OpcionesPagares ("CargaDesglosePagare";->$vl_idPagare)
		AL_UpdateArrays (xALP_PagareCuotas;-2)
		AL_SetLine (xALP_PagareCuotas;0)
End case 
