OBJECT SET VISIBLE:C603(*;"vt_agregado1";False:C215)
OBJECT SET VISIBLE:C603(*;"vt_eliminado1";False:C215)

$choice:=IT_PopUpMenu (->alACT_DiasPagares;->vlACTp_Dia)
If ($choice>0)
	vlACTp_Dia:=alACT_DiasPagares{$choice}
End if 