OBJECT SET VISIBLE:C603(*;"vt_agregado2";False:C215)
OBJECT SET VISIBLE:C603(*;"vt_eliminado2";False:C215)

$choice:=IT_PopUpMenu (->alACT_CuotasPagares;->vlACTp_Cuota)
If ($choice>0)
	vlACTp_Cuota:=alACT_CuotasPagares{$choice}
End if 