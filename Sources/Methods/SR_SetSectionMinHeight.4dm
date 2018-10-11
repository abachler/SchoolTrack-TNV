//%attributes = {}
  //SR_SetSectionMinHeight

  //`xShell, Alberto Bachler
  //Metodo: SR_SetSectionMinHeight
  //Por abachler
  //Creada el 26/11/2005, 20:17:43
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_TEXT:C284($vs_BreakVarName)
ARRAY LONGINT:C221($objectIDs;0)

  //****INICIALIZACIONES****
$area:=$1
$sectionId:=$2
$minHeight:=0

  //****CUERPO****
  // busco la posición de inicio de la sección obteniendo la posición del marcador de la sección anterior
If ($sectionId>0)
	$err:=SR Get Section Properties ($area;$sectionId-1;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
	$sectionStartAt:=$vl_Position+1
Else 
	$sectionStartAt:=20
End if 
$err:=SR Get Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)

  // determinamos el tamaño mínimo requerido por la sección en función de los objetos que en ella se encuentran (solo considero texto estatico, campos y variables)
  // conservamos la posición original de los objetos para restaurarlas en caso que estén sobre el marcador de sección
$err:=SR Get Section Object IDs ($area;$sectionId;$objectIDs)
ARRAY LONGINT:C221($objectsLeft;Size of array:C274($objectIDs))
ARRAY LONGINT:C221($objectsTop;Size of array:C274($objectIDs))
ARRAY LONGINT:C221($objectsRight;Size of array:C274($objectIDs))
ARRAY LONGINT:C221($objectsBottom;Size of array:C274($objectIDs))
ARRAY LONGINT:C221($objectsType;Size of array:C274($objectIDs))
For ($i;1;Size of array:C274($objectIDs))
	$r:=SR Get Object Properties ($area;$objectIds{$i};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
	$objectsLeft{$i}:=$rectLeft  //
	$objectsTop{$i}:=$rectTop
	$objectsRight{$i}:=$rectRight
	$objectsBottom{$i}:=$rectBottom
	$objectsType{$i}:=$objType
	If (($objType=SR Object Type Field) | ($objType=SR Object Type Variable) | ($objType=SR Object Type Text))
		If ($rectBottom>$minHeight)
			$minHeight:=$rectBottom
		End if 
	End if 
End for 
  // -----

  // calculo el desfase vertical para establecer la nueva posición de la sección
$sectionHeight:=$minHeight+1
$verticalOffset:=$sectionHeight-$vl_Position
If ($verticalOffset>0)
	SR_MoveSection ($area;$verticalOffset;$sectionId+1)
	$err:=SR Get Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
	$vl_position:=$vl_position+$verticalOffset
	$err:=SR Set Section Properties ($area;$sectionId;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
	For ($i;1;Size of array:C274($objectIDs))
		If (($objectsType{$i}=SR Object Type Field) | ($objectsType{$i}=SR Object Type Variable) | ($objectsType{$i}=SR Object Type Text))
			$r:=SR Set Object Properties ($area;$objectIds{$i};SR Property Position;$objName;$objectsTop{$i};$objectsLeft{$i};$objectsBottom{$i};$objectsRight{$i};$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
		End if 
	End for 
End if 


  //****LIMPIEZA****