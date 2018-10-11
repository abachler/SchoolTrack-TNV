//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WSget_ADT_GetNewPostulations

C_TEXT:C284(vtADT_WSErrorString)
C_TEXT:C284($1;$dataList)

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"dataList")
SOAP DECLARATION:C782(vtADT_WSErrorString;Is text:K8:3;SOAP output:K46:2;"result")

$allowed:=Num:C11(PREF_fGet (0;"ADT Permite postulaciones web";"0"))
If ($allowed=1)
	vtADT_WSErrorString:=ADTweb_ProcessPostulations ($1)
Else 
	vtADT_WSErrorString:="El colegio no permite la postulación via web. Operación abortada."
End if 