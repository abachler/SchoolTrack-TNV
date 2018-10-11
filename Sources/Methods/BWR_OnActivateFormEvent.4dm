//%attributes = {}
  //BWR_OnActivateFormEvent

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 18/07/03, 14:36:05
  // -------------------------------------------------------------------------------
  // Metodo: BWR_OnActivateFormEvent
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_POINTER:C301($1;$tablePointer)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
For ($i;1;Count menu items:C405(1))
	DISABLE MENU ITEM:C150(1;$i)
End for 
For ($i;1;Count menu items:C405(3))
	DISABLE MENU ITEM:C150(3;$i)
End for 
For ($i;1;Count menu items:C405(4))
	DISABLE MENU ITEM:C150(4;$i)
End for 
For ($i;1;Count menu items:C405(5))
	DISABLE MENU ITEM:C150(5;$i)
End for 
vb_RecordInInputForm:=True:C214

BWR_SetInputFormButtons ($tablePointer;vlBWR_BrowsingMethod)

  //call application specific code
dhBWR_OnActivateFormEvent ($tablePointer)



  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------



