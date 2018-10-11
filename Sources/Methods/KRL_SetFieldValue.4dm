//%attributes = {}
  // Método: KRL_SetFieldValue
  //
  // 
  // por Alberto Bachler Klein
  // creación 30/03/17, 17:50:20
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


$y_Campo:=$1
$l_recNum:=$2
$y_valor:=$3
$y_tabla:=Table:C252(Table:C252($y_Campo))

KRL_GotoRecord ($y_tabla;$l_recNum;True:C214)
If (OK=1)
	$y_Campo->:=$y_valor->
	SAVE RECORD:C53($y_tabla->)
End if 

$0:=OK