//%attributes = {}
  //MNU_ResourceEditor

If (<>lXS_ResourceEditorProcessID<=0)
	<>lXS_ResourceEditorProcessID:=New process:C317("LOC_ResourceEditor";Pila_256K;"Editor de Recursos")
Else 
	If (Process state:C330(<>lXS_ResourceEditorProcessID)>=0)
		SHOW PROCESS:C325(<>lXS_ResourceEditorProcessID)
		BRING TO FRONT:C326(<>lXS_ResourceEditorProcessID)
	Else 
		<>lXS_ResourceEditorProcessID:=New process:C317("LOC_ResourceEditor";Pila_256K;"Editor de Listas")
	End if 
End if 