//%attributes = {}
  // Método: BMK_TriggerExecutionTimer
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/10/09, 13:27:00
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305($action)
C_LONGINT:C283(<>vlBMK_TriggerExecutions;<>vlBMK_TriggerExecutionTime)
C_BOOLEAN:C305(<>vbBMK_Active;$1)
C_LONGINT:C283($triggerLevel;$dataBaseEvent;$tableNum;$recordNum)

  // Código principal
If (<>vbBMK_Active)
	$action:=$1
	TRIGGER PROPERTIES:C399(Trigger level:C398;$dataBaseEvent;$tableNum;$recordNum)
	$tableName:=Table name:C256($tableNum)
	$el:=Find in array:C230(<>atBMK_TriggerTable;$tableName)
	If ($el<0)
		APPEND TO ARRAY:C911(<>atBMK_TriggerTable;$tableName)
		APPEND TO ARRAY:C911(<>alBMK_TriggerExecutions;0)
		APPEND TO ARRAY:C911(<>alBMK_TriggerExecutionsTime;0)
		APPEND TO ARRAY:C911(<>arBMK_TriggerExecutionMean;0)
		$el:=Size of array:C274(<>atBMK_TriggerTable)
	End if 
	If ($action)  //start
		vlBMK_TGMilliseconds:=Milliseconds:C459
	Else 
		<>vlBMK_TriggerExecutionTime:=<>vlBMK_TriggerExecutionTime+(Milliseconds:C459-vlBMK_TGMilliseconds)
		<>vlBMK_TriggerExecutions:=<>vlBMK_TriggerExecutions+1
		$mean:=Round:C94(<>vlBMK_TriggerExecutionTime/<>vlBMK_TriggerExecutions;2)
		<>alBMK_TriggerExecutions{$el}:=<>alBMK_TriggerExecutions{$el}+1
		<>alBMK_TriggerExecutionsTime{$el}:=<>alBMK_TriggerExecutionsTime{$el}+(Milliseconds:C459-vlBMK_TGMilliseconds)
		<>arBMK_TriggerExecutionMean{$el}:=Round:C94(<>alBMK_TriggerExecutionsTime{$el}/<>alBMK_TriggerExecutions{$el};2)
		<>vrBMK_MeanTriggerExecutions:=<>arBMK_TriggerExecutionMean{$el}
	End if 
End if 

