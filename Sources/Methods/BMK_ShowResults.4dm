//%attributes = {}
  //BMK_ShowResults

  // Método: BMK_ShowResult
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/10/09, 13:45:47
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(<>vlBMK_TriggerExecutions;<>vlBMK_TriggerExecutionTime;vlBMK_MeanTriggerExecutions)
C_BOOLEAN:C305(<>vbBMK_Active)
C_POINTER:C301(vyBMK_ButtonPointer)
C_TEXT:C284(vtBMK_taskName;vtBMK_Executions;vtBMK_Mean;vtBMK_Maximum;vtBMK_Minimum;vtBMK_LocalExecutionTime;vtBMK_MeanTriggerExecutions;vtBMK_TriggerExecutionTime)
ARRAY TEXT:C222(atBMK_TriggerTable;0)
ARRAY LONGINT:C221(alBMK_TriggerExecutions;0)
ARRAY LONGINT:C221(alBMK_TriggerExecutionsTime;0)
ARRAY REAL:C219(arBMK_TriggerExecutionMean;0)



  // Código principal
If (Count parameters:C259=1)
	vtBMK_taskName:=$1
End if 



If (<>vbBMK_Active)
	vtBMK_Executions:=String:C10(Size of array:C274(alBMK_Milliseconds))
	vtBMK_Mean:=BMK_TimeStringWithMilliseconds (Round:C94(AT_Mean (->alBMK_Milliseconds;1);0))
	vtBMK_Maximum:=BMK_TimeStringWithMilliseconds (AT_Maximum (->alBMK_Milliseconds;1))
	vtBMK_Minimum:=BMK_TimeStringWithMilliseconds (AT_Minimum (->alBMK_Milliseconds;1))
	vtBMK_LocalExecutionTime:=BMK_TimeStringWithMilliseconds (AT_GetSumArray (->alBMK_Milliseconds;True:C214))
	
	  //obtengo los valores de los contadores de ejecución de triggers desde el server
	If (Application type:C494=4D Remote mode:K5:5)
		GET PROCESS VARIABLE:C371(-1;<>vlBMK_TriggerExecutions;<>vlBMK_TriggerExecutions;<>vlBMK_TriggerExecutionTime;<>vlBMK_TriggerExecutionTime;<>atBMK_TriggerTable;atBMK_TriggerTable;<>alBMK_TriggerExecutions;alBMK_TriggerExecutions;<>alBMK_TriggerExecutionsTime;alBMK_TriggerExecutionsTime;<>arBMK_TriggerExecutionMean;arBMK_TriggerExecutionMean)
	Else 
		COPY ARRAY:C226(<>atBMK_TriggerTable;atBMK_TriggerTable)
		COPY ARRAY:C226(<>alBMK_TriggerExecutions;alBMK_TriggerExecutions)
		COPY ARRAY:C226(<>alBMK_TriggerExecutionsTime;alBMK_TriggerExecutionsTime)
		COPY ARRAY:C226(<>arBMK_TriggerExecutionMean;arBMK_TriggerExecutionMean)
	End if 
	
	If (<>vlBMK_TriggerExecutions>0)
		vtBMK_MeanTriggerExecutions:=BMK_TimeStringWithMilliseconds (Int:C8(<>vlBMK_TriggerExecutionTime/<>vlBMK_TriggerExecutions))
	End if 
	vtBMK_TriggerExecutionTime:=BMK_TimeStringWithMilliseconds (<>vlBMK_TriggerExecutionTime)
	
	$wRef:=Open form window:C675("BMK_Results";0;On the left:K39:2;At the top:K39:5)
	SET WINDOW TITLE:C213("Benchmarking")
	DIALOG:C40("BMK_Results")
	CLOSE WINDOW:C154
	
	  //  `inicializo y detengo el modo benchmarkink
	  //BMK_Switch (False)
End if 

