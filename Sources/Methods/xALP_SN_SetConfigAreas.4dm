//%attributes = {}
  //xALP_SN_SetConfigAreas

C_LONGINT:C283($vl_Error)

$vl_Error:=ALP_DefaultColSettings (xALP_SNT_LogList;1;"atSNT_Log_Fecha";__ ("Fecha");50;"7")
$vl_Error:=ALP_DefaultColSettings (xALP_SNT_LogList;2;"alSNT_Log_Hora";__ ("Hora");50;"&/2")
$vl_Error:=ALP_DefaultColSettings (xALP_SNT_LogList;3;"atSNT_Log_Evento";__ ("Evento");403)

ALP_SetDefaultAppareance (xALP_SNT_LogList)
AL_SetColOpts (xALP_SNT_LogList;1;1;1;0;0)
AL_SetRowOpts (xALP_SNT_LogList;0;0;0;0;1;0)
AL_SetCellOpts (xALP_SNT_LogList;0;1;1)
AL_SetMiscOpts (xALP_SNT_LogList;0;0;"\\";0;1)
AL_SetMainCalls (xALP_SNT_LogList;"";"")
AL_SetScroll (xALP_SNT_LogList;0;-3)

AT_Inc (0)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"at_SNT_UserType";__ ("Tipo");80)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"at_SNT_UserName";__ ("Apellidos y Nombres");206)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"at_SNT_Login";__ ("Usuario");115)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"at_SNT_Password";__ ("Contraseña");115)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"at_SNT_UserCode";"";0)
$vl_Error:=ALP_DefaultColSettings (xALP_SchoolNetUsers;AT_Inc ;"ab_SNT_UserInactivo";"";0)

ALP_SetDefaultAppareance (xALP_SchoolNetUsers)
AL_SetColOpts (xALP_SchoolNetUsers;1;1;1;2;0)
AL_SetRowOpts (xALP_SchoolNetUsers;0;0;0;0;1;0)
AL_SetCellOpts (xALP_SchoolNetUsers;0;1;1)
AL_SetMiscOpts (xALP_SchoolNetUsers;0;0;"\\";0;1)
AL_SetMainCalls (xALP_SchoolNetUsers;"";"")
AL_SetScroll (xALP_SchoolNetUsers;0;-3)