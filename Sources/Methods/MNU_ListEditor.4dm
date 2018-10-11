//%attributes = {}
  //MNU_ListEditor

C_LONGINT:C283(<>lXS_ListEditorProcessID)
If (<>lXS_ListEditorProcessID<=0)
	<>lXS_ListEditorProcessID:=New process:C317("HL_ListEditor";Pila_256K;"Editor de Listas")
Else 
	If (Process state:C330(<>lXS_ListEditorProcessID)>=0)
		SHOW PROCESS:C325(<>lXS_ListEditorProcessID)
		BRING TO FRONT:C326(<>lXS_ListEditorProcessID)
	Else 
		<>lXS_ListEditorProcessID:=New process:C317("HL_ListEditor";Pila_256K;"Editor de Listas")
	End if 
End if 