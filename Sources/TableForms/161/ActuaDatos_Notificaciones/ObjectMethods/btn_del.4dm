ARRAY LONGINT:C221($al_temp_id;0)
$msg:=""

For ($i;1;Size of array:C274(usr_notificaciones))
	If (Not:C34(usr_notificaciones{$i}))
		APPEND TO ARRAY:C911($al_temp_id;SN3_NotificacionUsrID{$i})
		$msg:=$msg+SN3_NotificacionUsr{$i}+", "
	End if 
End for 

ARRAY TEXT:C222(SN3_NotificacionUsr;0)
ARRAY TEXT:C222(SN3_NotificacionMail;0)
ARRAY LONGINT:C221(SN3_NotificacionUsrID;0)
COPY ARRAY:C226($al_temp_id;SN3_NotificacionUsrID)

For ($i;1;Size of array:C274(SN3_NotificacionUsrID))
	$fia:=Find in array:C230(al_usr_id;SN3_NotificacionUsrID{$i})
	If ($fia>0)
		APPEND TO ARRAY:C911(SN3_NotificacionUsr;at_usr_name{$fia})
		APPEND TO ARRAY:C911(SN3_NotificacionMail;at_usr_mail{$fia})
	End if 
End for 

If ($vt_msg#"")
	$msg:="Se quita a "+$msg+" de notificaciones por correo"
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
End if 

OBJECT SET ENABLED:C1123(*;"btn_del";(Size of array:C274(SN3_NotificacionUsrID)>0))
vb_Gral_CFG_Mod:=True:C214

  //$msg:="Ejecución Recepción manual de datos"
  //LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")