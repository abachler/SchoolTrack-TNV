//%attributes = {}
  //SRcust_AutoCode

C_BOOLEAN:C305($setScripts;$showOptions)

$l_refArea:=$1


If (Application version:C493>="15@")
	$l_esSRP:=SR_GetLongProperty ($l_refArea;1;SRP_Area_IsArea)
	$t_areaName:=SR_GetTextProperty ($l_refArea;1;SRP_Area_Name)
	vlQR_MainTable:=SRP_LeeTablaInforme ($l_refArea)
	
	
Else 
	vlQR_MainTable:=999
	$l_error:=SR Main Table2 ($l_refArea;0;vlQR_MainTable;"")
	
End if 
If (vlQR_MainTable=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
	SRcb_EvaluacionAprendizajes ($area;-1;-1;-1)
End if 