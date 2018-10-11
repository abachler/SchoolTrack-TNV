//%attributes = {}
  //QR_MakeTemplateStandard
C_LONGINT:C283($l_versionEstructura_Principal;$l_versionEstructura_Revision)
If (<>lUSR_CurrentUserID<0)
	GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$CurrentReportName)
	KRL_GotoRecord (->[xShell_Reports:54];$recNum;True:C214)
	
	If (Not:C34([xShell_Reports:54]IsStandard:38))
		$r:=CD_Dlog (0;__ ("Los informes estándar deben ser enviados al repositorio de informes.\r\r¿Deseas marcar el informe como estándar y enviarlo al repositorio ahora?");"";__ ("Si");__ ("No"))
		If ($r=1)
			  //MONO 203298
			$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
			$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
			$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")
			[xShell_Reports:54]version_minimo:23:=$t_version
			  //ticket 150948 JVP 20151214
			[xShell_Reports:54]IsStandard:38:=True:C214
			[xShell_Reports:54]Public:8:=True:C214
			$t_dtsRepositorio:=RIN_SubirAlRepositorio 
			If ($t_dtsRepositorio#"")
				  //[xShell_Reports]IsStandard:=True
				  //[xShell_Reports]Public:=True
				If ([xShell_Reports:54]UUID_institucion:33="")
					$newList:=New list:C375
					LIST TO BLOB:C556($newList;[xShell_Reports:54]xAuthorizedGroups:27)
					LIST TO BLOB:C556($newList;[xShell_Reports:54]xAuthorizedUsers:28)
					CLEAR LIST:C377($newList)
				End if 
				SAVE RECORD:C53([xShell_Reports:54])
				Notificacion_Mostrar ("Envio de informe al repositorio";"El informe "+[xShell_Reports:54]ReportName:26+" fue almacenado en el repositorio de informes")
			End if 
			SAVE RECORD:C53([xShell_Reports:54])
		End if 
		
		
	Else 
		$r:=CD_Dlog (0;__ ("Si marcas este informe como no estándar será retirado del repositorio.\r¿Estás seguro de que este modelo debe ser retirado del repositorio?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			$l_error:=RIN_InformeObsoleto ([xShell_Reports:54]UUID:47)
			Case of 
				: ($l_error=-1)
					CD_Dlog (0;__ ("Error. El informe no existe en el repositorio"))
				: ($l_error=-2)
					CD_Dlog (0;__ ("Error: El informe está bloqueado. No puede ser removido del repositorio."))
				: ($l_error=-3)
					CD_Dlog (0;__ ("Error: No existe una correspondencia entre este informe y un informe del repositorio"))
					
				Else 
					[xShell_Reports:54]EnRepositorio:48:=False:C215
					[xShell_Reports:54]IsStandard:38:=False:C215
					SAVE RECORD:C53([xShell_Reports:54])
			End case 
			  //JVP 20151217 ticket 150948
			  //Else 
			  //CD_Dlog (0;vtWS_Resultado)
		End if 
	End if 
End if 
KRL_ReloadAsReadOnly (->[xShell_Reports:54])

SET LIST ITEM:C385(hl_informes;$recNum;[xShell_Reports:54]ReportName:26;$recNum)
SELECT LIST ITEMS BY REFERENCE:C630(hl_informes;$recNum)
Case of 
	: ([xShell_Reports:54]ReportType:2="gSR2")
		$icon:=Use PicRef:K28:4+27512
	: ([xShell_Reports:54]ReportType:2="4DSE")
		$icon:=Use PicRef:K28:4+27514
	: ([xShell_Reports:54]ReportType:2="4DFO")
		$icon:=Use PicRef:K28:4+27513
	: ([xShell_Reports:54]ReportType:2="4DET")
		$icon:=Use PicRef:K28:4+27516
End case 


Case of 
	: ([xShell_Reports:54]IsStandard:38)
		SET LIST ITEM PROPERTIES:C386(hl_Informes;$recNum;False:C215;1;$icon)
	: ([xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID)
		SET LIST ITEM PROPERTIES:C386(hl_Informes;$recNum;True:C214;0;$icon)
	Else 
		SET LIST ITEM PROPERTIES:C386(hl_Informes;$recNum;False:C215;2;$icon)
End case 
_O_REDRAW LIST:C382(hl_Informes)

QR_LoadSelectedReport 
