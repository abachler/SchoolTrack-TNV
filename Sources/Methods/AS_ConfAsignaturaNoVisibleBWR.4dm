//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-02-18, 08:16:29
  // ----------------------------------------------------
  // Método: AS_ConfAsignaturaNoVisibleBWR
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (Size of array:C274(alBWR_recordNumber)>0)
	AS_ConfAsignaturaNoVisibleSTWA ("init";->alBWR_recordNumber)
Else 
	CD_Dlog (0;__ ("Debe haber asignaturas listadas en el explorador"))
End if 