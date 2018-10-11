//%attributes = {}
  //xALSet_XS_MethodProperties

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"alXS_MethodsRecID";"ID";40;"####0")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"atXS_Methods_Module";"Módulo";80)
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"atXS_Methods_Alias";"Alias del\rMétodo";230;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"atXS_Methods_Name";"Nombre del\rMétodo";160;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"abXS_Methods_Executable";"Ejecutable\rdesde Consola";85;"Si;No")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"abXS_Methods_AuthRequired";"Requiere\rAutorización";65;"Si;No")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"abXS_Methods_ExecOnClient";"Ejecución\rLocal";65;"Si (Cliente);No (Servidor)")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"alXS_Methods_ID";"")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"alXS_Methods_RecNum";"")
$Error:=ALP_DefaultColSettings (xALP_MethodProperties;AT_Inc ;"atXS_Methods_Description";"")

  //general options
ALP_SetDefaultAppareance (xALP_MethodProperties;9;1;6;2;8)
AL_SetColOpts (xALP_MethodProperties;1;1;1;3;0)
AL_SetRowOpts (xALP_MethodProperties;0;1;0;0;1;0)
AL_SetCellOpts (xALP_MethodProperties;0;1;1)
AL_SetMiscOpts (xALP_MethodProperties;0;0;"\\";0;1)
AL_SetMainCalls (xALP_MethodProperties;"";"")
AL_SetCallbacks (xALP_MethodProperties;"";"xALCB_EX_MethodProperties")
AL_SetScroll (xALP_MethodProperties;0;0)
AL_SetEntryOpts (xALP_MethodProperties;3;0;0;0;0;".")
AL_SetDrgOpts (xALP_MethodProperties;0;30;0)