Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(aEvPrintMode;0)
		LIST TO ARRAY:C288("STR_ModosEvaluacion";aEvPrintMode)
		AT_Insert (1;2;->aEvPrintMode)
		aEvPrintMode{1}:=__ ("Modo de la asignatura")
		aEvPrintMode{2}:="-"
		aEvPrintMode:=1
		iSelectedPrintMode:=Self:C308->
	: (Self:C308->>0)
		
		If (Self:C308->=1)
			iSelectedPrintMode:=iPrintMode
		Else 
			iSelectedPrintMode:=Self:C308->-2
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		iSelectedPrintMode:=Self:C308->-2
End case 