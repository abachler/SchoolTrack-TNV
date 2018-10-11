C_TEXT:C284($tempRegistrada)
$tempRegistrada:=vt_CargoSeleccionado
vt_CargoSeleccionado:="@"
vt_CargoSeleccionado:=IT_ShowChoices (->atACT_Glosa;->vt_CargoSeleccionado;"";->alACT_ID)
If (vt_CargoSeleccionado="")
	vt_CargoSeleccionado:=$tempRegistrada
End if 
If (vl_SelectedListItem>=0)
	vl_IdItemSeleccionado:=alACT_ID{vl_SelectedListItem}
	vt_MontoCargo:=String:C10(KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->vl_IdItemSeleccionado;->[xxACT_Items:179]Monto:7))
	vb_EsRelativo:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->vl_IdItemSeleccionado;->[xxACT_Items:179]EsRelativo:5)
	If (vb_EsRelativo)
		vt_MontoCargo:=vt_MontoCargo+"%"
	End if 
End if 