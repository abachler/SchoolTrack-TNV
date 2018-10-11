$index:=Find in array:C230(lb_Manual;True:C214)
If ($index#-1)
	AT_Delete ($index;1;->SN3_Manual_Styles;->SN3_Manual_TipoDato;->SN3_Manual_DataRefs;->SN3_Manual_Niveles;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatos;->SN3_Manual_CualesDatosBool)
End if 
IT_SetButtonState ((Size of array:C274(SN3_Manual_TipoDato)>0);->b_Manual_Enviar;->b_Manual_Limpiar)
LISTBOX SELECT ROW:C912(lb_Manual;0;lk remove from selection:K53:3)
_O_DISABLE BUTTON:C193(bDelEnvio)