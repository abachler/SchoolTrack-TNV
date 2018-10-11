//%attributes = {}
  //xALP_CB_EX_Resources

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell ($1;$col;$row)
	If (Length:C16(atXS_selectedLangageTexts{$row})>255)
		CD_Dlog (0;__ ("El largo del texto de un item de recurso STR# no puede ser superior a 255 caracteres."))
		$0:=False:C215
	End if 
End if 