$text:=AT_array2text (->at_meses_disponibles)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	vt_Mes:=at_meses_disponibles{$choice}
	vi_MesNum:=al_num_meses_disponibles{$choice}
	
	Case of 
		: (opt1=1)
			$opcion:=1
		: (opt2=1)
			$opcion:=2
		: (opt3=1)
			$opcion:=3
	End case 
	
	SIGE_LoadDataArrays (4;$opcion;vi_MesNum;vi_NivelNum)
	SIGE_LoadDisplayLB (4)
	
End if 