//%attributes = {}
  //SN3_ParametroLog
C_OBJECT:C1216($ob)
C_TEXT:C284($0;$t_retorno)
C_TEXT:C284($t_servicio;$t_usuarioMaquina;$t_usuarioST;$t_versionST;$t_version4D;$t_dts)
C_LONGINT:C283($l_usuarioST;$l_tipoAPP)

$t_servicio:=$1

$ob:=OB_Create 

$t_nombreMaquina:=Current machine:C483
$t_usuarioMaquina:=Current system user:C484
$l_usuarioST:=<>lUSR_CurrentUserID
$t_usuarioST:=USR_GetUserName (<>lUSR_CurrentUserID)
$t_versionST:=SYS_LeeVersionBaseDeDatos 
$l_tipoAPP:=Application type:C494
$t_version4D:=Application version:C493
$t_dts:=DTS_MakeFromDateTime 

OB_SET ($ob;->$t_servicio;"servicio")
OB_SET ($ob;->$t_nombreMaquina;"maquina")
OB_SET ($ob;->$l_usuarioST;"usuariomaquina")
OB_SET ($ob;->$t_usuarioST;"usuariost")
OB_SET ($ob;->$t_versionST;"versionst")
OB_SET ($ob;->$l_tipoAPP;"tipoapp")
OB_SET ($ob;->$t_version4D;"version4d")
OB_SET ($ob;->$t_dts;"dts")
OB_SET ($ob;-><>bXS_esServidorOficial;"servidoroficial")
$t_retorno:=OB_Object2Json ($ob)

$0:=$t_retorno