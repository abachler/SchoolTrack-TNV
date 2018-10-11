//%attributes = {}
  //ACTcc_BorrarDescto

$idDescto:=Num:C11($1)
$0:=True:C214

READ WRITE:C146([xxACT_DesctosXItem:103])
QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID:1=$idDescto)
If (Not:C34(Locked:C147([xxACT_DesctosXItem:103])))
	DELETE RECORD:C58([xxACT_DesctosXItem:103])
Else 
	$0:=False:C215
End if 
KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])