//%attributes = {}
  //ACTbol_OnExplorerLoad

$recs:=Size of array:C274(alBWR_recordNumber)
$arrayApdo:=Get pointer:C304(atBWR_ArrayNames{3})
READ ONLY:C145([ACT_Boletas:181])
For ($i;1;$recs)
	GOTO RECORD:C242([ACT_Boletas:181];alBWR_recordNumber{$i})
	If ([ACT_Boletas:181]Nula:15)
		AL_SetRowColor (xALP_Browser;$i;"";15*16+8)
		AL_SetRowStyle (xALP_Browser;$i;2)
	Else 
		AL_SetRowColor (xALP_Browser;$i;"";16)
		AL_SetRowStyle (xALP_Browser;$i;0)
	End if 
	If ([ACT_Boletas:181]ID_Tercero:21#0)
		$arrayApdo->{$i}:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]Nombre_Completo:9)
	End if 
End for 
REDUCE SELECTION:C351([ACT_Boletas:181];0)