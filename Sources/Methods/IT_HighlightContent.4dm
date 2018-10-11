//%attributes = {}
  // IT_HighlightContent()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 17:25:09
  // ---------------------------------------------
C_POINTER:C301($1)

C_POINTER:C301($y_objectPointer)

If (False:C215)
	C_POINTER:C301(IT_HighlightContent ;$1)
End if 

  // CÓDIGO
$y_objectPointer:=$1
HIGHLIGHT TEXT:C210($y_objectPointer->;1;Length:C16($y_objectPointer->)+1)