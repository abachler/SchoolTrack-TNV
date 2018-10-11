ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY TEXT:C222(aQR_Text1;0)
ARRAY LONGINT:C221(aQR_Longint3;0)
ACTqry_Items ("CargosNoEspeciales";->[xxACT_Items:179]ID:1;->aQR_Longint1)

AT_Difference (->aQR_Longint1;->alACT_TerIdItem;->aQR_Longint2)
For ($i;1;Size of array:C274(aQR_Longint2))
	$vl_idItem:=aQR_Longint2{$i}
	KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$vl_idItem)
	If (Records in selection:C76([xxACT_Items:179])=1)
		APPEND TO ARRAY:C911(aQR_Text1;[xxACT_Items:179]Glosa:2)
		APPEND TO ARRAY:C911(aQR_Longint3;aQR_Longint2{$i})
	End if 
End for 

ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;2)
<>aChoicePtrs{1}:=->aQR_Longint3
<>aChoicePtrs{2}:=->aQR_Text1
TBL_ShowChoiceList (0;"Seleccione los ítems";2;->bInsertLineI;True:C214)
If (ok=1)
	AL_UpdateArrays (xAL_ACT_Terc_Items;0)
	AL_UpdateArrays (xALP_ACT_Terc_CtasXItems;0)
	For ($i;1;Size of array:C274(aLinesSelected))
		$vl_idItem:=aQR_Longint2{aLinesSelected{$i}}
		APPEND TO ARRAY:C911(alACT_TerIdItem;$vl_idItem)
		ACTter_Datos_ALP ("AsociaItems";->$vl_idItem)
	End for 
	ACTter_PagePactado 
	AT_Initialize (->aQR_Longint1;->aQR_Longint2;->aQR_Text1)
End if 
ACTter_SetObjects 

