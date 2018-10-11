If ((vlACTp_Dia>0) & (vlACTp_Dia<=31))
	$pos:=Find in array:C230(alACT_DiasPagares;vlACTp_Dia)
	If ($pos=-1)
		APPEND TO ARRAY:C911(alACT_DiasPagares;vlACTp_Dia)
		SORT ARRAY:C229(alACT_DiasPagares;>)
		OBJECT SET VISIBLE:C603(*;"vt_agregado1";True:C214)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado1";False:C215)
		GOTO OBJECT:C206(vlACTp_Cuota)
	End if 
End if 