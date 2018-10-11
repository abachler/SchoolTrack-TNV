//%attributes = {}
  //xALP_ADT_EX_Jornadas

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($col;$row)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Presentations;$col;$row)
	If ($col=5)
		$prof:=Find in array:C230(atADT_Entrevistadores;atPST_Encargado{$row})
		If ($prof#-1)
			aiADT_IDEntrevistador{$row}:=alADT_IDFuncEn{$prof}
		End if 
	End if 
	  //AL_ExitCell (xALP_Presentations)
	PST_SaveParameters 
End if 