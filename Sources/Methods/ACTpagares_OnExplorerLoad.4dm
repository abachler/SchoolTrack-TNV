//%attributes = {}
  //ACTpagares_OnExplorerLoad

  //ACTbol_OnExplorerLoad

$recs:=Size of array:C274(alBWR_recordNumber)
$arrayApdo:=Get pointer:C304(atBWR_ArrayNames{3})
READ ONLY:C145([ACT_Pagares:184])
For ($i;1;$recs)
	GOTO RECORD:C242([ACT_Pagares:184];alBWR_recordNumber{$i})
	If ([ACT_Pagares:184]ID_Estado:6=-102)
		AL_SetRowColor (xALP_Browser;$i;"";15*16+8)
		AL_SetRowStyle (xALP_Browser;$i;2)
	Else 
		AL_SetRowColor (xALP_Browser;$i;"";16)
		AL_SetRowStyle (xALP_Browser;$i;0)
	End if 
End for 
REDUCE SELECTION:C351([ACT_Pagares:184];0)