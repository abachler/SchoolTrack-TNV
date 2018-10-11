//%attributes = {}
  // SYS_LeeVersionBaseDeDatos()
  // Por: Alberto Bachler K.: 25-03-15, 09:40:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2;$y_pointer)
C_LONGINT:C283($l_versionBD_Principal;$l_versionBD_Revision;$l_versionBD_Build)
C_TEXT:C284($t_VersionBD)


$vers:=PREF_fGet (0;"VersionResource")
If ($vers#"")
	If (ST_CountWords ($vers;1;".")=4)
		$l_versionBD_Principal:=Num:C11(ST_GetWord ($vers;1;"."))
		$l_versionBD_Revision:=Num:C11(ST_GetWord ($vers;2;"."))
		$l_versionBD_Build:=Num:C11(ST_GetWord ($vers;4;"."))
	Else 
		$l_versionBD_Principal:=Num:C11(ST_GetWord ($vers;1;"."))
		$l_versionBD_Revision:=Num:C11(ST_GetWord ($vers;2;"."))
		$l_versionBD_Build:=Num:C11(ST_GetWord ($vers;3;"."))
	End if 
	$t_VersionBD:=String:C10($l_versionBD_Principal;"00")+"."+String:C10($l_versionBD_Revision;"00")+"."+String:C10($l_versionBD_Build;"00000")
Else 
	  //CD_Dlog (0;__ ("La base de datos no pudo ser reconstruida.\rLa aplicación se cerrará ahora. Por favor póngase en contacto con el departamento técnico de Colegium."))
End if 

If (Count parameters:C259=2)
	$y_variable:=$2
	Case of 
		: ($1="principal")  // version principal
			$y_variable->:=$l_versionBD_Principal
		: ($1="revision")  // revision
			$y_variable->:=$l_versionBD_Revision
		: ($1="build")  // build
			$y_variable->:=$l_versionBD_Build
		Else 
			ALERT:C41("Tipo de item de version incorrecto")
	End case 
End if 
$0:=$t_VersionBD