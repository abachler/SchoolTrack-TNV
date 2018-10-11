//%attributes = {}
  // MÉTODO: MPA_OpcionesCalculos_Finales
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:29:46
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_OpcionesCalculos_Finales()
  // ----------------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda)
C_TEXT:C284($t_campoPonderacion)
C_TEXT:C284($t_encabezadoColumna;$t_nombreObjeto)
C_LONGINT:C283(vlb_HDRObjetos;vlb_HDRPonderacion;vl_PeriodoSeleccionado)




  // CODIGO PRINCIPAL
PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)

If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>0)
	p1_PonderacionConstante:=0
	p2_PonderacionVariable:=0
	Case of 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			If ([MPA_AsignaturasMatrices:189]CFG_Ejes_VariableSegunPeriodo:24)
				[MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26:=True:C214
				p2_PonderacionVariable:=1
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
			Else 
				If ([MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26)
					p2_PonderacionVariable:=1
				Else 
					p1_PonderacionConstante:=1
				End if 
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
			End if 
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			If ([MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25)
				[MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27:=True:C214
				p2_PonderacionVariable:=1
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
			Else 
				If ([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27)
					p2_PonderacionVariable:=1
				Else 
					p1_PonderacionConstante:=1
				End if 
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
			End if 
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			If ([MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12)
				[MPA_AsignaturasMatrices:189]CompEnFinal_PonderacionVariable:28:=True:C214
				p2_PonderacionVariable:=1
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
				OBJECT SET VISIBLE:C603(bPopupPeriodos;True:C214)
				
			Else 
				If ([MPA_AsignaturasMatrices:189]CompEnFinal_PonderacionVariable:28)
					p2_PonderacionVariable:=1
				Else 
					p1_PonderacionConstante:=1
				End if 
				OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
				OBJECT SET VISIBLE:C603(bPopupPeriodos;False:C215)
			End if 
	End case 
	
	vtSTR_PeriodosPopupMenu:=AT_array2text (->atSTR_Periodos_Nombre;";")+";(-;Evaluación final"
	If (vl_PeriodoSeleccionado=0)
		vl_PeriodoSeleccionado:=1
	End if 
	If (vl_PeriodoSeleccionado=-1)
		OBJECT SET TITLE:C194(bPopupPeriodos;"Evaluación final")
	Else 
		OBJECT SET TITLE:C194(bPopupPeriodos;atSTR_Periodos_Nombre{vl_PeriodoSeleccionado})
	End if 
	
	Case of 
		: (p1_PonderacionConstante=1)
			OBJECT SET VISIBLE:C603(bPopupPeriodos;False:C215)
		: (p2_PonderacionVariable=1)
			OBJECT SET VISIBLE:C603(bPopupPeriodos;True:C214)
	End case 
	
	If (vl_PeriodoSeleccionado=0)
		vl_PeriodoSeleccionado:=1
	End if 
	Case of 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26))
				vl_PeriodoSeleccionado:=-1
			End if 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27))
				vl_PeriodoSeleccionado:=-1
			End if 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27))
				vl_PeriodoSeleccionado:=-1
			End if 
	End case 
	
	MPA_Calculos_CargaObjetosMatriz ([MPA_AsignaturasMatrices:189]ID_Matriz:1;0;[MPA_AsignaturasMatrices:189]BaseCalculoResultado:23;0;vl_PeriodoSeleccionado)
	
	Case of 
		: (vl_PeriodoSeleccionado=-1)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionG_EnResultado"
		: (vl_PeriodoSeleccionado=1)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP1_EnResultado"
		: (vl_PeriodoSeleccionado=2)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP2_EnResultado"
		: (vl_PeriodoSeleccionado=3)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP3_EnResultado"
		: (vl_PeriodoSeleccionado=4)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP4_EnResultado"
		: (vl_PeriodoSeleccionado=5)
			$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP5_EnResultado"
	End case 
	
	Case of 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionEjes]ID;->[MPA_ObjetosMatriz]ID_Eje;->[MPA_DefinicionEjes]Nombre)"
			$t_encabezadoColumna:=__ ("Ejes de aprendizaje")
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionDimensiones]ID;->[MPA_ObjetosMatriz]ID_dimension;->[MPA_DefinicionDimensiones]Dimensión)"
			$t_encabezadoColumna:=__ ("Dimensiones de aprendizaje")
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionCompetencias]ID;->[MPA_ObjetosMatriz]ID_Competencia;->[MPA_DefinicionCompetencias]Competencia)"
			$t_encabezadoColumna:=__ ("Competencias")
	End case 
	LISTBOX SET COLUMN FORMULA:C1203(*;"enunciados";$t_nombreObjeto;Is text:K8:3)
	LISTBOX SET COLUMN FORMULA:C1203(*;"ponderacion";$t_campoPonderacion;Is real:K8:4)
	OBJECT SET TITLE:C194(*;"HDR_objetos";$t_encabezadoColumna)
	OBJECT SET FONT STYLE:C166(*;"HDR_objetos";1)
	
	OBJECT SET RGB COLORS:C628(*;"lb_ObjetosFinales";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
	
	OBJECT SET ENTERABLE:C238(*;"enunciados";False:C215)
	OBJECT SET ENTERABLE:C238(*;"Ponderacion";True:C214)
End if 




