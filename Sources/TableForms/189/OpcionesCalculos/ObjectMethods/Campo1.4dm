C_BOOLEAN:C305($enterable)
If (Self:C308->)
	SET QUERY LIMIT:C395(1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$ejes)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$dimensiones)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$competencias)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	Case of 
		: ($ejes>0)
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=0)
				[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23:=Eje_Aprendizaje
				r1_ejes:=1
			End if 
		: ($dimensiones>0)
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=0)
				[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23:=Dimension_Aprendizaje
				r2_Dimensiones:=1
			End if 
		: ($competencias>0)
			If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=0)
				[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23:=Logro_Aprendizaje
				r3_competencias:=1
			End if 
	End case 
	IT_SetButtonState ($ejes>0;->r1_Ejes)
	IT_SetButtonState ($dimensiones>0;->r2_Dimensiones)
	IT_SetButtonState ($competencias>0;->r3_competencias)
	OBJECT SET ENTERABLE:C238([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9;True:C214)
	MPA_OpcionesCalculos_Finales 
	
	
	
	
Else 
	[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23:=0
	r1_Ejes:=0
	r2_Dimensiones:=0
	r3_Competencias:=0
	[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9:=False:C215
	OBJECT SET ENTERABLE:C238(*;"RadioButtonsObjetos@";False:C215)
	OBJECT SET ENTERABLE:C238([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9;False:C215)
	MPA_OpcionesCalculos_Finales 
End if 

vb_CalculoResultadoFinal:=True:C214


If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>0)
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	$l_abajo:=$l_arriba+530
	SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	FORM GOTO PAGE:C247(1)
Else 
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	$l_abajo:=$l_arriba+171
	SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	FORM GOTO PAGE:C247(4)
End if 

