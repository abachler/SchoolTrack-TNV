//%attributes = {}
C_TEXT:C284($vt_yearHist)
If (Count parameters:C259=1)
	$vt_yearHist:=$1
End if 
AL_UpdateArrays (xALP_DocsTributarios;0)
ACTpp_LoadDocsTributarios ($vt_yearHist;->[ACT_Terceros:138]Id:1)
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

$0:=1