//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 05-04-17, 08:35:14
  // ----------------------------------------------------
  // Método: ST_ObtieneID
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_idTratamiento)
C_TEXT:C284($t_accion)
$t_accion:=$1
Case of 
	: ($t_accion="obtieneID")
		$l_idTratamiento:=Num:C11(PREF_fGet (0;"IDTratamiento"))
		$l_idTratamiento:=$l_idTratamiento+1
		PREF_Set (0;"IDTratamiento";String:C10($l_idTratamiento))
		$0:=$l_idTratamiento
End case 