//%attributes = {}
  // MÉTODO: MPA_OpcionesCalculos_Ejes
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:17:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_OpcionesCalculos_Ejes()
  // ----------------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda)
C_POINTER:C301($y_campoPonderacion)
C_TEXT:C284($t_encabezadoColumna;$t_nombreObjeto)
C_LONGINT:C283(vlb_HDRObjetos;vlb_HDRPonderacion)



  // CODIGO PRINCIPAL
J1_Agrupacion:=0
J2_Evaluados:=0
J3_Calculados:=0

PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)

p1_PonderacionConstante:=0
p2_PonderacionVariable:=0
Case of 
	: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=0)
		
		j1_Agrupacion:=1
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+171
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		_O_DISABLE BUTTON:C193(e1_Dimensiones)
		_O_DISABLE BUTTON:C193(e2_Competencias)
		e1_Dimensiones:=0
		e2_Competencias:=0
		  //IT_SetObjectRect (->hl_PaginasOpciones;6;19;554;165)
		FORM GOTO PAGE:C247(5)
		
	: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=1)
		
		j2_Evaluados:=1
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+171
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		_O_DISABLE BUTTON:C193(e1_Dimensiones)
		_O_DISABLE BUTTON:C193(e2_Competencias)
		e1_Dimensiones:=0
		e2_Competencias:=0
		FORM GOTO PAGE:C247(5)
		
	: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=2)
		j3_Calculados:=1
		
		Case of 
			: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
				e1_Dimensiones:=1
				e2_Competencias:=0
				If ([MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25)
					[MPA_AsignaturasMatrices:189]DimEnEjes_PonderacionVariable:29:=True:C214
					p2_PonderacionVariable:=1
					OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
				Else 
					If ([MPA_AsignaturasMatrices:189]DimEnEjes_PonderacionVariable:29)
						p2_PonderacionVariable:=1
					Else 
						p1_PonderacionConstante:=1
					End if 
					OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
				End if 
				
			: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
				e1_Dimensiones:=0
				e2_Competencias:=1
				If ([MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12)
					[MPA_AsignaturasMatrices:189]CompEnEjes_PonderacionVariable:30:=True:C214
					p2_PonderacionVariable:=1
					OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
					OBJECT SET VISIBLE:C603(bPopupPeriodos_Ejes;True:C214)
					
				Else 
					If ([MPA_AsignaturasMatrices:189]CompEnEjes_PonderacionVariable:30)
						p2_PonderacionVariable:=1
					Else 
						p1_PonderacionConstante:=1
					End if 
					OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
					OBJECT SET VISIBLE:C603(bPopupPeriodos_Ejes;False:C215)
				End if 
		End case 
		
		vtSTR_PeriodosPopupMenu:=AT_array2text (->atSTR_Periodos_Nombre;";")+";(-;Evaluación final"
		If (vl_PeriodoSeleccionado=0)
			vl_PeriodoSeleccionado:=1
		End if 
		If (vl_PeriodoSeleccionado=-1)
			OBJECT SET TITLE:C194(bPopupPeriodos_Ejes;"Evaluación final")
		Else 
			OBJECT SET TITLE:C194(bPopupPeriodos_Ejes;atSTR_Periodos_Nombre{vl_PeriodoSeleccionado})
		End if 
		
		Case of 
			: (p1_PonderacionConstante=1)
				OBJECT SET VISIBLE:C603(bPopupPeriodos_Ejes;False:C215)
			: (p2_PonderacionVariable=1)
				OBJECT SET VISIBLE:C603(bPopupPeriodos_Ejes;True:C214)
		End case 
		
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		If (vl_PeriodoSeleccionado>0)
			QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? vl_PeriodoSeleccionado) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
		End if 
		KRL_RelateSelection (->[MPA_DefinicionEjes:185]ID:1;->[MPA_ObjetosMatriz:204]ID_Eje:3)
		ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)
		COPY NAMED SELECTION:C331([MPA_DefinicionEjes:185];"Ejes")
		REDUCE SELECTION:C351([MPA_DefinicionEjes:185];1)
		CREATE SET:C116([MPA_DefinicionEjes:185];"EjeSeleccionado")
		
		OBJECT SET TITLE:C194(*;"HDR_Ejes";__ ("Ejes de aprendizaje"))
		OBJECT SET FONT STYLE:C166(*;"HDR_Ejes";1)
		OBJECT SET FONT SIZE:C165(*;"HDR_Ejes";10)
		
		MPA_Calculos_CargaObjetosMatriz ([MPA_AsignaturasMatrices:189]ID_Matriz:1;Eje_Aprendizaje;[MPA_AsignaturasMatrices:189]ModoCalculoEjes:10;[MPA_DefinicionEjes:185]ID:1;vl_PeriodoSeleccionado)
		
		  // Campos a mostrar en la columna ponderaciones
		Case of 
			: (vl_PeriodoSeleccionado=-1)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionG_EnEje"
			: (vl_PeriodoSeleccionado=1)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP1_EnEje"
			: (vl_PeriodoSeleccionado=2)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP2_EnEje"
			: (vl_PeriodoSeleccionado=3)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP3_EnEje"
			: (vl_PeriodoSeleccionado=4)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP4_EnEje"
			: (vl_PeriodoSeleccionado=5)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP5_EnEje"
		End case 
		
		Case of 
			: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
				$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionDimensiones]ID;->[MPA_ObjetosMatriz]ID_dimension;->[MPA_DefinicionDimensiones]Dimensión)"
				$t_encabezadoColumna:=__ ("Dimensiones de aprendizaje")
			: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
				$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionCompetencias]ID;->[MPA_ObjetosMatriz]ID_Competencia;->[MPA_DefinicionCompetencias]Competencia)"
				$t_encabezadoColumna:=__ ("Competencias")
		End case 
		LISTBOX SET COLUMN FORMULA:C1203(*;"enunciados1";$t_nombreObjeto;Is text:K8:3)
		LISTBOX SET COLUMN FORMULA:C1203(*;"ponderacion1";$t_campoPonderacion;Is real:K8:4)
		
		OBJECT SET TITLE:C194(*;"HDR_objetos";$t_encabezadoColumna)
		OBJECT SET FONT SIZE:C165(*;"HDR_objetos";10)
		OBJECT SET FONT STYLE:C166(*;"HDR_objetos";1)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"HDR_objetos";Align center:K42:3)
		
		OBJECT SET TITLE:C194(*;"HDR_Ponderacion";__ ("Ponderación"))
		OBJECT SET FONT SIZE:C165(*;"HDR_Ponderacion";10)
		OBJECT SET FONT STYLE:C166(*;"HDR_Ponderacion";1)
		
		
		OBJECT SET ENTERABLE:C238(*;"enunciados1";False:C215)
		OBJECT SET ENTERABLE:C238(*;"Ponderacion1";True:C214)
		
		OBJECT SET VISIBLE:C603(*;"lb_Ejes@";True:C214)
		OBJECT SET VISIBLE:C603(*;"lb_ObjetosEje@";True:C214)
		OBJECT SET RGB COLORS:C628(*;"lb_ObjetosEje";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
		
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+530
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		
		
		FORM GOTO PAGE:C247(2)
		
End case 

