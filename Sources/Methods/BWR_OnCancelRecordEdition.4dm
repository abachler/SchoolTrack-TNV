//%attributes = {}
  // MÉTODO: BWR_OnCancelRecordEdition
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 16/08/11, 09:57:42
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // BWR_OnCancelRecordEdition()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
C_BOOLEAN:C305($trapped)

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

$trapped:=dhBWR_OnCancelRecordEdition ($tablePointer)

$0:=$trapped