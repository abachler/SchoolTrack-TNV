  //Método de Objeto: [SNT_PublicationPrefs].hl_DataTypesList

  //`======
  // Modified by: abachler (5/2/10)
C_BOOLEAN:C305($b_save)
vb_ConstantesModificadas:=True:C214
  //`======

If (Form event:C388=On Clicked:K2:4)
	$b_save:=(vlSN3_CurrDataType=SN3_DTi_DTrib) | (vlSN3_CurrDataType=SN3_DTi_AvisosCobranza) | (vlSN3_CurrDataType=SN3_DTi_Pagos)
	$b_save:=$b_save | (vlSN3_CurrDataType=45000) | (vlSN3_CurrDataType=45501) | (vlSN3_CurrDataType=AccountTrack)  // HOME NOTICIAS TICKET 198851 // MONO 191729
	If ($b_save)
		SN3_SavePubConfig (vlSN3_CurrConfigLevel)
		UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
	End if 
	GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
	  //If (Selected list items(Self->)=11)  //ASM 20160308 para eliminar la opción de extracurriculares (Solicitado por Ariel)
	  //OBJECT SET ENABLED(cb_PublicarDato;False)
	  //Else 
	  //OBJECT SET ENABLED(cb_PublicarDato;True)
	  //End if 
	OBJECT SET VISIBLE:C603(*;"opciones@";False:C215)
	If ($ref>10000)
		OBJECT SET VISIBLE:C603(*;"elementosGenerales@";True:C214)
		OBJECT SET VISIBLE:C603(*;"Msg";False:C215)
		$index:=Find in array:C230(aDataRefs;$ref)
		If ($index>0)
			$leftOriginal:=aLefts{$index}
			$topOriginal:=aTops{$index}
			$objectNames:=aObjectNames{$index}
			If (($leftOriginal#-1) & ($topOriginal#-1))
				$moveLeft:=225-$leftOriginal
				$moveTop:=188-$topOriginal
				OBJECT GET COORDINATES:C663(*;$objectNames;$left;$top;$right;$bottom)
				If (($left=$leftOriginal) & ($top=$topOriginal))
					OBJECT MOVE:C664(*;$objectNames+"@";$moveLeft;$moveTop)
				End if 
				OBJECT SET VISIBLE:C603(*;$objectNames+"@";True:C214)
			End if 
		End if 
		$cond:=(($ref=SN3_DTi_DTrib) | ($ref=SN3_DTi_Pagos) | ($ref=SN3_DTi_AvisosCobranza) | ($ref=45000) | ($ref=46000) | ($ref=45501))  //MONO 06-11-13: pub informes // HOME NOTICIAS TICKET 198851
		OBJECT SET ENTERABLE:C238(*;"niveles@";$cond)
		If ($cond)
			_O_DISABLE BUTTON:C193(*;"niveles@")
			_O_DISABLE BUTTON:C193(bSendConfNow)
			vt_NivelEditado:=__ ("La configuración seleccionada es para toda la institución, no para un nivel particular.")
		Else 
			_O_ENABLE BUTTON:C192(*;"niveles@")
			_O_ENABLE BUTTON:C192(bSendConfNow)
			vt_NivelEditado:=__ ("Está editando las opciones de publicación para el nivel ")+vtSNT_ConfigLevel
		End if 
		
		If ($ref=45000)  //comunicaciones
			  //vb_ct_lincenciado:=LICENCIA_esModuloAutorizado (1;CommTrack)
			vb_ct_lincenciado:=((LICENCIA_esModuloAutorizado (1;CommTrack)) | (LICENCIA_VerificaModCondorAct ("Comunicaciones")))  //20180219 RCH Ticket 198242.
			OBJECT SET VISIBLE:C603(*;"elementosGenerales3";vb_ct_lincenciado)
		End if 
		
	Else 
		OBJECT SET VISIBLE:C603(*;"elementosGenerales@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Msg";True:C214)
	End if 
	vlSN3_CurrDataType:=$ref
	vtSN3_CurrDataType:=$text
	
	If (vlSN3_CurrDataType=AccountTrack)  // MONO 191729
		OBJECT SET ENABLED:C1123(cb_ApodAcadSameApodCta;True:C214)
	Else 
		OBJECT SET ENABLED:C1123(cb_ApodAcadSameApodCta;False:C215)
	End if 
End if 

