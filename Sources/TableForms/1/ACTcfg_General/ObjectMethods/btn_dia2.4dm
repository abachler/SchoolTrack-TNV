If ((vlACTp_Dia>0) & (vlACTp_Dia<=31))
	$pos:=Find in array:C230(alACT_DiasPagares;vlACTp_Dia)
	If ($pos#-1)
		AT_Delete ($pos;1;->alACT_DiasPagares)
		vlACTp_Dia:=0
		OBJECT SET VISIBLE:C603(*;"vt_agregado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado1";True:C214)
		GOTO OBJECT:C206(vlACTp_Cuota)
	End if 
End if 