//%attributes = {}
  //xALSet_ACT_DocumentarReemp

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"atACT_BancoNombre";__ ("Banco");140)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"atACT_Cuenta";__ ("Cuenta");67;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"atACT_Titular";__ ("Titular");165;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"atACT_Serie";__ ("Serie");59;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"adACT_Fecha";__ ("Fecha");59;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"arACT_MontoCheque";__ ("Monto");63;"|Despliegue_ACT_Pagos";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"abACT_Modificados";"")
$Error:=ALP_DefaultColSettings (xALP_Documentar;AT_Inc ;"atACT_BancoCodigo";"")
AL_SetEnterable (xALP_Documentar;1;3;atACT_BankName)
$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
AL_SetFilter (xALP_Documentar;6;$filter)

  //general options
ALP_SetDefaultAppareance (xALP_Documentar;9;1;6;1;8)
AL_SetColOpts (xALP_Documentar;0;1;1;2)
AL_SetRowOpts (xALP_Documentar;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Documentar;0;1;1)
AL_SetMainCalls (xALP_Documentar;"";"")
AL_SetCallbacks (xALP_Documentar;"xALP_CBIN_ACT_Documentar";"xALP_CB_ACT_Documentar")
AL_SetScroll (xALP_Documentar;0;-3)
AL_SetEntryOpts (xALP_Documentar;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Documentar;0;30;0)