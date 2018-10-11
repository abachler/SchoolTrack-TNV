//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 17-05-17, 11:30:04
  // ----------------------------------------------------
  // Método: UD_v20170517_EnvioDatosCondor
  // Descripción
  // Método que envía todos los datos a cóndor. Pedido para pasar a sync2
  //
  // Parámetros
  // ----------------------------------------------------

$l_proc:=IT_UThermometer (1;0;"Generando y enviando información a cóndor sync...")
If (SN3_CheckNotColegium )  //se envia solo si es server oficial
	CONDOR_ExportData (True:C214)
End if 
IT_UThermometer (-2;$l_proc)