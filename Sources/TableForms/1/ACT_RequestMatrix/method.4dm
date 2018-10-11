If (Form event:C388=On Load:K2:1)
	XS_SetInterface 
	If (Size of array:C274(atACT_Matrices)=1)
		vsACT_Matriz:="No hay matrices disponibles"
		vlACT_IDMatriz:=0
		_O_DISABLE BUTTON:C193(bOK)
	Else 
		$i:=1
		While (Substring:C12(atACT_Matrices{$i};1;1)="(")
			$i:=$i+1
		End while 
		vsACT_Matriz:=atACT_Matrices{$i}
		vlACT_IDMatriz:=<>alACT_MatrixID{$i}
	End if 
	iresult:=1
	WDW_SlideDrawer (->[xxSTR_Constants:1];"ACT_RequestMatrix")
End if 
