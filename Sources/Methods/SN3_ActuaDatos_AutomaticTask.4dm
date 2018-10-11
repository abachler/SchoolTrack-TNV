//%attributes = {}


While (Not:C34(<>stopDaemons))
	C_LONGINT:C283($ticks)
	SN3_LoadDataReceptionSettings 
	If (SN3_DataRecInterval>0)
		$ticks:=SN3_DataRecInterval*3600
		If (<>bXS_esServidorOficial)
			SN3_ActuaDatos_CapturaDatos 
			  //ID encargado SN3_ActuaDatosEncargadoID
			  //array de IDs de los demas usuarios para notificaciones SN3_NotificacionUsrID
			
			GET REGISTERED CLIENTS:C650($clients;$methods)
			ARRAY LONGINT:C221($al_id_usr;0)
			
			For ($i;1;Size of array:C274($clients))
				ARRAY TEXT:C222($at_usr_desc;0)
				AT_Text2Array (->$at_usr_desc;$clients{$i};" ")
				If (Size of array:C274($at_usr_desc)>=2)
					APPEND TO ARRAY:C911($al_id_usr;Num:C11($at_usr_desc{2}))
				End if 
			End for 
			
			$fia:=Find in array:C230($al_id_usr;SN3_ActuaDatosEncargadoID)
			
			If ($fia>0)
				READ ONLY:C145([XShell_FatObjects:86])
				$fatObjectName:="SN3_ActuaDatos@"
				QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatObjectName)
				$vl_regs:=Records in selection:C76([XShell_FatObjects:86])
				REDUCE SELECTION:C351([XShell_FatObjects:86];0)
				If ($vl_regs>0)
					EXECUTE ON CLIENT:C651($clients{$fia};"SN3_ActuaDatos_OpenMSG";$vl_regs)
				End if 
			End if 
		End if 
	Else 
		$ticks:=15*3600
	End if 
	DELAY PROCESS:C323(Current process:C322;$ticks)
End while 
