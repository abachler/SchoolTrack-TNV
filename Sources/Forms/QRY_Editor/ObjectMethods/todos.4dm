If (wSrchInSel=False:C215)
	ALL RECORDS:C47(vyQRY_TablePointer->)
End if 
dhQF_RefineQuery 
$found:=Records in selection:C76(vyQRY_TablePointer->)
If ($found#0)
	ACCEPT:C269
Else 
	CD_Dlog (0;__ ("Ningún registro cumple con las condiciones especificadas en la fórmula de búsqueda.\rVerifique si la fórmula es correcta.");__ (""))
End if 

