//%attributes = {}
  //SR_MoveSection

  //`xShell, Alberto Bachler
  //Metodo: SR_MoveSection
  //Por abachler
  //Creada el 26/11/2005, 18:18:54
  //Modificaciones:
If ("DESCRIPCION"="")
	  //Mueve una sección en el área de diseño
	  //$1: LONGINT, referencia del area de diseño
	  //$2: LONGINT, desfase vertical (negativo para subir, positivo para bajar)
	  //$3: LONGINT, index de la sección límite (por defecto 0 -encabezado- cuando el desfase es positivo; 15 -pié- cuando es negativo)
	  //$4: BOOLEAN, flag para mover objetos, opcional (verdadero por defecto)
	  // las secciones son desplazadas hacia abajo partiendo de la última (pie) hasta la sección límite cuando el desfase vertical es positivo
	  // o desde la la section de referencia hasta la última cuando el desfase es negativo
	
End if 

  //****DECLARACIONES****
C_LONGINT:C283($vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo)
C_LONGINT:C283($area;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$rows;$cols;$repeatHOffset;$repeatVOffset)
C_TEXT:C284($objName;$calcName)
C_LONGINT:C283($1;$2;$verticalOffset;$stopAtSection)
C_BOOLEAN:C305($4)
ARRAY LONGINT:C221($objectIDs;0)

  //****INICIALIZACIONES****
$area:=$1
$verticalOffset:=$2
$moveObjects:=True:C214

If ($verticalOffset>0)
	$startAtSection:=15
	$stopAtSection:=0
	$increment:=-1
Else 
	$startAtSection:=0
	$stopAtSection:=15
	$increment:=1
End if 

If (Count parameters:C259=3)
	$stopAtSection:=$3
End if 
If (Count parameters:C259=4)
	$moveObjects:=$4
End if 



  //****CUERPO****
$err:=SR Get Sections ($area;$vl_Sections;$vl_PrintingSesions)
For ($i_Section;$startAtSection;$stopAtSection;$increment)
	If ($vl_Sections ?? $i_Section)
		$err:=SR Get Section Object IDs ($area;$i_Section;$objectIDs)
		If ($moveObjects)
			For ($i_objects;1;Size of array:C274($objectIDs))
				$r:=SR Get Object Properties ($area;$objectIds{$i_objects};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
				$rectTop:=$rectTop+$verticalOffset
				$rectBottom:=$rectBottom+$verticalOffset
				$r:=SR Set Object Properties ($area;$objectIds{$i_objects};SR Property Position;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
				  //$r:=SR Get Object Properties ($area;$objectIds{$i_objects};$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
			End for 
		End if 
		$err:=SR Get Section Properties ($area;$i_Section;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
		$vl_Position:=$vl_Position+$verticalOffset
		$err:=SR Set Section Properties ($area;$i_Section;$vl_UseSection;$vl_PrintSection;$vl_Position;$vl_Options;$vl_ThrowPage;$vl_MinSpace;$vl_BreakType;$vl_BreakTableNo;$vl_BreakFieldNo;$vs_BreakVarName)
	End if 
End for 

  //****LIMPIEZA****