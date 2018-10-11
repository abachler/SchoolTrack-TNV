//%attributes = {}
  // MÉTODO: IT_SetVisibleByName
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/04/12, 10:07:20
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // IT_SetVisibleByName()
  // ----------------------------------------------------
C_LONGINT:C283($i)
C_BOOLEAN:C305($1;$b_objectVisible)
C_TEXT:C284(${2})

  //INITIALIZATION
$b_objectVisible:=$1



For ($i;2;Count parameters:C259)
	OBJECT SET VISIBLE:C603(*;${$i};$b_objectVisible)
End for 
