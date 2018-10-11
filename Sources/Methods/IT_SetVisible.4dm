//%attributes = {}
  // MÉTODO: IT_SetVisible
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/04/12, 12:23:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // IT_SetVisible()
  // ----------------------------------------------------
C_BOOLEAN:C305($1)
C_POINTER:C301(${2})

C_BOOLEAN:C305($b_objectIsVisible)
C_LONGINT:C283($i)

If (False:C215)
	C_BOOLEAN:C305(IT_SetVisible ;$1)
	C_POINTER:C301(IT_SetVisible ;${2})
End if 






  //CODIGO PRINCIPAL
$b_objectIsVisible:=$1
For ($i;2;Count parameters:C259)
	OBJECT SET VISIBLE:C603(${$i}->;$b_objectIsVisible)
End for 
