//%attributes = {}
  // Método: dbu_LimpiaRegistrosPropEvals
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/07/10, 20:09:28
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
  //dbu_LimpiaRegistrosPropEvals

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="Blob_ConfigNotas@")
CREATE EMPTY SET:C140([XShell_FatObjects:86];"toDelete")
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([XShell_FatObjects:86];$aRecNums{$i})
	$id:=Num:C11(ST_GetWord ([XShell_FatObjects:86]FatObjectName:1;2;"/"))
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$id)
	If ($recNum<0)  //si la asignatura no exiiste el registro de propiedades es huerfano.
		ADD TO SET:C119([XShell_FatObjects:86];"toDelete")
	End if 
End for 


USE SET:C118("toDelete")
KRL_DeleteSelection (->[XShell_FatObjects:86])




