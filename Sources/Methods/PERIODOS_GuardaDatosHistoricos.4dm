//%attributes = {}
  //PERIODOS_GuardaDatosHistoricos

C_LONGINT:C283($1;$numeroNivel;$2;$año)
C_TEXT:C284($key)

$numeroNivel:=$1
$año:=$2

$key:="0."+String:C10($numeroNivel)+"."+String:C10($año)
$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key;True:C214)
If ($recNum>=0)
	
	$OTref_Periodos:=OT New 
	OT PutArray ($OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
	OT PutArray ($OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
	OT PutArray ($OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
	$blob:=OT ObjectToNewBLOB ($OTref_Periodos)
	OT Clear ($OTref_Periodos)
	
	[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7:=$blob
	
	If (Size of array:C274(adSTR_Periodos_Desde)>0)
		[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=adSTR_Periodos_Desde{1}
		[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
	End if 
	SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
End if 