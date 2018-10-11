//%attributes = {}
  //SN3_LoadPubConfig

C_LONGINT:C283($1;$nivel)

$nivel:=$1
SN3_InitPubVariables 

READ ONLY:C145([SN3_PublicationPrefs:161])
QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$nivel)
Case of 
	: (Records in selection:C76([SN3_PublicationPrefs:161])=0)
		SN3_SavePubConfig ($nivel)
		SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
	: (Records in selection:C76([SN3_PublicationPrefs:161])=1)
		SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
	Else 
		KRL_DeleteSelection (->[SN3_PublicationPrefs:161];False:C215)
		SN3_SavePubConfig ($nivel)
		SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
End case 
UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
SN3_SetPubInterfaceObjects 
SN3_SetPublicarCheckBox 

