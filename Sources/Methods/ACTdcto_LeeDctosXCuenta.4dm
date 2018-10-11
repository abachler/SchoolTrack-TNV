//%attributes = {}
  //ACTdcto_LeeDctosXCuenta
C_LONGINT:C283($0)
C_LONGINT:C283($l_idDcto)

READ WRITE:C146([ACT_CFG_DctosIndividuales:229])

ACTqry_CargoEspecial (10)
$l_idDcto:=-1

KRL_FindAndLoadRecordByIndex (->[ACT_CFG_DctosIndividuales:229]ID:1;->$l_idDcto)
If (Records in selection:C76([ACT_CFG_DctosIndividuales:229])=0)
	CREATE RECORD:C68([ACT_CFG_DctosIndividuales:229])
	[ACT_CFG_DctosIndividuales:229]ID:1:=$l_idDcto
	[ACT_CFG_DctosIndividuales:229]Id_Item_de_Cargo:7:=[xxACT_Items:179]ID:1
	[ACT_CFG_DctosIndividuales:229]Nombre:5:="Descuento por cuenta"
	[ACT_CFG_DctosIndividuales:229]Orden:8:=1
	SAVE RECORD:C53([ACT_CFG_DctosIndividuales:229])
	
End if 
KRL_UnloadReadOnly (->[ACT_CFG_DctosIndividuales:229])
KRL_FindAndLoadRecordByIndex (->[ACT_CFG_DctosIndividuales:229]ID:1;->$l_idDcto)

$0:=Records in selection:C76([ACT_CFG_DctosIndividuales:229])