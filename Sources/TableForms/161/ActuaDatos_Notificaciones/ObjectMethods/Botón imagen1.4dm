SRtbl_ShowChoiceList (0;__ ("Seleccione usuario...");2;->btn_ancargado;True:C214;->at_usr_name)
C_TEXT:C284($vt_msg)

For ($i;1;Size of array:C274(aLinesSelected))
	
	If (Find in array:C230(SN3_NotificacionUsrID;al_usr_id{aLinesSelected{$i}})=-1)
		APPEND TO ARRAY:C911(SN3_NotificacionUsr;at_usr_name{aLinesSelected{$i}})
		APPEND TO ARRAY:C911(SN3_NotificacionMail;at_usr_mail{aLinesSelected{$i}})
		APPEND TO ARRAY:C911(SN3_NotificacionUsrID;al_usr_id{aLinesSelected{$i}})
		vb_Gral_CFG_Mod:=True:C214
		$vt_msg:=$vt_msg+at_usr_name{aLinesSelected{$i}}+", "
	End if 
	
End for 

If ($vt_msg#"")
	$msg:="Se agrega a "+$msg+" a notificaciones por correo"
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
End if 

OBJECT SET ENABLED:C1123(*;"btn_del";(Size of array:C274(SN3_NotificacionUsrID)>0))