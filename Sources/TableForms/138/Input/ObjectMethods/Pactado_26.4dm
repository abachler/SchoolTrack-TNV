WDW_OpenPopupWindow (Self:C308;->[ACT_Terceros_Pactado:139];"ACT_AplicaMontos";2)
DIALOG:C40([ACT_Terceros_Pactado:139];"ACT_AplicaMontos")
CLOSE WINDOW:C154
If (ok=1)
	ACTter_Datos_ALP ("AplicaMontos";->xAL_ACT_Terc_Items;->[ACT_Terceros_Pactado:139]Id_ItemDeCargo:4;->alACT_TerIdItem)
End if 