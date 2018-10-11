//%attributes = {}
  //UD_v20130402_SN3AgendaOpc
  //NIV_LoadArrays 
  //SN3_InitPubVariables 
  //CD_THERMOMETREXSEC (1;0;__ ("Agregando datos a la configuración de publicación..."))
  //For ($i;1;Size of array(<>al_NumeroNivelesSchoolNet))
  //READ ONLY([SN3_PublicationPrefs])
  //QUERY([SN3_PublicationPrefs];[SN3_PublicationPrefs]Nivel=<>al_NumeroNivelesSchoolNet{$i})
  //SN3_ParseConfigXML (->[SN3_PublicationPrefs]xData)
  //cb_AgEnvioAutoRel:=1
  //cb_AgEnvioAutoAlu:=1
  //SN3_ModifyXMLEntry (<>al_NumeroNivelesSchoolNet{$i};SN3_DTi_EventosAgenda)
  //CD_THERMOMETREXSEC (0;$i/Size of array(<>al_NumeroNivelesSchoolNet)*100)
  //End for 
  //CD_THERMOMETREXSEC (-1)

READ ONLY:C145([SN3_PublicationPrefs:161])
ALL RECORDS:C47([SN3_PublicationPrefs:161])
ARRAY LONGINT:C221($rns;0)
LONGINT ARRAY FROM SELECTION:C647([SN3_PublicationPrefs:161];$rns)
For ($i;1;Size of array:C274($rns))
	KRL_GotoRecord (->[SN3_PublicationPrefs:161];$rns{$i};False:C215)
	$nivel:=[SN3_PublicationPrefs:161]Nivel:1
	SN3_InitPubVariables 
	SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
	cb_AgEnvioAutoRel:=1
	cb_AgEnvioAutoAlu:=1
	SN3_ModifyXMLEntry ($nivel;SN3_DTi_EventosAgenda)
End for 