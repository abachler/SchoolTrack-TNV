//%attributes = {}
  //SR_PlaceSectionField

  //`xShell, Alberto Bachler
  //Metodo: SR_PlaceSectionField
  //Por abachler
  //Creada el 28/11/2005, 07:27:13
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($1;$2;$5;$6;$7;$0)
C_POINTER:C301($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($adjustSections)
C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_TEXT:C284($vs_BreakVarName)
ARRAY LONGINT:C221($objectIDs;0)

  //****INICIALIZACIONES****
$area:=$1
$sectionId:=$2
$fieldPointer:=$3
$objectLeft:=20
$objectWidth:=100  // default
$objectFontName:="Arial"  // default
$objectFontSize:=9  // default
$tableNum:=Table:C252($fieldPointer)
$fieldNum:=Field:C253($fieldPointer)

Case of 
	: (Count parameters:C259=7)
		$objectFontName:=$4
		$objectFontSize:=$5
		$objectFontStyle:=$6
		$objectWidth:=$7
	: (Count parameters:C259=6)
		$objectFontName:=$4
		$objectFontSize:=$5
		$objectFontStyle:=$6
	: (Count parameters:C259=5)
		$objectFontName:=$4
		$objectFontSize:=$5
	: (Count parameters:C259=4)
		$objectFontName:=$4
End case 
If ($objectFontName="Arial")
	$objectFontName:="Arial"  // default
End if 
If ($objectFontSize=0)
	$objectFontSize:=9  // default
End if 
If ($objectWidth=0)
	$objectWidth:=100
End if 


  //****CUERPO****
$err:=SR Get Sections ($area;$vl_Sections;$vl_PrintingSesions)
If ($vl_Sections ?? $sectionId)  // si la sección existe verifico que el objeto esté en la sección
	$err:=SR Get Section Object IDs ($area;$sectionId;$objectIDs)
	$createObject:=True:C214
	For ($i;1;Size of array:C274($objectIDs))
		$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
		If (($tableNo=$tableNum) & ($fieldNo=$fieldNum))
			$createObject:=False:C215
		End if 
	End for 
	If ($createObject)  // creo el objeto campo  si no existe en la sección
		$err:=SR Get Section Properties ($area;$sectionID-1;$vl_UseSection;$vl_PrintSection;$previousSectionPosition;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
		$err:=SR Get Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
		If ($previousSectionPosition=$vl_Position)  // verifico que encabezado subencabezado no estén en la misma posición, si están superpuestas desplazo esta sección y las siguientes de 3 pixeles
			SR_MoveSection ($area;3;$sectionId)
			$err:=SR Get Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
		End if 
		$id:=SR_CreateField ($area;$tableNum;$fieldNum;$objectLeft;$vl_Position-1;$objectWidth)  // el objeto es creado un pixel más arriba del limite de la sección (se ajusta más abajo en SR_SetSectionMinHeight)
		$err:=SR_SetObjectTextProperties ($area;$id;$objectFontName;$objectFontSize;$objectFontStyle)
		$r:=SR Get Object Properties ($area;$id;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
		$objectHeight:=$rectBottom-$rectTop  // obtengo la altura del objeto recién creado
		  // si hay suficiente espacio en la sección lo muevo para que quede dentro del limite de la sección
		If (($vl_Position-$previousSectionPosition)>$objectHeight)
			$r:=SR Set Object Properties ($area;$id;SR Property Position;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
		Else 
			$adjustSections:=True:C214  // si no hay espacio en la sección pongo el flag a true para hacer el llamado a la rutina de ajuste de posición de todas las secciones
		End if 
	End if 
	
	  //----
Else 
	  // si no existe la creo tres pixeles más abajo que la sección anterior
	$vl_Sections:=$vl_Sections ?+ $sectionId
	$vl_PrintingSesions:=$vl_PrintingSesions ?+ $sectionId
	$err:=SR Set Sections ($area;$vl_Sections;$vl_PrintingSesions)
	SR_MoveSection ($area;3;$sectionId)
	  // creo el objeto en la sección
	$err:=SR Get Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
	$id:=SR_CreateField ($area;$tableNum;$fieldNum;30;$vl_Position-1;$objectWidth)
	$err:=SR_SetObjectTextProperties ($area;$id;$objectFontName;$objectFontSize;1)
	$adjustSections:=True:C214
End if 

If ($adjustSections)  // ajusto la posición de todas las secciones en función del alto máximo requerido por los objetos que en ella existen
	$err:=SR Get Sections ($area;$vl_Sections;$vl_PrintingSesions)
	For ($i_sections;0;15)
		If ($vl_Sections ?? $i_sections)
			SR_SetSectionMinHeight ($area;$i_sections)
		End if 
	End for 
End if 

  //****LIMPIEZA****










