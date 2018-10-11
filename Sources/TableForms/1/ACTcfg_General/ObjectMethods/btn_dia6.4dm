$pos:=Find in array:C230(atACT_RegimenPagares;vtACTp_Regimen)
If ($pos#-1)
	AT_Delete ($pos;1;->atACT_RegimenPagares)
	vtACTp_Regimen:=""
	OBJECT SET VISIBLE:C603(*;"vt_agregado3";False:C215)
	OBJECT SET VISIBLE:C603(*;"vt_eliminado3";True:C214)
	GOTO OBJECT:C206(vlACTp_Dia)
End if 