//%attributes = {}
  //AS_FijaNivelJeraquicoHijas

C_LONGINT:C283($1;$recNum;$recNumM)
$recNumM:=$1
KRL_GotoRecord (->[Asignaturas:18];$recNumM)
$orden:=[Asignaturas:18]ordenGeneral:105
$nivelJerarquico:=[Asignaturas:18]nivel_jerarquico:107+1
$setName:="Asignaturas_Nivel#"+String:C10($nivelJerarquico)

CREATE EMPTY SET:C140([Asignaturas:18];$setName)
If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	For ($iPeriodos;1;Size of array:C274(atSTR_Periodos_Nombre))
		KRL_GotoRecord (->[Asignaturas:18];$recNumM)
		AS_PropEval_Lectura ("";aiSTR_Periodos_Numero{$iPeriodos})
		For ($iColumnas;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$icolumnas}>0)
				$recNum:=Find in field:C653([Asignaturas:18]Numero:1;alAS_EvalPropSourceID{$icolumnas})
				  //If ($recNum>=0)
				If (($recNum>=0) & ($recNum#$recNumM))
					KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
					[Asignaturas:18]nivel_jerarquico:107:=$nivelJerarquico
					[Asignaturas:18]ordenGeneral:105:=$orden+"."+String:C10($iColumnas;"000")
					SAVE RECORD:C53([Asignaturas:18])
					ADD TO SET:C119([Asignaturas:18];$setName)
					UNLOAD RECORD:C212([Asignaturas:18])
				End if 
			End if 
		End for 
	End for 
Else 
	AS_PropEval_Lectura 
	For ($iColumnas;1;Size of array:C274(alAS_EvalPropSourceID))
		If (alAS_EvalPropSourceID{$icolumnas}>0)
			$recNum:=Find in field:C653([Asignaturas:18]Numero:1;alAS_EvalPropSourceID{$icolumnas})
			If (($recNum>=0) & ($recNum#$recNumM))
				KRL_GotoRecord (->[Asignaturas:18];$recNum;True:C214)
				[Asignaturas:18]ordenGeneral:105:=$orden+"."+String:C10($iColumnas;"000")
				[Asignaturas:18]nivel_jerarquico:107:=$nivelJerarquico
				SAVE RECORD:C53([Asignaturas:18])
				ADD TO SET:C119([Asignaturas:18];$setName)
				UNLOAD RECORD:C212([Asignaturas:18])
			End if 
		End if 
	End for 
End if 

USE SET:C118($setName)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	AS_FijaNivelJeraquicoHijas ($aRecNums{$i})
End for 

