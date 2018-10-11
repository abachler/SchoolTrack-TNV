//%attributes = {}
  // MÉTODO: IT_SetEnterableByName
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/04/12, 17:43:20
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // IT_SetEnterableByName()
  // ----------------------------------------------------
C_LONGINT:C283($i)
C_BOOLEAN:C305($1;$b_objectIsEnterable)
C_TEXT:C284(${2})

  //INITIALIZATION
$b_objectIsEnterable:=$1

For ($i;2;Count parameters:C259)
	OBJECT SET ENTERABLE:C238(*;${$i};$b_objectIsEnterable)
End for 
