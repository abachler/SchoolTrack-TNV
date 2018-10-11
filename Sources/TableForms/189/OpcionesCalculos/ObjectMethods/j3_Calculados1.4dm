If (Self:C308->\
=\
1)\

	
	SET QUERY LIMIT:C395(1)\
		
	SET QUERY DESTINATION:C396(Into variable:K19:4;\
		$dimensiones)\
		
	QUERY:C277([MPA_ObjetosMatriz:204];\
		[MPA_ObjetosMatriz:204]Tipo_Objeto:2=\
		Dimension_Aprendizaje;\
		*)\
		
	QUERY:C277([MPA_ObjetosMatriz:204];\
		 & \
		[MPA_ObjetosMatriz:204]ID_Matriz:1=\
		[MPA_AsignaturasMatrices:189]ID_Matriz:1)\
		
	SET QUERY DESTINATION:C396(Into variable:K19:4;\
		$competencias)\
		
	QUERY:C277([MPA_ObjetosMatriz:204];\
		[MPA_ObjetosMatriz:204]Tipo_Objeto:2=\
		Logro_Aprendizaje;\
		*)\
		
	QUERY:C277([MPA_ObjetosMatriz:204];\
		 & \
		[MPA_ObjetosMatriz:204]ID_Matriz:1=\
		[MPA_AsignaturasMatrices:189]ID_Matriz:1)\
		
	SET QUERY DESTINATION:C396(Into current selection:K19:1)\
		
	SET QUERY LIMIT:C395(0)\
		
	
	If ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10<=1)\
		
		Case of 
			: ($competencias>\
				0)\
				
				[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10:=\
					Logro_Aprendizaje
				e2_Competencias:=\
					1
				LOG_RegisterEvt ("La modalidad de evaluación de ejes de aprendizajes fue cambiada a \"Calculados sob"\
					+"re "\
					+"la ba"\
					+"se de evaluaciones de competencias\""\
					)\
					
			: ($dimensiones>\
				0)\
				
				[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10:=\
					Dimension_Aprendizaje
				e1_Dimensiones:=\
					1
				LOG_RegisterEvt ("La modalidad de evaluación ejes de aprendizajes fue cambiada a \"Calculados sobre "\
					+"la ba"\
					+"se de evaluaciones de dimensiones\""\
					)\
					
		End case 
	End if 
	_O_ENABLE BUTTON:C192(e1_dimensiones)\
		
	_O_ENABLE BUTTON:C192(e2_competencias)\
		
	MPA_OpcionesCalculos_Ejes 
End if 

vb_CalculoEjes:=\
True:C214
