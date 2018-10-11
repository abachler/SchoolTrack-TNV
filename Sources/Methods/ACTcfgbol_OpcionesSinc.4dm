//%attributes = {}
  //ACTcfgbol_OpcionesSinc

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1;$ptr2)
C_LONGINT:C283($index;$Proxima;$el)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

Case of 
	: ($vt_accion="SetObjects")
		AL_UpdateArrays (ALP_TiposdeDoc;0)
		xALPSet_ACT_TiposdeDoc 
		If (cb_Sincroniza=0)
			C_TEXT:C284($vt_text)
			C_LONGINT:C283($vl_long)
			AT_Populate (->atACT_DTSinc;->$vt_text)
			AT_Populate (->alACT_IdDTSinc;->$vl_long)
		End if 
		AL_UpdateArrays (ALP_TiposdeDoc;-2)
		
	: ($vt_accion="SincronizaNumeracion")
		If (cb_Sincroniza=1)
			$index:=$ptr1->
			$Proxima:=$ptr2->
			If (alACT_IdDTSinc{$index}#0)
				$el:=Find in array:C230(alACT_IDDT;alACT_IdDTSinc{$index})
				If ($el#-1)
					If (alACT_Proxima{$el}#$Proxima)
						alACT_Proxima{$el}:=$Proxima
						ACTcfgbol_OpcionesSinc ("SincronizaNumeracion";->$el;->$Proxima)
					End if 
				Else 
					alACT_IdDTSinc{$index}:=0
					atACT_DTSinc{$index}:=""
				End if 
			End if 
		End if 
		
End case 