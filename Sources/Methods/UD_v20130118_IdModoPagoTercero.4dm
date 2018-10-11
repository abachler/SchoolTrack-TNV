//%attributes = {}
  //UD_v20130118_IdModoPagoTercero
C_LONGINT:C283($el;$i;$p)
ARRAY LONGINT:C221($al_RecNum;0)
$p:=IT_UThermometer (1;0;"Verificando datos de Terceros...")
ACTinit_LoadPrefs 
ACTcfgfdp_OpcionesGenerales ("CargaArreglosFormaDePagoXDef")
ALL RECORDS:C47([ACT_Terceros:138])
SELECTION TO ARRAY:C260([ACT_Terceros:138];$al_RecNum)
For ($i;1;Size of array:C274($al_RecNum))
	READ WRITE:C146([ACT_Terceros:138])
	GOTO RECORD:C242([ACT_Terceros:138];$al_RecNum{$i})
	$el:=Find in array:C230(atACT_Modo_de_Pago;[ACT_Terceros:138]Modo_de_Pago:30)
	If ($el#-1)
		[ACT_Terceros:138]Id_Modo_de_Pago:61:=alACT_Modo_de_Pago{$el}
		SAVE RECORD:C53([ACT_Terceros:138])
	Else 
		[ACT_Terceros:138]Modo_de_Pago:30:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
		[ACT_Terceros:138]Id_Modo_de_Pago:61:=vl_FormadePagoXDef
	End if 
	KRL_UnloadReadOnly (->[ACT_Terceros:138])
End for 
IT_UThermometer (-2;$p)