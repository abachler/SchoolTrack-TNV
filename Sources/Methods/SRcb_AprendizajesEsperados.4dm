//%attributes = {}
  //SRcb_AprendizajesEsperados

C_BOOLEAN:C305($setScripts;$showOptions)
C_LONGINT:C283($1;$2;$3;$4;$0)
C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_TEXT:C284($vs_BreakVarName)
ARRAY LONGINT:C221($objectIDs;0)

$area:=$1
$action:=$2
$itemRef:=$3
$objectType:=$4
$0:=1

AT_Inc (0)
ARRAY TEXT:C222(aScriptLines;4)
aScriptLines{AT_Inc }:="OcultarSecciónArea="+"SR_ShowHideSection (SR Section Subheader1;[Asignaturas]EVAPR_EsArea)"
aScriptLines{AT_Inc }:="OcultarAsignaturas="+"SR_ShowHideSection (SR Section Subheader2;(not([Asignaturas]EVAPR_EsArea))&([MPA_"+"AprendizajesEsperados]Enunciado#\"\"))"
aScriptLines{AT_Inc }:="OcultarSecciónEjes="+"SR_ShowHideSection (SR Section Subheader3;([MPA_Ejes]Nombre#[Asignaturas]Denomina"+"ción_interna)&([MPA_AprendizajesEsperados]Enunciado#\"\"))"
aScriptLines{AT_Inc }:="OcultarSecciónDimension"+"SR_ShowHideSection (SR Section Subheader4;([MPA_Dimensiones]Dimensión#\"\"))"

