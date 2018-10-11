//%attributes = {}
  //SN3_CreaRegistroLog
  //RCH
C_POINTER:C301($1;$y_puntero)
C_BOOLEAN:C305($2;$b_registrarEnLogST)
C_TEXT:C284($t_log)

$y_puntero:=$1
If (Count parameters:C259>=2)
	$b_registrarEnLogST:=$2
End if 

$t_log:="Opción "+ST_Qte (OBJECT Get title:C1068($y_puntero->))+" cambiada a "+ST_Coerce_to_Text ($y_puntero)+" en formulario "+Current form name:C1298+"."
SN3_RegisterLogEntry (SN3_Log_Info;$t_log)
If ($b_registrarEnLogST)
	LOG_RegisterEvt ("SN3: "+$t_log)
End if 