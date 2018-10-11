//%attributes = {}
  //DBU_DelUnlinked_Subasignaturas

EVS_LoadStyles 
ALL RECORDS:C47([xxSTR_Subasignaturas:83])
CREATE SET:C116([xxSTR_Subasignaturas:83];"All")
CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"linked")

READ ONLY:C145([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero:1;>)
ARRAY LONGINT:C221($aRecNum;0)
SELECTION TO ARRAY:C260([Asignaturas:18];$aRecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Compactando subasignaturas"))

For ($asignaturas;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([Asignaturas:18];$aRecNum{$asignaturas})
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	For ($periodos;1;Size of array:C274(atSTR_Periodos_Nombre))
		AS_PropEval_Lectura ("";$periodos)
		ARRAY TEXT:C222(aText1;Size of array:C274(alAS_EvalPropSourceID))
		For ($ii;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$ii}<0)
				$ref:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($periodos)+"."+String:C10($ii)
				$recNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$ref)
				If ($recNum>=0)
					GOTO RECORD:C242([xxSTR_Subasignaturas:83];$recNum)
					ADD TO SET:C119([xxSTR_Subasignaturas:83];"linked")
				End if 
			End if 
		End for 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$asignaturas/Size of array:C274($aRecNum);__ ("Compactando subasignaturas"))
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
DIFFERENCE:C122("all";"linked";"2delete")
USE SET:C118("2delete")
KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];True:C214;__ ("Eliminado subsasignaturas inutilizadas..."))