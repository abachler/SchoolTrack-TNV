  // Método: Método de Objeto: BMK_Results.bCopyPastboard
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 10/10/09, 11:03:17
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
$results:=vtBMK_taskName+"\r\rIteraciones: "+vtBMK_Executions+"\rMedia: "+vtBMK_Mean+"\rMax: "+vtBMK_Maximum+"\rMin: "+vtBMK_Minimum+"\r\rEjecuciones Trigger: "+String:C10(<>vlBMK_TriggerExecutions)+"\rTiempo promedio Trigger: "+String:C10(Round:C94(<>vrBMK_MeanTriggerExecutions;2))+"\rTotal ejecución en trigger: "+String:C10(<>vlBMK_TriggerExecutionTime)
SET TEXT TO PASTEBOARD:C523($results)

