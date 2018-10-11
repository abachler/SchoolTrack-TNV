  // ActualizacionVersion()
  // Por: Alberto Bachler K.: 09-07-14, 19:34:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_versionBD_Build;$l_versionBD_Principal;$l_versionBD_Revision;$l_versionEstructura_Build;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TEXT:C284($t_versionBaseDeDatos;$t_versionEstructura)

C_LONGINT:C283(<>lUSR_CurrentUserID)
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*;"saltar@";(Macintosh command down:C546 & Macintosh option down:C545) & (Windows Ctrl down:C562 & Windows Alt down:C563))
		vl_OperacionReparacion:=0
		
		ARRAY TEXT:C222(at_datafileError;0)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
		$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionEstructura_Build)
		
		$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
		$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
		$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
		
		OBJECT SET TITLE:C194(*;"titulo";__ ("Actualización a SchoolTrack ")+String:C10($l_versionEstructura_Principal)+"."+String:C10($l_versionEstructura_Revision))
		
		
		OBJECT SET TITLE:C194(*;"versionAplicacion";$t_versionEstructura)
		OBJECT SET TITLE:C194(*;"versionBD";$t_versionBaseDeDatos)
		OBJECT SET VISIBLE:C603(*;"bEnviarCorreo";False:C215)
		If (Application type:C494=4D Server:K5:6)
			OBJECT SET TITLE:C194(*;"bOpenCSM@";__ ("Abrir Centro de Seguridad"))
		End if 
		
		
	: (Form event:C388=On Page Change:K2:54)
		$l_pagina:=FORM Get current page:C276
		OBJECT SET VISIBLE:C603(*;"bEnviarCorreo";$l_pagina=3)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CONFIRM:C162("La verificación y compactaje de esta base de datos no ha concluido y la base de datos no ha sido actualizada.\r\r¿Está seguro que desea salir ahora?";"Cancelar";"Salir")
		If (OK=0)
			bSalir:=1
			CANCEL:C270
		End if 
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

