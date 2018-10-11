COPY ARRAY:C226(at_IDNivel;$at_IDNivel)
For ($i;1;Size of array:C274(aiADT_NivNo))
	QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=aiADT_NivNo{$i})
	If (([SN3_PublicationPrefs:161]DTS_Modificacion:3>[SN3_PublicationPrefs:161]DTS_Envio:4) | ([SN3_PublicationPrefs:161]DTS_Envio:4=""))
		$at_IDNivel{$i}:="<B<I"+$at_IDNivel{$i}
	End if 
End for 
$niveles:=AT_array2text (->$at_IDNivel)
$choice:=Pop up menu:C542($niveles;aiADT_NivNo)
If ($choice>0)
	$nivel:=aiADT_NivNo{$choice}
	aiADT_NivNo:=$choice
	SN3_SavePubConfig (vlSN3_CurrConfigLevel)
	UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
	SN3_LoadPubConfig ($nivel)
	vlSN3_CurrConfigLevel:=aiADT_NivNo{$choice}
	vtSNT_ConfigLevel:=at_IDNivel{$choice}
	vt_NivelEditado:=__ ("Está editando las opciones de publicación para el nivel ")+vtSNT_ConfigLevel
	OBJECT SET TITLE:C194(bSendConfNow;__ ("Enviar ahora ")+vtSNT_ConfigLevel)
End if 