//%attributes = {}
  // MÉTODO: MPA_Calculos_CargaObjetosMatriz
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 18:06:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_CargaObjetosMatriz()
  // ----------------------------------------------------

C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($b_objetosVariablesPeriodo)
C_LONGINT:C283($l_Matriz_Id;$l_Objeto_Tipo;$l_ObjetoPadre_ID;$l_Periodo;$l_TipoCalculos)
C_POINTER:C301($y_ObjetoID)

If (False:C215)
	C_LONGINT:C283(MPA_Calculos_CargaObjetosMatriz ;$1)
	C_LONGINT:C283(MPA_Calculos_CargaObjetosMatriz ;$2)
	C_LONGINT:C283(MPA_Calculos_CargaObjetosMatriz ;$3)
	C_LONGINT:C283(MPA_Calculos_CargaObjetosMatriz ;$4)
	C_LONGINT:C283(MPA_Calculos_CargaObjetosMatriz ;$5)
End if 




  // CODIGO PRINCIPAL
$l_Matriz_Id:=$1
$l_TipoCalculos:=$2
$l_Objeto_Tipo:=$3
$l_ObjetoPadre_ID:=$4
$l_Periodo:=$5

If ($l_Matriz_Id#[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_Matriz_Id)
End if 

If ($l_TipoCalculos=0)
	Case of 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26))
				$l_Periodo:=0
			End if 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27))
				$l_Periodo:=0
			End if 
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			If (Not:C34([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27))
				$l_Periodo:=0
			End if 
	End case 
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=$l_Objeto_Tipo;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Matriz:1=$l_Matriz_Id)
	If ($l_Periodo>0)
		QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_Periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
	End if 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
Else 
	Case of 
		: ($l_TipoCalculos=Eje_Aprendizaje)
			$y_ObjetoID:=->[MPA_ObjetosMatriz:204]ID_Eje:3
		: ($l_TipoCalculos=Dimension_Aprendizaje)
			$y_ObjetoID:=->[MPA_ObjetosMatriz:204]ID_Dimension:4
	End case 
	Case of 
		: ($l_Objeto_Tipo=Dimension_Aprendizaje)
			$b_objetosVariablesPeriodo:=[MPA_AsignaturasMatrices:189]CFG_Dim_VariableSegunPeriodo:25
		: ($l_Objeto_Tipo=Logro_Aprendizaje)
			$b_objetosVariablesPeriodo:=[MPA_AsignaturasMatrices:189]CFG_Comp_VariableSegunPeriodo:12
	End case 
	
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=$l_Objeto_Tipo;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Matriz:1=$l_Matriz_Id;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;$y_ObjetoID->=$l_ObjetoPadre_ID)
	If ($b_objetosVariablesPeriodo)
		QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_Periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
	End if 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End if 

