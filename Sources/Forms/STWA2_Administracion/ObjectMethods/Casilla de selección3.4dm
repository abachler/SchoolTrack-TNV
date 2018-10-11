  //PREF_Set (0;"HabilitaReemplazo";String(Self->))
<>b_STWA2_Reemplazo:=Choose:C955(Self:C308->=1;True:C214;False:C215)
PREF_Set (0;"STWA2_REEMPLAZO";Choose:C955(<>b_STWA2_Reemplazo;"SI";"NO"))
KRL_ExecuteEverywhere ("STWA2_Activa_reemplazo")

