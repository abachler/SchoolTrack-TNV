  //llamar a dummy
ACTfear_OpcionesGenerales ("GuardaBlob";->vlACT_RSSel)

vt_msg:=ACTfear_FEParamGetTiposCbte (vlACT_RSSel)
WDW_OpenFormWindow (->[xxSTR_Constants:1];"CMT_Console";-1;4;__ ("Códigos de comprobantes"))
DIALOG:C40([xxSTR_Constants:1];"CMT_Console")
CLOSE WINDOW:C154