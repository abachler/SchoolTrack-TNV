//%attributes = {}
  //SR_CreateField

  //`xShell, Alberto Bachler
  //Metodo: SR_CreateObject
  //Por abachler
  //Creada el 26/11/2005, 19:31:58
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($area;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$order;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$rows;$cols;$repeatHOffset;$repeatVOffset)
C_TEXT:C284($objName;$calcName)

  //****INICIALIZACIONES****
$area:=$1
$tableNo:=$2
$fieldNo:=$3
$rectLeft:=$4
$rectTop:=$5
$rectRight:=$rectLeft+100
$rectBottom:=$rectTop+5
If (Count parameters:C259=6)
	$rectRight:=$rectLeft+$6
End if 
If (Count parameters:C259=7)
	$rectBottom:=$7
End if 

  //****CUERPO****
$objName:=""
$objType:=SR Object Type Field
$selected:=0
$options:=0
$varType:=0
$arrayElem:=0
$calcType:=0
$calcName:=""
$rows:=0
$cols:=0
$repeatHOffset:=0
$repeatVOffset:=0
$id:=SR Create Object ($area;$objName;$rectTop;$rectLeft;$rectBottom;$rectRight;$objType;$options;$selected;$tableNo;$fieldNo;$varType;$arrayElem;$calcType;$calcName;$rows;$cols;$repeatHOffset;$repeatVOffset)
$0:=$id

  //****LIMPIEZA****