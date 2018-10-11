$currPage:=FORM Get current page:C276
If ($currPage=1)
	OBJECT SET TITLE:C194(Self:C308->;__ ("Volver"))
	FORM GOTO PAGE:C247(2)
Else 
	OBJECT SET TITLE:C194(Self:C308->;__ ("Observaciones"))
	FORM GOTO PAGE:C247(1)
End if 
