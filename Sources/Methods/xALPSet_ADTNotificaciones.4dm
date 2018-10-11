//%attributes = {}
  //xALPSet_ADTNotificaciones

_O_C_INTEGER:C282($err)

  //$err:=ALP_DefaultColSettings (xALP_Notificaciones;1;"apRecibirPostulaciones";"";30;"1")
$err:=ALP_DefaultColSettings (xALP_Notificaciones;1;"atPST_Name";__ ("Título");100;"";1;0;0)
$err:=ALP_DefaultColSettings (xALP_Notificaciones;2;"atMailEncargado";__ ("E-Mail");194;"";1;0;1)
$err:=ALP_DefaultColSettings (xALP_Notificaciones;3;"aiPst_ID";"Id Grupo";50;"####")

ALP_SetDefaultAppareance (xALP_Notificaciones;9;1;6;1;8)
AL_SetColOpts (xALP_Notificaciones;1;1;1;1;0)
AL_SetRowOpts (xALP_Notificaciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Notificaciones;0;1;1)
AL_SetMiscOpts (xALP_Notificaciones;0;0;"\\";0;1)
AL_SetCallbacks (xALP_Notificaciones;"";"xALP_ADT_GuardarNotificacion")
AL_SetMainCalls (xALP_Notificaciones;"";"")
AL_SetScroll (xALP_Notificaciones;0;0)
AL_SetEntryOpts (xALP_Notificaciones;3;0;0;1;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Notificaciones;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_Notificaciones;1;"";"";"")
AL_SetDrgSrc (xALP_Notificaciones;2;"";"";"")
AL_SetDrgSrc (xALP_Notificaciones;3;"";"";"")
AL_SetDrgDst (xALP_Notificaciones;1;"";"";"")
AL_SetDrgDst (xALP_Notificaciones;1;"";"";"")
AL_SetDrgDst (xALP_Notificaciones;1;"";"";"")



