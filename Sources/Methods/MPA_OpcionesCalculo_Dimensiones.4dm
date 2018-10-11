//%attributes = {}
  // MÉTODO: MPA_OpcionesCalculo_Dimensiones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:10:55
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_OpcionesCalculo_Dimensiones()
  // ----------------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda)
C_POINTER:C301($y_campoPonderacion)
C_TEXT:C284($t_nombreObjeto)
ARRAY LONGINT:C221($al_Dummy;0)
ARRAY LONGINT:C221($al_RecNums;0)

C_LONGINT:C283(vlb_HDRObjetos;vlb_HDRPonderacion)




  // CODIGO PRINCIPAL
C_LONGINT:C283(vlb_HDRims;vlb_HDRDimsRecNum)

D1_Agrupacion:=0
D2_Evaluados:=0
D3_Calculados:=0
OBJECT SET VISIBLE:C603(*;"lb_ObjetosDimension";False:C215)
OBJECT SET VISIBLE:C603(*;"lb_Dimensiones";False:C215)
OBJECT SET VISIBLE:C603(*;"lb_Ejes@";False:C215)

PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)

p1_PonderacionConstante:=0
p2_PonderacionVariable:=0
Case of 
	: ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=0)
		D1_Agrupacion:=1
		OBJECT SET VISIBLE:C603(*;"lb_ObjetosDimension";False:C215)
		OBJECT SET VISIBLE:C603(*;"lb_Dimensiones";False:C215)
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+171
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		e1_Dimensiones:=0
		e2_Competencias:=0
		
		  //IT_SetObjectRect (->hl_PaginasOpciones;6;19;554;165)
		FORM GOTO PAGE:C247(6)
		
	: ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=2)
		D2_Evaluados:=1
		OBJECT SET VISIBLE:C603(*;"lb_ObjetosDimension@";False:C215)
		OBJECT SET VISIBLE:C603(*;"lb_Dimensiones";False:C215)
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+171
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		
		  //IT_SetObjectRect (->hl_PaginasOpciones;6;19;554;165)
		FORM GOTO PAGE:C247(6)
		
	: ([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje)
		D3_Calculados:=1
		
		If ([MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12)
			[MPA_AsignaturasMatrices:189]CompEnDim_PonderacionVariable:31:=True:C214
			p2_PonderacionVariable:=1
			OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";False:C215)
			OBJECT SET VISIBLE:C603(bPopupPeriodos_Dimensiones;True:C214)
			
		Else 
			If ([MPA_AsignaturasMatrices:189]CompEnDim_PonderacionVariable:31)
				p2_PonderacionVariable:=1
			Else 
				p1_PonderacionConstante:=1
			End if 
			OBJECT SET ENABLED:C1123(*;"cfg_ponderacion@";True:C214)
			OBJECT SET VISIBLE:C603(bPopupPeriodos_Dimensiones;False:C215)
		End if 
		
		vtSTR_PeriodosPopupMenu:=AT_array2text (->atSTR_Periodos_Nombre;";")+";(-;Evaluación final"
		If (vl_PeriodoSeleccionado=0)
			vl_PeriodoSeleccionado:=1
		End if 
		If (vl_PeriodoSeleccionado=-1)
			OBJECT SET TITLE:C194(bPopupPeriodos_Dimensiones;"Evaluación final")
		Else 
			OBJECT SET TITLE:C194(bPopupPeriodos_Dimensiones;atSTR_Periodos_Nombre{vl_PeriodoSeleccionado})
		End if 
		
		Case of 
			: (p1_PonderacionConstante=1)
				OBJECT SET VISIBLE:C603(bPopupPeriodos_Dimensiones;False:C215)
			: (p2_PonderacionVariable=1)
				OBJECT SET VISIBLE:C603(bPopupPeriodos_Dimensiones;True:C214)
		End case 
		
		  // Campos a mostrar en la columna ponderaciones
		Case of 
			: (vl_PeriodoSeleccionado=-1)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionG_EnDimension"
			: (vl_PeriodoSeleccionado=1)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP1_EnDimension"
			: (vl_PeriodoSeleccionado=2)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP2_EnDimension"
			: (vl_PeriodoSeleccionado=3)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP3_EnDimension"
			: (vl_PeriodoSeleccionado=4)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP4_EnDimension"
			: (vl_PeriodoSeleccionado=5)
				$t_campoPonderacion:="[MPA_ObjetosMatriz]PonderacionP5_EnDimension"
		End case 
		
		  //busco  los objetos Dimensión de la matriz
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
		If (vl_PeriodoSeleccionado>0)
			QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? vl_PeriodoSeleccionado) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
		End if 
		
		  // creo una selección temporal ordenando primero los objetos  de la matriz por eje y dimensión y luego creo una selección temporal de las dimensiones de acuerdo al orden establecido establecido en el mapa
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_Dummy;[MPA_DefinicionDimensiones:188];$al_RecNums)
		CREATE SELECTION FROM ARRAY:C640([MPA_DefinicionDimensiones:188];$al_RecNums)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		COPY NAMED SELECTION:C331([MPA_DefinicionDimensiones:188];"Dimensiones")
		
		  // selecciono el primer registro de la selección temporal (si no hay registros no pasa pasa nada)
		REDUCE SELECTION:C351([MPA_DefinicionDimensiones:188];1)
		CREATE SET:C116([MPA_DefinicionDimensiones:188];"DimensionSeleccionada")
		
		  //configuración del listbox con las Dimensiones disponibles
		OBJECT SET TITLE:C194(*;"HDR_Dimensiones";__ ("Dimensiones de aprendizaje"))
		OBJECT SET FONT STYLE:C166(*;"HDR_Dimensiones";1)
		OBJECT SET FONT SIZE:C165(*;"HDR_Dimensiones";10)
		
		  // cargo los objetos (competencias) asociadas a la dimensión seleccionada)
		MPA_Calculos_CargaObjetosMatriz ([MPA_AsignaturasMatrices:189]ID_Matriz:1;Dimension_Aprendizaje;[MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6;[MPA_DefinicionDimensiones:188]ID:1;vl_PeriodoSeleccionado)
		  // configura la lista de objetos (competencias) asociados a la dimensión seleccionada
		$t_nombreObjeto:="KRL_GetTextFieldData (->[MPA_DefinicionCompetencias]ID;->[MPA_ObjetosMatriz]ID_Competencia;->[MPA_DefinicionCompetencias]Competencia)"
		LISTBOX SET COLUMN FORMULA:C1203(*;"enunciados2";$t_nombreObjeto;Is text:K8:3)
		LISTBOX SET COLUMN FORMULA:C1203(*;"ponderacion2";$t_campoPonderacion;Is real:K8:4)
		
		OBJECT SET TITLE:C194(*;"HDR_objetos";__ ("Competencias"))
		OBJECT SET FONT SIZE:C165(*;"HDR_objetos";10)
		OBJECT SET FONT STYLE:C166(*;"HDR_objetos";1)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"HDR_objetos";2)
		
		OBJECT SET TITLE:C194(*;"HDR_Ponderacion";__ ("Ponderación"))
		OBJECT SET FONT STYLE:C166(*;"HDR_Ponderacion";1)
		OBJECT SET FONT SIZE:C165(*;"HDR_Ponderacion";10)
		OBJECT SET FORMAT:C236(*;"Ponderacion";"|Pct_2Dec")
		
		
		OBJECT SET ENTERABLE:C238(*;"enunciados2";False:C215)
		OBJECT SET ENTERABLE:C238(*;"ponderacion2";True:C214)
		
		OBJECT SET VISIBLE:C603(*;"lb_Dimensiones@";True:C214)
		OBJECT SET VISIBLE:C603(*;"lb_ObjetosDimension";True:C214)
		
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_abajo:=$l_arriba+530
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		OBJECT SET RGB COLORS:C628(*;"lb_ObjetosDimension";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
		
		
		FORM GOTO PAGE:C247(3)
		
End case 