Case of 
	: ($action>0)
		ARRAY LONGINT:C221($objectIds;0)
		$err:=SR Get Object IDs ($area;0;$objectIds)
		For ($i;1;Size of array:C274($objectIds))
			$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
		End for 
		If ($setScripts)
			$err:=SR Set Scripts ($area;$startScript;$bodyScript;$endScript)
		End if 
		ARRAY TEXT:C222(aObjectParameters;0)
		If (($action=6) & ($showOptions))
			$err:=SR Get Sections ($area;$vl_Sections;$vl_PrintingSesions)
			
			  // Opción Encabezado
			If ($vl_Sections ?? SR Section Header)
				$err:=SR Get Section Properties ($area;SR Section Header;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
				NV_SetValueInTextArray (->aObjectParameters;"EspacioEncabezado";String:C10($vl_Position))
				$headerHeight:=$vl_Position
			End if 
			
			  // Opciones Impresión Area
			If ($vl_Sections ?? SR Section SubHeader1)
				$err:=SR Get Section Properties ($area;SR Section SubHeader1;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
				ARRAY LONGINT:C221($objectIDs;0)
				$err:=SR Get Section Object IDs ($area;SR Section SubHeader1;$objectIDs)
				For ($i;1;Size of array:C274($objectIDs))
					$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
					If ($tableNo=Table:C252(->[Asignaturas:18]))
						If ($fieldNo=Field:C253(->[Asignaturas:18]Sector:9))
							NV_SetValueInTextArray (->aObjectParameters;"SecciónArea";"1")
							$script:=NV_GetValueFromTextArray (->aScriptLines;"OcultarSecciónArea")
							If (Position:C15($script;$bodyScript)>0)
								NV_SetValueInTextArray (->aObjectParameters;"OcultarSecciónArea";"1")
							End if 
						End if 
					End if 
				End for 
			End if 
			
			  // Opciones impresion Asignatura
			If ($vl_Sections ?? SR Section SubHeader2)
				$err:=SR Get Section Properties ($area;SR Section SubHeader2;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
				ARRAY LONGINT:C221($objectIDs;0)
				$err:=SR Get Section Object IDs ($area;SR Section SubHeader2;$objectIDs)
				For ($i;1;Size of array:C274($objectIDs))
					$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
					If ($tableNo=Table:C252(->[Asignaturas:18]))
						If (($fieldNo=Field:C253(->[Asignaturas:18]Asignatura:3)) | ($fieldNo=Field:C253(->[Asignaturas:18]denominacion_interna:16)))
							$script:=NV_GetValueFromTextArray (->aScriptLines;"OcultarAsignaturas")
							If (Position:C15($script;$bodyScript)>0)
								NV_SetValueInTextArray (->aObjectParameters;"OcultarAsignaturas";"1")
							End if 
						End if 
					End if 
				End for 
			End if 
			
			  // Opciones Impresión Eje
			If ($vl_Sections ?? SR Section SubHeader3)
				$err:=SR Get Section Properties ($area;SR Section SubHeader3;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
				ARRAY LONGINT:C221($objectIDs;0)
				$err:=SR Get Section Object IDs ($area;SR Section SubHeader3;$objectIDs)
				For ($i;1;Size of array:C274($objectIDs))
					$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
					If ($tableNo=Table:C252(->[MPA_DefinicionEjes:185]))
						If ($fieldNo=Field:C253(->[MPA_DefinicionEjes:185]Nombre:3))
							NV_SetValueInTextArray (->aObjectParameters;"SecciónEjes";"1")
							$script:=NV_GetValueFromTextArray (->aScriptLines;"OcultarSecciónEjes")
							If (Position:C15($script;$bodyScript)>0)
								NV_SetValueInTextArray (->aObjectParameters;"OcultarSecciónEjes";"1")
							End if 
						End if 
					End if 
				End for 
			End if 
			
			  // Opciones Impresión Dimensiones
			If ($vl_Sections ?? SR Section SubHeader4)
				$err:=SR Get Section Properties ($area;SR Section SubHeader4;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
				ARRAY LONGINT:C221($objectIDs;0)
				$err:=SR Get Section Object IDs ($area;SR Section SubHeader4;$objectIDs)
				For ($i;1;Size of array:C274($objectIDs))
					$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
					If ($tableNo=Table:C252(->[MPA_DefinicionDimensiones:188]))
						If ($fieldNo=Field:C253(->[MPA_DefinicionDimensiones:188]Dimensión:4))
							NV_SetValueInTextArray (->aObjectParameters;"SecciónDimensión";"1")
							$script:=NV_GetValueFromTextArray (->aScriptLines;"OcultarSecciónDimension")
							If (Position:C15($script;$bodyScript)>0)
								NV_SetValueInTextArray (->aObjectParameters;"OcultarSecciónDimension";"1")
							End if 
						End if 
					End if 
				End for 
			End if 
			
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_OpcionesInformeLogros";-1;8)
			DIALOG:C40([xxSTR_Constants:1];"STR_OpcionesInformeLogros")
			CLOSE WINDOW:C154
			
			  //PROCESAMIENTO DE LAS OPCIONES SELECCIONADAS
			If (OK=1)
				
				  // OPCION  Encabezado
				$verticalOffset:=vi_AltoEnzabezado-$headerHeight
				If ($verticalOffset#0)
					SR_MoveSection ($area;$verticalOffset)
				End if 
				
				$adjustSections:=False:C215
				
				  // OPCION Sección para Asignatura area
				If (bcIncluyeAreas=1)
					SR_PlaceSectionField ($area;SR Section SubHeader1;->[Asignaturas:18]Sector:9;"Arial";12;1;100)
				End if 
				
				  //  ` OPCION Sección para Ejes
				If (bcIncluyeEjes=1)
					SR_PlaceSectionField ($area;SR Section SubHeader2;->[MPA_DefinicionEjes:185]Nombre:3;"Arial";12;1;100)
				End if 
				
				  //  ` OPCION Sección para Ejes
				If (bcIncluyeDimensiones=1)
					SR_PlaceSectionField ($area;SR Section SubHeader3;->[MPA_DefinicionDimensiones:188]Dimensión:4;"Arial";12;1;100)
				End if 
				
			End if 
		End if 
End case 