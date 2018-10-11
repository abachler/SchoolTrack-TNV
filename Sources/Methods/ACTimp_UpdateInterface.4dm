//%attributes = {}
  //ACTimp_UpdateInterface

AL_SetLine (xALP_PreImport;0)
For ($i;1;Size of array:C274(aPareo))
	If (aAprobado{$i})
		AL_SetRowStyle (xALP_PreImport;$i;0;"")
		AL_SetRowColor (xALP_PreImport;$i;"Black";0;"";0)
	Else 
		AL_SetRowStyle (xALP_PreImport;$i;1;"")
		AL_SetRowColor (xALP_PreImport;$i;"Red";0;"";0)
	End if 
	ARRAY INTEGER:C220($aInteger2D;2;0)
	If (aBloqueadas{$i})
		AL_SetCellEnter (xALP_PreImport;19;$i;39;$i;$aInteger2D;0)
	Else 
		AL_SetCellEnter (xALP_PreImport;19;$i;39;$i;$aInteger2D;1)
	End if 
End for 
_O_DISABLE BUTTON:C193(bDelLinea)
vt_Motivo:=""
$import:=Find in array:C230(aAprobado;True:C214)
  //IT_SetButtonState (($import#-1);->bImport)
OBJECT SET ENABLED:C1123(bImport;($import>-1))  //20170615 RCH
vlACT_CargosImpTotal:=Size of array:C274(aAprobado)
aAprobado{0}:=True:C214
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->aAprobado;"=";->$DA_Return)
vlACT_CargosImpAprobado:=Size of array:C274($DA_Return)
vlACT_CargosImpRechazado:=vlACT_CargosImpTotal-vlACT_CargosImpAprobado