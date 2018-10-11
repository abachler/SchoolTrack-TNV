//%attributes = {}
  //SRACTac_CalcTotalCargoBuck

C_POINTER:C301($ptr)

$desc:=$1
$aviso:=$2
$var:=$3
$total:=$4
$set:=$5

USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=$desc)
$ptr:=Get pointer:C304($var+String:C10($aviso))
$ptr->:=$ptr->+Sum:C1([ACT_Cargos:173]Monto_Neto:5)
$ptr:=Get pointer:C304($total+String:C10($aviso)+"1")
$ptr->:=$ptr->+(Sum:C1([ACT_Cargos:173]Saldo:23)*-1)

For ($i;2;4)
	ARRAY LONGINT:C221($aCargos;0)
	USE SET:C118("CargosAviso")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=$desc)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aCargos;"")
	$intereses:=0
	For ($j;1;Size of array:C274($aCargos))
		$ptr:=Get pointer:C304("vFechaV"+String:C10($aviso)+String:C10($i))
		GOTO RECORD:C242([ACT_Cargos:173];$aCargos{$j})
		$intereses:=ACTutl_EstimaInteres ([ACT_Cargos:173]ID:1;$ptr->)
		$ptr:=Get pointer:C304($total+String:C10($aviso)+String:C10($i))
		$ptr->:=$ptr->+([ACT_Cargos:173]Saldo:23*-1)+$intereses
	End for 
End for 
USE SET:C118("CargosAviso")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12=$desc)
CREATE SET:C116([ACT_Cargos:173];$set)
DIFFERENCE:C122("CargosAviso";$set;"CargosAviso")
