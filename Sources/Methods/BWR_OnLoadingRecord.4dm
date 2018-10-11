//%attributes = {}
  // MÉTODO: BWR_OnLoadingRecord
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 18/08/11, 08:17:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // BWR_OnLoadingRecord()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BOOLEAN:C305(vbBWR_IsNewRecord)


  // CODIGO PRINCIPAL

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 
vLocation:="Input"
bDuplicate:=0
viBWR_RecordWasSaved:=0


dhBWR_OnLoadingRecord ($tablePointer)
BWR_OnActivateFormEvent 
BWR_SetInputFormButtons 

