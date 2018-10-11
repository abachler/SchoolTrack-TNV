//%attributes = {}
  //STR_VerificaBloqueoSitFinal


<>vd_FechaBloqueoSchoolTrack:=Date:C102(PREF_fGet (0;"BloqueoRecalculosSchoolTrack";String:C10(!00-00-00!)))
If (<>vd_FechaBloqueoSchoolTrack#!00-00-00!)
	If (<>vd_FechaBloqueoSchoolTrack<=Current date:C33(*))
		<>vb_BloquearModifSituacionFinal:=True:C214
	Else 
		<>vb_BloquearModifSituacionFinal:=False:C215
	End if 
Else 
	<>vb_BloquearModifSituacionFinal:=False:C215
End if 