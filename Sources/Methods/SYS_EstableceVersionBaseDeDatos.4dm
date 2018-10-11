//%attributes = {}
  //SYS_EstableceVersionBaseDeDatos


C_LONGINT:C283($1;$2;$3;$l_versionEstructura_Principal;$l_versionEstructura_Revision;$l_versionEstructura_Build;$l_versionBD_Build)

If (Count parameters:C259=3)
	$l_versionEstructura_Principal:=$1
	$l_versionEstructura_Revision:=$2
	$l_versionEstructura_Build:=$3
	$t_versionEstructura:=String:C10($l_versionEstructura_Principal)+"."+String:C10($l_versionEstructura_Revision)+"."+String:C10($l_versionEstructura_Build)
Else 
	$t_versionEstructura:=SYS_LeeVersionEstructura 
	$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionEstructura_Build)
End if 


$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)


If ($t_versionBaseDeDatos<$t_versionEstructura)
	PREF_Set (0;"VersionResource";$t_versionEstructura)
	LOG_RegisterEvt ("Base de datos actualizada:\r- desde versión "+$t_versionBaseDeDatos+"\r- a versión "+$t_versionEstructura)
	FLUSH CACHE:C297
End if 