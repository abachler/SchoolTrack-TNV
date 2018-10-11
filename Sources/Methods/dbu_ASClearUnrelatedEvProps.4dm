//%attributes = {}
  //dbu_ASClearUnrelatedEvProps

READ ONLY:C145([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIDAsignatura)
SORT ARRAY:C229($aIDAsignatura;>)

CREATE EMPTY SET:C140([XShell_FatObjects:86];"unrelated")
$fatObjectName:="Blob_ConfigNotas/"+"@"
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatObjectName)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$aRecNums;"")

For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([XShell_FatObjects:86];$aRecNums{$i})
	$idAsignatura:=ST_GetWord ([XShell_FatObjects:86]FatObjectName:1;2;"/")
	$el:=Find in array:C230($aIDAsignatura;Num:C11($idAsignatura))
	If ($el<0)
		ADD TO SET:C119([XShell_FatObjects:86];"unrelated")
	End if 
End for 
USE SET:C118("unrelated")
READ WRITE:C146([XShell_FatObjects:86])
DELETE SELECTION:C66([XShell_FatObjects:86])
READ ONLY:C145([XShell_FatObjects:86])