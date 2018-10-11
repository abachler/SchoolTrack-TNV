//%attributes = {}
  // MÉTODO: MPA_Recalculos_Matriz
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:49:20
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MPA_Recalculos_Matriz()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($4)
C_BOOLEAN:C305($5)

C_BLOB:C604($x_recNumArray)
C_BOOLEAN:C305($b_CalculoDimensiones;$b_CalculoEjes;$b_CalculoResultadoFinal;$b_iniciarProceso)
C_LONGINT:C283($l_IDMatriz;$l_ProcessID)

ARRAY LONGINT:C221($al_RecNumsCalculosMPA;0)

If (False:C215)
	C_LONGINT:C283(MPA_Recalculos_Matriz ;$1)
	C_BOOLEAN:C305(MPA_Recalculos_Matriz ;$2)
	C_BOOLEAN:C305(MPA_Recalculos_Matriz ;$3)
	C_BOOLEAN:C305(MPA_Recalculos_Matriz ;$4)
	C_BOOLEAN:C305(MPA_Recalculos_Matriz ;$5)
End if 




  // CODIGO PRINCIPAL
$l_IDMatriz:=$1
Case of 
	: (Count parameters:C259=5)
		$b_iniciarProceso:=$5
		$b_CalculoDimensiones:=$4
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=4)
		$b_CalculoDimensiones:=$4
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=3)
		$b_CalculoEjes:=$3
		$b_CalculoResultadoFinal:=$2
		
	: (Count parameters:C259=2)
		$b_CalculoResultadoFinal:=$2
		
		
		
	: (Count parameters:C259=0)
		$l_IDMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
End case 

QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91;=;$l_IDMatriz)
ARRAY LONGINT:C221($al_RecNumsCalculosMPA;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumsCalculosMPA;"")
BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumsCalculosMPA)
If ($b_iniciarProceso)
	$l_ProcessID:=New process:C317("MPAdbu_Recalculos";256000;"Recalculo Matriz "+String:C10($l_IDMatriz);$x_recNumArray;$b_CalculoResultadoFinal;$b_CalculoEjes;$b_CalculoDimensiones)
Else 
	MPAdbu_Recalculos ($x_recNumArray;$b_CalculoResultadoFinal;$b_CalculoEjes;$b_CalculoDimensiones)
End if 