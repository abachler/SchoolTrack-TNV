//%attributes = {}
  //ACTbol_RegisterEvt

C_TEXT:C284($1;$set)
C_LONGINT:C283($n)
$set:=$1

READ ONLY:C145([ACT_Boletas:181])
USE SET:C118($set)
FIRST RECORD:C50([ACT_Boletas:181])
For ($n;1;Records in selection:C76([ACT_Boletas:181]))
	LOG_RegisterEvt ("Emisión de "+[ACT_Boletas:181]TipoDocumento:7+" número "+String:C10([ACT_Boletas:181]Numero:11))
	NEXT RECORD:C51([ACT_Boletas:181])
End for 
CLEAR SET:C117($set)