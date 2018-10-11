//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 24-07-18, 09:36:47
  // ----------------------------------------------------
  // Método: IT_SetButtonStateObject
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


For ($i;2;Count parameters:C259)
	If ($1)
		OBJECT SET ENABLED:C1123(${$i}->;True:C214)
	Else 
		OBJECT SET ENABLED:C1123(${$i}->;False:C215)
	End if 
End for 