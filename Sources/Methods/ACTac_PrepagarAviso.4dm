//%attributes = {}
  //ACTac_PrepagarAviso

$idAviso:=Num:C11($1)
$0:=True:C214

$rnAviso:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$idAviso)
If ($rnAviso#-1)
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$rnAviso)
	If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
		ACTac_Prepagar ($rnAviso)
		UNLOAD RECORD:C212([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	Else 
		$0:=False:C215
	End if 
End if 