$docs:=AT_array2text (->atACT_DocsPopup)

$choice:=Pop up menu:C542($docs)

If ($choice>0)
	vt_Documento:=atACT_DocsPopup{$choice}
	vl_DocID:=alACT_DocsIDs{$choice}
	IT_SetButtonState (True:C214;->vb_Hoy;->vb_Mes;->vb_Año;->vb_Rango;->bAccept;->bMes)
	OBJECT SET ENTERABLE:C238(vl_añom;True:C214)
Else 
	IT_SetButtonState (((vt_Documento#"") & (vl_DocID#0));->vb_Hoy;->vb_Mes;->vb_Año;->vb_Rango;->bAccept;->bMes)
End if 