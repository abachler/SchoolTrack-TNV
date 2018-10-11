ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY TEXT:C222(aQR_Text1;0)
ACTqry_Items ("CargosNoRelativosNoEspeciales";->[xxACT_Items:179]ID:1;->aQR_Longint1)

AT_Difference (->aQR_Longint1;->alACTcfg_IdItemMatricula;->aQR_Longint2)
For ($i;1;Size of array:C274(aQR_Longint2))
	$vl_idItem:=aQR_Longint2{$i}
	KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
	If (Records in selection:C76([xxACT_Items:179])=1)
		APPEND TO ARRAY:C911(aQR_Text1;[xxACT_Items:179]Glosa:2)
	End if 
End for 

ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;1)
<>aChoicePtrs{1}:=->aQR_Text1
TBL_ShowChoiceList (0;"Seleccione los ítems";2;->bInsertLineI;True:C214)
If (ok=1)
	AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;0)
	For ($i;1;Size of array:C274(aLinesSelected))
		$vl_idItem:=aQR_Longint2{aLinesSelected{$i}}
		APPEND TO ARRAY:C911(alACTcfg_IdItemMatricula;$vl_idItem)
		
		  //20120723 RCH Se registran cambios en conf
		$vt_log:="Inserción de Ítems Matrícula. ID Ítem agregado: "+String:C10(alACTcfg_IdItemMatricula{Size of array:C274(alACTcfg_IdItemMatricula)})+"."
		ACTcfg_ItemsMatricula ("AgregaLogItemsMatricula";->$vt_log)
	End for 
	ACTcfg_ItemsMatricula ("LlenaGlosas";->alACTcfg_IdItemMatricula;->atACTcfg_GlosaItemMatricula)
	AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;-2)
	AT_Initialize (->aQR_Longint1;->aQR_Longint2;->aQR_Text1)
End if 
ACTcfg_ItemsMatricula ("SeteaEstadosObjetosCfg")
