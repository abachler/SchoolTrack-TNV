If (Self:C308->=1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$competencias)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	
	If ($competencias>0)
		[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6:=Logro_Aprendizaje
	Else 
		CD_Dlog (0;__ ("No hay competencias en esta matriz.\r\rNo es posible calcular el resultado sobre la base de las evaluaciones de las competencias."))
		[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6:=0
		
	End if 
	MPA_OpcionesCalculo_Dimensiones 
End if 

vb_CalculoDimensiones:=True:C214
