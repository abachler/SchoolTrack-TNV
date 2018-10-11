//%attributes = {}
  // MÉTODO: UD_v20111020_OpcionesCalculoMPA
  // ----------------------------------------------------
  // Usuario(OS): Alberto Bachler
  // Fecha de creación: 20/10/11, 20:43:58
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  // 
  // PARÁMETROS
  // UD_v20111020_OpcionesCalculoMPA ()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL

$p:=IT_UThermometer (1;0;"Ajustando opciones de calculos en evaluación de aprendizajes...")
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$aRecNums{$i})
	  // verifico si en la configuración hay EJES específicos a un período
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
	ARRAY LONGINT:C221($al_Periodos;0)
	AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
	[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=False:C215
	If (Size of array:C274($al_Periodos)>0)
		If (Size of array:C274($al_Periodos)>1)
			[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=True:C214
			[MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26:=True:C214
		Else 
			If ($al_Periodos{1}>=2)
				[MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24:=True:C214
			End if 
		End if 
		
		If (([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9) | ([MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7))
			READ WRITE:C146([Asignaturas:18])
			QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
			APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Resultado_no_calculado:47:=False:C215)
			UNLOAD RECORD:C212([Asignaturas:18])
			READ ONLY:C145([Asignaturas:18])
		End if 
		
	End if 
	
	
	  // verifico si en la configuración hay DIMENSIONES específicos a un período
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
	ARRAY LONGINT:C221($al_Periodos;0)
	AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
	[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=False:C215
	If (Size of array:C274($al_Periodos)>0)
		If (Size of array:C274($al_Periodos)>1)
			[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=True:C214
			[MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27:=True:C214
			[MPA_AsignaturasMatrices:189]DimEnEjes_PonderacionVariable:29:=True:C214
		Else 
			If ($al_Periodos{1}>=2)
				[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25:=True:C214
			End if 
		End if 
	End if 
	
	SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
	
	
	  // verifico si en la configuración hay DIMENSIONES específicos a un período
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
	ARRAY LONGINT:C221($al_Periodos;0)
	AT_DistinctsFieldValues (->[MPA_ObjetosMatriz:204]Periodos:7;->$al_Periodos)
	[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=False:C215
	If (Size of array:C274($al_Periodos)>0)
		If (Size of array:C274($al_Periodos)>1)
			[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=True:C214
			[MPA_AsignaturasMatrices:189]CompEnFinal_PonderacionVariable:28:=True:C214
			[MPA_AsignaturasMatrices:189]CompEnEjes_PonderacionVariable:30:=True:C214
			[MPA_AsignaturasMatrices:189]CompEnDim_PonderacionVariable:31:=True:C214
		Else 
			If ($al_Periodos{1}>=2)
				[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12:=True:C214
			End if 
		End if 
	End if 
	
	SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
End for 




$p:=IT_UThermometer (-2;$p)


