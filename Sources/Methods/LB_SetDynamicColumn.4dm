//%attributes = {}
  // LB_SetDynamicColumn()
  //
  //
  // creado por: Alberto Bachler Klein: 09-02-16, 15:15:10
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_POINTER:C301($5)

C_LONGINT:C283($l_arrayType;$l_columnas;$l_columnNumber)
C_POINTER:C301($y_array;$y_columnArray;$y_columnas;$y_headers;$y_nil)
C_TEXT:C284($t_columnName;$t_header;$t_headerName;$t_listboxName)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY POINTER:C280($ay_headers;0)
ARRAY TEXT:C222($at_headers;0)
ARRAY TEXT:C222($at_nombresColumnas;0)


If (False:C215)
	C_TEXT:C284(LB_SetDynamicColumn ;$1)
	C_LONGINT:C283(LB_SetDynamicColumn ;$2)
	C_TEXT:C284(LB_SetDynamicColumn ;$3)
	C_TEXT:C284(LB_SetDynamicColumn ;$4)
	C_POINTER:C301(LB_SetDynamicColumn ;$5)
End if 

$t_listboxName:=$1
$l_columnNumber:=$2
$t_columnName:=$3
$t_headerName:=$4
$y_array:=$5
If (Count parameters:C259=6)
	$t_header:=$6
Else 
	$t_header:=$t_columnName
End if 

$l_arrayType:=Type:C295($y_array->)

LISTBOX INSERT COLUMN:C829(*;$t_listboxName;$l_columnNumber;$t_columnName;$y_nil;$t_headerName;$y_nil)
$y_columnArray:=OBJECT Get pointer:C1124(Object named:K67:5;$t_columnName)
Case of 
	: ($l_arrayType=LongInt array:K8:19)
		COPY ARRAY:C226($y_array->;$y_columnArray->)
		
	: ($l_arrayType=Text array:K8:16)
		COPY ARRAY:C226($y_array->;$y_columnArray->)
		
	: ($l_arrayType=Boolean array:K8:21)
		COPY ARRAY:C226($y_array->;$y_columnArray->)
End case 

OBJECT SET TITLE:C194(*;$t_headerName;$t_header)

$l_columnas:=LISTBOX Get number of columns:C831(*;$t_listboxName)
LISTBOX GET ARRAYS:C832(*;$t_listboxName;$at_nombresColumnas;$at_headers;$ay_columnas;$ay_headers;$ab_visibles;$ay_estilos)




