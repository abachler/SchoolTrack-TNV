If ([MPA_DefinicionDimensiones:188]Dimensión:4#"")
	[MPA_DefinicionDimensiones:188]DTS_Modificacion:18:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
	[MPA_DefinicionDimensiones:188]ModificadoPor:19:=<>tUSR_CurrentUser
	If ((vsEVLG_Simbolo_True#"") & (vsEVLG_Simbolo_False#""))
		[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17:=vsEVLG_Simbolo_True+";"+vsEVLG_Simbolo_False
	Else 
		[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17:=""
	End if 
	[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16:=vsEVLG_DescSimbolo_True+";"+vsEVLG_DescSimbolo_False
	
	Case of 
		: (([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2) & (ST_CountWords ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")#2))
			CD_Dlog (0;__ ("Por favor defina los símbolos binarios para Aprobado y Reprobado."))
		: (([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3) & ([MPA_DefinicionDimensiones:188]Escala_Maximo:13=0))
			CD_Dlog (0;__ ("Por favor defina al menos la evaluación máxima de la escala."))
		Else 
			If ([MPA_DefinicionDimensiones:188]ID:1=0)
				[MPA_DefinicionDimensiones:188]ID:1:=SQ_SeqNumber (->[MPA_DefinicionDimensiones:188]ID:1)
				[MPA_DefinicionDimensiones:188]ID_Area:2:=[MPA_DefinicionAreas:186]ID:1
			End if 
			
			ACCEPT:C269
	End case 
End if 
