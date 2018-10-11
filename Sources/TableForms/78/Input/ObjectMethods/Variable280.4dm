C_LONGINT:C283($table)
$item:=Selected list items:C379(Self:C308->)
If ($item=3)
	If (Picture size:C356([Familia:78]Fotografia:35)>0)
		$table:=Table:C252(->[Familia:78])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+".jpg"
		vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		If (Picture size:C356(vp_Picture)=0)
			vp_Picture:=[Familia:78]Fotografia:35
		End if 
		SET PICTURE TO PASTEBOARD:C521(vp_Picture)
	Else 
		vp_Picture:=vp_Picture*0
	End if 
End if 
FORM GOTO PAGE:C247($item)
