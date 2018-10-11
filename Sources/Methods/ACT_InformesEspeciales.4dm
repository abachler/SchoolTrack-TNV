//%attributes = {}
  //ACT_InformesEspeciales


WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_InformesEspeciales";-1;Movable form dialog box:K39:8;__ ("Informes especiales"))
DIALOG:C40([xxSTR_Constants:1];"ACT_InformesEspeciales")
CLOSE WINDOW:C154

If ((ok=1) & (atACT_InformesEspeciales>0))
	KRL_ExecuteMethod (atACT_InformesEspMethods{atACT_InformesEspeciales})
End if 