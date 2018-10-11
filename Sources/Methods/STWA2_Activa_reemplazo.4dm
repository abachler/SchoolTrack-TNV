//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 11-08-16, 16:35:26
  // ----------------------------------------------------
  // Método: STWA2_Activa_reemplazo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (PREF_fGet (0;"STWA2_REEMPLAZO";"NO")="SI")
	<>b_STWA2_Reemplazo:=True:C214
Else 
	<>b_STWA2_Reemplazo:=False:C215
End if 