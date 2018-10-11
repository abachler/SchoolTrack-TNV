vbACTSM_SubjectDesh:=True:C214
vbACTSM_BodyDesh:=True:C214
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SendMail";0;1;__ ("Envío de mail"))
DIALOG:C40([xxSTR_Constants:1];"ACT_SendMail")
CLOSE WINDOW:C154
ACTcc_OpcionesAlertas ("InitVars")