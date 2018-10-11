//%attributes = {}
  //ACTcc_BorrarCargo

$idCargo:=Num:C11($1)
$0:=True:C214

READ WRITE:C146([ACT_Cargos:173])
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$idCargo)
If (Not:C34(Locked:C147([ACT_Cargos:173])))
	DELETE RECORD:C58([ACT_Cargos:173])
Else 
	$0:=False:C215
End if 
UNLOAD RECORD:C212([ACT_Cargos:173])
READ ONLY:C145([ACT_Cargos:173])