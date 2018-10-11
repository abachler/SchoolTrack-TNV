//%attributes = {}
  //UD_v20120724_SN3IniNewOpt
NIV_LoadArrays 
SN3_InitPubVariables 

For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	READ ONLY:C145([SN3_PublicationPrefs:161])
	QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=<>al_NumeroNivelesSchoolNet{$i})
	SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
	PF_Prom_Oficial:=0
	PF_Prom_Interno:=1
	SN3_ModifyXMLEntry (<>al_NumeroNivelesSchoolNet{$i};10000)
End for 

