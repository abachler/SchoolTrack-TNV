If (vlACTp_Cuota>0)
	$pos:=Find in array:C230(alACT_CuotasPagares;vlACTp_Cuota)
	If ($pos#-1)
		AT_Delete ($pos;1;->alACT_CuotasPagares)
		vlACTp_Cuota:=0
		OBJECT SET VISIBLE:C603(*;"vt_agregado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado2";True:C214)
		GOTO OBJECT:C206(vtACTp_Regimen)
	End if 
End if 