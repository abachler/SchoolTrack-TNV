//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 19-04-18, 09:22:49
  // ----------------------------------------------------
  // Método: SC_ObtieneUrlDocsFunciones
  // Descripción
  //
  // dispositivo = 1 escritorio; 2 web; 3 responsive
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($b_isAdmin)
C_LONGINT:C283($l_versionBD_Build;$l_versionBD_Principal;$l_versionBD_Revision;$l_profID;$l_userID)
C_TEXT:C284($t_dispositivo;$t_idUsuario;$t_pais;$t_url;$t_uuid;$t_uuidc;$t_uuidFunc;$t_versionBaseDeDatos;$t_versionMayor;$t_versionMenor)
C_TEXT:C284($uuid;$t_uuidu)
C_OBJECT:C1216($ob_raiz;$ob_temporal)
ARRAY TEXT:C222($at_UUIDfunciones;0)
ARRAY TEXT:C222($at_NombreFunciones;0)

$t_dispositivo:=$1
If (Count parameters:C259=2)
	$uuid:=$2
End if 

ARRAY TEXT:C222($at_NombreFunciones;0)
ARRAY TEXT:C222($at_UUIDfunciones;0)
C_OBJECT:C1216($o_datosFuncion)

OB SET:C1220($o_datosFuncion;"modulo";SchoolTrack Web Access)
OB SET:C1220($o_datosFuncion;"accion";"obtieneayuda")
$o_datosFuncion:=STC_ObtieneDatos ($o_datosFuncion)

OB GET ARRAY:C1229($o_datosFuncion;"items";$at_NombreFunciones)
OB GET ARRAY:C1229($o_datosFuncion;"uuids";$at_UUIDfunciones)

Case of 
	: ($t_dispositivo="1")
		$t_idUsuario:=String:C10(USR_GetUserID )
		$l_idUsuario:=USR_GetUserID 
		
	: (($t_dispositivo="2") | ($t_dispositivo="3"))
		$l_profID:=STWA2_Session_GetProfID ($uuid)
		$t_idUsuario:=String:C10(STWA2_Session_GetUserSTID ($uuid))
		$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
		$b_isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$l_userID)
		
End case 

If ($l_idUsuario>0)
	QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$l_idUsuario)
	$t_uuidu:=[xShell_Users:47]Auto_UUID:24
End if 

$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)

$t_pais:=<>gCountryCode
$t_versionMayor:=String:C10($l_versionBD_Principal)
$t_versionMenor:=String:C10($l_versionBD_Revision)
$t_uuidc:=Choose:C955(<>bXS_esServidorOficial;<>guuid;Generate UUID:C1066)

For ($i;1;Size of array:C274($at_UUIDfunciones))
	$t_uuid:=$at_UUIDfunciones{$i}
	$t_url:="http://intranet2.colegium.com/doc?pais="+$t_pais+"&id="+$t_idUsuario+"&uuid="+$t_uuid+"&vma="+$t_versionMayor+"&vme="+$t_versionMenor+"&uuidc="+$t_uuidc+"&dis="+$t_dispositivo+"&uuidu="+$t_uuidu
	OB SET:C1220($ob_temporal;"Nombre";$at_NombreFunciones{$i})
	OB SET:C1220($ob_temporal;"URL";$t_url)
	OB SET:C1220($ob_raiz;$at_UUIDfunciones{$i};$ob_temporal)
	CLEAR VARIABLE:C89($ob_temporal)
End for 

$0:=$ob_raiz
