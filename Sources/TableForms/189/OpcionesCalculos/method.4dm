  //[MPA_AsignaturasMatrices].OpcionesCalculos



Case of 
	: (Form event:C388=On Load:K2:1)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
		If ([MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7=False:C215)
			r1_Ejes:=0
			r2_Dimensiones:=0
			r3_Competencias:=0
			[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23:=0
		Else 
			Case of 
				: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
					r1_Ejes:=1
				: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
					r2_Dimensiones:=1
				: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
					r3_Competencias:=1
			End case 
		End if 
		
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
		r1_Ejes:=Num:C11(($ejes>0) & ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje))
		r2_Dimensiones:=Num:C11(($dimensiones>0) & ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje))
		r3_competencias:=Num:C11(($competencias>0) & ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje))
		IT_SetButtonState (($ejes>0) & [MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7;->r1_Ejes)
		IT_SetButtonState (($dimensiones>0) & [MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7;->r2_Dimensiones)
		IT_SetButtonState (($competencias>0) & [MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7;->r3_competencias)
		SET LIST ITEM PROPERTIES:C386(hl_PaginasOpciones;Eje_Aprendizaje;$ejes>0;0;0)
		SET LIST ITEM PROPERTIES:C386(hl_PaginasOpciones;Dimension_Aprendizaje;$dimensiones>0;0;0)
		
		If ([MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7)
			OBJECT SET ENTERABLE:C238([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9;True:C214)
		Else 
			OBJECT SET ENTERABLE:C238([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9;False:C215)
		End if 
		
		
		  //verifico si en la configuración hay EJES específicos a un período
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
		ARRAY LONGINT:C221($al_Periodos;0)
		AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
		[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=False:C215  //ABK 20111028
		vbMPA_EjesSegunPeriodo:=False:C215
		If (Size of array:C274($al_Periodos)>0)
			If (Size of array:C274($al_Periodos)>1)
				vbMPA_EjesSegunPeriodo:=True:C214
				[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=True:C214  //ABK 20111028
				[MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26:=True:C214
			Else 
				If ($al_Periodos{1}>=2)
					vbMPA_EjesSegunPeriodo:=True:C214
					[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=True:C214  //ABK 20111028
				End if 
			End if 
		End if 
		
		
		  //verifico si en la configuración hay DIMENSIONES específicos a un período
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
		ARRAY LONGINT:C221($al_Periodos;0)
		AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
		[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=False:C215
		[MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27:=True:C214
		vbMPA_DimensionesSegunPeriodo:=False:C215
		If (Size of array:C274($al_Periodos)>0)
			If (Size of array:C274($al_Periodos)>1)
				vbMPA_DimensionesSegunPeriodo:=True:C214
				[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=True:C214
			Else 
				If ($al_Periodos{1}>=2)
					vbMPA_DimensionesSegunPeriodo:=True:C214
					[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=True:C214
				End if 
			End if 
		End if 
		
		
		  //verifico si en la configuración hay COMPETENCIAS específicas a un período
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
		ARRAY LONGINT:C221($al_Periodos;0)
		AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
		[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=False:C215
		vbMPA_CompetenciasSegunPeriodo:=False:C215
		If (Size of array:C274($al_Periodos)>0)
			If (Size of array:C274($al_Periodos)>1)
				vbMPA_CompetenciasSegunPeriodo:=True:C214
				[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=True:C214
				[MPA_AsignaturasMatrices:189]CompEnFinal_PonderacionVariable:28:=True:C214
			Else 
				If ($al_Periodos{1}>=2)
					vbMPA_CompetenciasSegunPeriodo:=True:C214
					[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=True:C214
				End if 
			End if 
		End if 
		SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
		
		
		MPA_OpcionesCalculos_Finales 
		If (USR_GetUserID >0)
			OBJECT SET VISIBLE:C603(*;"P0_IdMatriz_fld";False:C215)
		End if 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

