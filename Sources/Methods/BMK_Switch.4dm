//%attributes = {}
  // Método: BMK_Switch
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/10/09, 12:47:32
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(<>vlBMK_TriggerExecutions;<>vlBMK_TriggerExecutionTime)
C_REAL:C285(<>vrBMK_MeanTriggerExecutions)
C_BOOLEAN:C305(<>vbBMK_Active;$1)
C_POINTER:C301($2;$nilPointer)



  // Código principal



If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684;$1)
End if 


If (Count parameters:C259=2)
	vyBMK_ButtonPointer:=$2
End if 

<>vbBMK_Active:=$1
If (Application type:C494=4D Server:K5:6)
	ARRAY TEXT:C222(<>atBMK_TriggerTable;0)
	ARRAY LONGINT:C221(<>alBMK_TriggerExecutions;0)
	ARRAY LONGINT:C221(<>alBMK_TriggerExecutionsTime;0)
	ARRAY REAL:C219(<>arBMK_TriggerExecutionMean;0)
	ARRAY TEXT:C222(atBMK_TriggerTable;0)
	ARRAY LONGINT:C221(alBMK_TriggerExecutions;0)
	ARRAY LONGINT:C221(alBMK_TriggerExecutionsTime;0)
	ARRAY REAL:C219(arBMK_TriggerExecutionMean;0)
	
	
	<>vlBMK_TriggerExecutions:=0
	<>vlBMK_TriggerExecutionTime:=0
	<>vrBMK_MeanTriggerExecutions:=0
Else 
	ARRAY LONGINT:C221(alBMK_Milliseconds;0)
	ARRAY TEXT:C222(<>atBMK_TriggerTable;0)
	ARRAY LONGINT:C221(<>alBMK_TriggerExecutions;0)
	ARRAY LONGINT:C221(<>alBMK_TriggerExecutionsTime;0)
	ARRAY REAL:C219(<>arBMK_TriggerExecutionMean;0)
	ARRAY TEXT:C222(atBMK_TriggerTable;0)
	ARRAY LONGINT:C221(alBMK_TriggerExecutions;0)
	ARRAY LONGINT:C221(alBMK_TriggerExecutionsTime;0)
	ARRAY REAL:C219(arBMK_TriggerExecutionMean;0)
	
End if 





