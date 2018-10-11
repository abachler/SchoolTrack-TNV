//%attributes = {}
  //EVLG_GetConfiguracion

C_LONGINT:C283($configRecNum;$refPeriodo;$1;$2)
C_LONGINT:C283($hResize;$bWidth;$bHeight)

$configRecNum:=$1
$refPeriodo:=$2

If ($configRecNum>=0)
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$configRecNum)
	AL_UpdateArrays (xALP_LogrosAsignaturas;0)
	ARRAY TEXT:C222(atEVLG_AdvCFG_EjesLogros;0)
	ARRAY LONGINT:C221(alEVLG_AdvCFG_Ids;0)
	ARRAY LONGINT:C221(alEVLG_AdvCFG_TipoObjeto;0)
	ARRAY TEXT:C222(atEVLG_AdvCFG_Icons;0)
	
	RELATE MANY:C262([MPA_AsignaturasMatrices:189]ID_Matriz:1)
	QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $refPeriodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
	If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
		  //AL_UpdateArrays (xALP_LogrosAsignaturas;0)
	Else 
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_DefinicionCompetencias:187]ID_Dimension:23;Manual:K51:3;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_DefinicionDimensiones:188]ID_Eje:3;Manual:K51:3;Manual:K51:3)
		ARRAY LONGINT:C221($aRecNums;0)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$aRecNums;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;alEVLG_AdvCFG_TipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$aIDEje;[MPA_DefinicionEjes:185]Nombre:3;$aNombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$aOrdenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$aIDDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$aNombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$aOrdenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$aIDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$aNombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$aOrdenCompetencia)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_DefinicionCompetencias:187]ID_Dimension:23;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_DefinicionDimensiones:188]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
		AT_MultiLevelSort (">>>";->$aOrdenEje;->$aOrdenDimension;->$aOrdenCompetencia;->$aRecNums;->alEVLG_AdvCFG_TipoObjeto;->$aIDEje;->$aNombreEje;->$aIDDimension;->$aNombreDimension;->$aIDCompetencia;->$aNombreCompetencia)
		ARRAY TEXT:C222(atEVLG_AdvCFG_EjesLogros;Size of array:C274($aRecNums))
		ARRAY LONGINT:C221(alEVLG_AdvCFG_Ids;Size of array:C274($aRecNums))
		ARRAY TEXT:C222(atEVLG_AdvCFG_Icons;Size of array:C274($aRecNums))
		For ($i;1;Size of array:C274($aRecNums))
			  //GOTO RECORD([MPA_ObjetosMatriz];$aRecNums{$i})
			Case of 
				: (alEVLG_AdvCFG_TipoObjeto{$i}=Eje_Aprendizaje)
					atEVLG_AdvCFG_Icons{$i}:="^9002"
					alEVLG_AdvCFG_Ids{$i}:=$aIDEje{$i}
					atEVLG_AdvCFG_EjesLogros{$i}:=<>nbSpace+$aNombreEje{$i}
				: (alEVLG_AdvCFG_TipoObjeto{$i}=Dimension_Aprendizaje)
					atEVLG_AdvCFG_Icons{$i}:=Char:C90(Space:K15:42)*2+"^9002"
					alEVLG_AdvCFG_Ids{$i}:=$aIDDimension{$i}
					atEVLG_AdvCFG_EjesLogros{$i}:=<>nbSpace+$aNombreDimension{$i}
				: (alEVLG_AdvCFG_TipoObjeto{$i}=Logro_Aprendizaje)
					atEVLG_AdvCFG_Icons{$i}:=""
					alEVLG_AdvCFG_Ids{$i}:=$aIDCompetencia{$i}
					atEVLG_AdvCFG_EjesLogros{$i}:=<>nbSpace*3+$aNombreCompetencia{$i}
			End case 
		End for 
		
	End if 
	AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
	AL_SetLine (xALP_LogrosAsignaturas;0)
	For ($i;1;Size of array:C274(alEVLG_AdvCFG_Ids))
		Case of 
			: (alEVLG_AdvCFG_TipoObjeto{$i}=Eje_Aprendizaje)
				AL_SetRowStyle (xALP_LogrosAsignaturas;$i;1)
			: (alEVLG_AdvCFG_TipoObjeto{$i}=Dimension_Aprendizaje)
				AL_SetRowStyle (xALP_LogrosAsignaturas;$i;2)
		End case 
	End for 
End if 

GET LIST ITEM:C378(hl_Periodos;Selected list items:C379(hl_Periodos);$refPeriodo;$itemText)


IT_SetObjectRect (->vtEVLG_SpecificConfig;216;256;581;269)
IT_SetNamedObjectRect ("popupConfig_list";216;256;604;269)
IT_SetNamedObjectRect ("popupconfig_arrow";579;258;590;272)
OBJECT GET COORDINATES:C663(vtEVLG_SpecificConfig;$oLeft;$oTop;$oRight;$oBottom)
OBJECT GET BEST SIZE:C717(vtEVLG_SpecificConfig;$bWidth;$bHeight;450)
$cWidth:=$oRight-$oLeft
$hResize:=$bWidth-$cWidth
OBJECT MOVE:C664(vtEVLG_SpecificConfig;0;0;$hResize)
OBJECT MOVE:C664(*;"popupConfig_list";0;0;$hResize+3)
OBJECT MOVE:C664(*;"popupconfig_arrow";$hResize+3;0)
OBJECT SET VISIBLE:C603(*;"popupConfig_list";True:C214)
OBJECT SET VISIBLE:C603(*;"popupconfig_arrow";True:C214)
