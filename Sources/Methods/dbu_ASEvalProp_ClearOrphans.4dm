//%attributes = {}
  //dbu_ASEvalProp_ClearOrphans

CREATE EMPTY SET:C140([XShell_FatObjects:86];"orphans")
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Blob_ConfigNotas@")
While (Not:C34(End selection:C36([XShell_FatObjects:86])))
	$id:=Num:C11(ST_GetWord ([XShell_FatObjects:86]FatObjectName:1;2;"/"))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id)
	If (Records in selection:C76([Asignaturas:18])=0)
		ADD TO SET:C119([XShell_FatObjects:86];"orphans")
	End if 
	NEXT RECORD:C51([XShell_FatObjects:86])
End while 
USE SET:C118("orphans")
KRL_DeleteSelection (->[XShell_FatObjects:86])