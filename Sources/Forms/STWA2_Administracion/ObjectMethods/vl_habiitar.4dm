<>b_STWA2_ssoActivo:=Choose:C955(Self:C308->=1;True:C214;False:C215)
PREF_Set (0;"STWA2_SERVIVIO_SSO";Choose:C955(<>b_STWA2_ssoActivo;"SI";"NO"))
KRL_ExecuteEverywhere ("STWA2_ActivaSSO_Servidor")