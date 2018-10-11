//%attributes = {}
  //BBLpat_CambiaPrefijoBarcode

C_LONGINT:C283($0;$pID)
C_TEXT:C284($1;$3;$prefijoActual;$nuevoPrefijo)
C_TEXT:C284($stringID;$filler)

$prefijoActual:=$1
$nuevoPrefijo:=$2

ARRAY LONGINT:C221($lectorID;0)
ARRAY TEXT:C222($barCode;0)
ARRAY TEXT:C222($unformatBarCode;0)

SELECTION TO ARRAY:C260([BBL_Lectores:72]ID:1;$lectorID)
AT_RedimArrays (Size of array:C274($lectorID);->$barCode;->$unformatBarCode)
For ($i;1;Size of array:C274($lectorID))
	$stringID:=String:C10($lectorID{$i};"#########000000")
	$barCode{$i}:="*"+$nuevoPrefijo+$stringID+"*"
	$unformatBarCode{$i}:=$nuevoPrefijo+String:C10($lectorID{$i})
End for 
$pID:=IT_UThermometer (1;0;__ ("Reemplazando prefijo ")+$prefijoActual+__ (" por ")+$nuevoPrefijo;9)
$0:=KRL_Array2Selection (->$barCode;->[BBL_Lectores:72]Código_de_barra:10;->$unformatBarCode;->[BBL_Lectores:72]BarCode_SinFormato:38)
$pID:=IT_UThermometer (-2;$pId)