$text:=AT_array2text (-><>at_NombreNivelesActivos)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	vt_Nivel:=<>at_NombreNivelesActivos{$choice}
	vi_NivelNum:=<>al_NumeroNivelesActivos{$choice}
	If (opt1=1)
		opt1:=0
		opt2:=1
		opt3:=0
	Else 
		opt1:=0
		opt2:=opt2
		opt3:=opt3
	End if 
	
	Case of 
		: (opt1=1)
			$opcion:=1
		: (opt2=1)
			$opcion:=2
		: (opt3=1)
			$opcion:=3
	End case 
	
	OBJECT SET ENABLED:C1123(*;"pc_1";False:C215)
	OBJECT SET ENABLED:C1123(*;"pc_2";False:C215)
	
	SIGE_LoadDataArrays (4;$opcion;vi_MesNum;vi_NivelNum)
	SIGE_LoadDisplayLB (4)
	
	If (opt2=1)
		OBJECT SET VISIBLE:C603(*;"Texto_dias";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"Texto_dias";False:C215)
	End if 
	OBJECT SET VISIBLE:C603(*;"Texto_mes";False:C215)
	
End if 