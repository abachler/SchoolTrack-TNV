$pos:=Find in array:C230(atACT_RegimenPagares;vtACTp_Regimen)
If ($pos=-1)
	APPEND TO ARRAY:C911(atACT_RegimenPagares;vtACTp_Regimen)
	SORT ARRAY:C229(atACT_RegimenPagares;>)
	OBJECT SET VISIBLE:C603(*;"vt_agregado3";True:C214)
	OBJECT SET VISIBLE:C603(*;"vt_eliminado3";False:C215)
	GOTO OBJECT:C206(vlACTp_Dia)
End if 
