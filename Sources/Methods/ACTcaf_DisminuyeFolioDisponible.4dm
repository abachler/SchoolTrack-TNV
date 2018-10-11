//%attributes = {}
  //ACTcaf_DisminuyeFolioDisponible

C_BOOLEAN:C305($0;$b_hecho)
C_LONGINT:C283($l_idCAF)

$l_idCAF:=$1

KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;->$l_idCAF;True:C214)
If (ok=1)
	[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]folio_disponible:6-1
	If ([ACT_FoliosDT:293]folio_disponible:6<=[ACT_FoliosDT:293]hasta:5)
		[ACT_FoliosDT:293]estado:3:=1
	Else 
		[ACT_FoliosDT:293]estado:3:=2
	End if 
	SAVE RECORD:C53([ACT_FoliosDT:293])
	$b_hecho:=True:C214
Else 
	If (Records in selection:C76([ACT_FoliosDT:293])=0)
		$b_hecho:=True:C214
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_FoliosDT:293])

$0:=$b_hecho