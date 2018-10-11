//%attributes = {}
  //xALSet_ACT_ConfigBancos

C_LONGINT:C283($Error)
AT_Inc (0)
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"atACT_BankID";__ ("Código");60;"";0;0;1)
  //If (<>vtXS_CountryCode="mx")
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"atACT_BankName";__ ("Nombre");228;"";0;0;1)
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"atACT_BankNumConvenio";__ ("Número de convenio");120;"";0;0;1)
  //Else 
  //$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"atACT_BankName";"Nombre";348;"";0;0;1)
  //End if 
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"abACT_BankEstandar";"")
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"alACT_BankRecNum";"")
$error:=ALP_DefaultColSettings (xALP_Bancos;AT_Inc ;"abACT_BankModified";"")

ALP_SetDefaultAppareance (xALP_Bancos;9;1;6;1;8)
AL_SetColOpts (xALP_Bancos;1;1;1;3;0)
AL_SetRowOpts (xALP_Bancos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Bancos;0;1;1)
AL_SetMainCalls (xALP_Bancos;"";"")
AL_SetCallbacks (xALP_Bancos;"";"xALP_CB_ACT_Bancos")
AL_SetScroll (xALP_Bancos;0;-3)
AL_SetEntryOpts (xALP_Bancos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Bancos;0;30;0)

  //C_LONGINT($Error)
  //
  //$error:=ALP_DefaultColSettings (xALP_Bancos;1;"atACT_BankID";"Código";60;"";0;0;1)
  //$error:=ALP_DefaultColSettings (xALP_Bancos;2;"atACT_BankName";"Nombre";348;"";0;0;1)
  //$error:=ALP_DefaultColSettings (xALP_Bancos;3;"abACT_BankEstandar";"")
  //$error:=ALP_DefaultColSettings (xALP_Bancos;4;"alACT_BankRecNum";"")
  //$error:=ALP_DefaultColSettings (xALP_Bancos;5;"abACT_BankModified";"")
  //
  //ALP_SetDefaultAppareance (xALP_Bancos;9;1;6;1;8)
  //AL_SetColOpts (xALP_Bancos;1;1;1;3;0)
  //AL_SetRowOpts (xALP_Bancos;0;0;0;0;1;0)
  //AL_SetCellOpts (xALP_Bancos;0;1;1)
  //AL_SetMainCalls (xALP_Bancos;"";"")
  //AL_SetCallbacks (xALP_Bancos;"";"xALP_CB_ACT_Bancos")
  //AL_SetScroll (xALP_Bancos;0;-3)
  //AL_SetEntryOpts (xALP_Bancos;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
  //AL_SetDrgOpts (xALP_Bancos;0;30;0)