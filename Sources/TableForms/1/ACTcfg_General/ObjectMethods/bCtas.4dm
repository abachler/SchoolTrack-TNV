ACTcfg_LoadBancos 
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcfg_CtasBancarias";0;4;__ ("Configuración de Cuentas Bancarias"))
DIALOG:C40([xxSTR_Constants:1];"ACTcfg_CtasBancarias")
CLOSE WINDOW:C154
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
PREF_SetBlob (0;"ACT_CtasColegio";xBlob)
PREF_Set (0;"ACT_UsarCtas";String:C10(cb_UtilizarCtas))
ARRAY TEXT:C222(atACT_CtaColegioCod;0)
ARRAY TEXT:C222(atACT_CtaColegioBanco;0)
ARRAY TEXT:C222(atACT_CtaColegioCta;0)
SET BLOB SIZE:C606(xBlob;0)