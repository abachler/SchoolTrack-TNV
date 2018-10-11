If (vlACTp_Cuota>0)
	$pos:=Find in array:C230(alACT_CuotasPagares;vlACTp_Cuota)
	If ($pos=-1)
		APPEND TO ARRAY:C911(alACT_CuotasPagares;vlACTp_Cuota)
		SORT ARRAY:C229(alACT_CuotasPagares;>)
		OBJECT SET VISIBLE:C603(*;"vt_agregado2";True:C214)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado2";False:C215)
		GOTO OBJECT:C206(vtACTp_Regimen)
	End if 
End if 