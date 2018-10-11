Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(SN3_NotificacionUsr;0)
		ARRAY TEXT:C222(SN3_NotificacionMail;0)
		
		OBJECT SET ENABLED:C1123(*;"btn_del";(Size of array:C274(SN3_NotificacionUsrID)>0))
		
		For ($i;1;Size of array:C274(SN3_NotificacionUsrID))
			$fia:=Find in array:C230(al_usr_id;SN3_NotificacionUsrID{$i})
			If ($fia>0)
				APPEND TO ARRAY:C911(SN3_NotificacionUsr;at_usr_name{$fia})
				APPEND TO ARRAY:C911(SN3_NotificacionMail;at_usr_mail{$fia})
			End if 
		End for 
		
	: (Form event:C388=On Close Box:K2:21)
		SN3_SaveDataReceptionSettings 
		CANCEL:C270
		
End case 

