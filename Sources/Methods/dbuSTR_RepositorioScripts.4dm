//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 04-09-18, 19:03:36
  // ----------------------------------------------------
  // Método: dbuSTR_RepositorioScripts
  // Descripción
  // Para tener código de scripts para comenzar a revisar temas. Basado en dbuACT_RepositorioScripts
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($t_accion)
C_POINTER:C301($y_ptr1)

If (Count parameters:C259>=1)
	
	$t_accion:=$1
	If (Count parameters:C259>=2)
		$y_ptr1:=$2
	End if 
	
	Case of 
		: ($t_accion="")
			
	End case 
	
End if 