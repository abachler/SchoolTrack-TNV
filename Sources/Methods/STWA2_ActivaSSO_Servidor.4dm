//%attributes = {}
  //STWA2_ActivaSSO_Servidor
If (PREF_fGet (0;"STWA2_SERVIVIO_SSO";"NO")="SI")
	<>b_STWA2_ssoActivo:=True:C214
Else 
	<>b_STWA2_ssoActivo:=False:C215
End if 