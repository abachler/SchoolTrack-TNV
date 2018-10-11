If ((vtXS_CountryFrom="") | (vtXS_LangageFrom="") | ((vtXS_Countryto="") & (cb_CopiarATodosPaises=0)) | ((vtXS_Langageto="") & (cb_CopiarATodosLang=0)) | ((cb_CopyBlobs=0) & (cb_CopyFields=0) & (cb_CopyCommands=0) & (cb_CopyRSRList=0) & (cb_CopyRSRSTR=0) & (cb_CopyRSRText=0)))
	_O_DISABLE BUTTON:C193(bCopy)
Else 
	_O_ENABLE BUTTON:C192(bCopy)
End if 