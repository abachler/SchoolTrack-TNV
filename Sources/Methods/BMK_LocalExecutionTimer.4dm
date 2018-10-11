//%attributes = {}
  // Método: BMK_LocalExecutionTimer
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/10/09, 13:07:36
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305($action;<>vbBMK_Active)

  // Código principal

If (<>vbBMK_Active)
	$action:=$1
	If ($action)  //start
		vlBMK_Milliseconds:=Milliseconds:C459
	Else 
		APPEND TO ARRAY:C911(alBMK_Milliseconds;Milliseconds:C459-vlBMK_Milliseconds)
		vlBMK_Milliseconds:=0
	End if 
End if 







