//%attributes = {}
  //ACTmnu_RecalcConIntereses

C_BOOLEAN:C305($1;$2;$display)
C_DATE:C307($3;$fecha)
  //20120629 RCH
C_LONGINT:C283(vlACT_idACIntereses)

Case of 
	: (Count parameters:C259=3)
		$search:=$1
		$display:=$2
		$fecha:=$3
	: (Count parameters:C259=2)
		$search:=$1
		$display:=$2
		$fecha:=Current date:C33(*)
	: (Count parameters:C259=1)
		$search:=$1
		$display:=True:C214
		$fecha:=Current date:C33(*)
	Else 
		$search:=True:C214
		$display:=True:C214
		$fecha:=Current date:C33(*)
End case 
$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))
COPY SET:C600($set;"tempavisos")
If ($search)
	BWR_SearchRecords (->[ACT_Avisos_de_Cobranza:124])
Else 
	$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))
	USE SET:C118($set)
End if 

If ($fecha#!00-00-00!)
	ACTcfg_ItemsMatricula ("InicializaYLee")
	ACTac_CalculaIntereses (0;$display;$fecha)
	  //20120629 RCH
	vlACT_idACIntereses:=0
	COPY SET:C600("tempavisos";$set)
	FLUSH CACHE:C297
	LOG_RegisterEvt ("Recálculo de intereses realizado.")
	POST KEY:C465(-96)
End if 

