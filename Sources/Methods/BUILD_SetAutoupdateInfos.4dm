//%attributes = {}
  // BUILD_setTimeStamp()
  //
  //
  // creado por: Alberto Bachler Klein: 02-08-16, 16:37:58
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_mono32;$b_mono64;$b_server32;$b_server64)
C_POINTER:C301($y_objetoJsonInfo;$y_versionGeneracionBuild;$y_versionGeneracionCompleta;$y_versionGeneracionDTS;$y_versionGeneracionMayor;$y_versionGeneracionMenor)
C_TEXT:C284($t_dts;$t_plataforma;$t_rutaAppInfoJson;$t_version)
C_OBJECT:C1216($ob_OS)

$y_objetoJsonInfo:=OBJECT Get pointer:C1124(Object named:K67:5;"jsonInfo")
$y_versionGeneracionCompleta:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Completa")
$y_versionGeneracionMayor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Mayor")
$y_versionGeneracionMenor:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Menor")
$y_versionGeneracionBuild:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_Build")
$y_versionGeneracionDTS:=OBJECT Get pointer:C1124(Object named:K67:5;"versionGeneracion_DTS")

$t_plataforma:=Choose:C955(Folder separator:K24:12=":";"macOS";"Windows")

$b_mono32:=(Test path name:C476(BUILD_GetPaths ("monoApp"))>=Is a folder:K24:2)
$b_mono64:=(Test path name:C476(BUILD_GetPaths ("monoApp64"))>=Is a folder:K24:2)
$b_server32:=(Test path name:C476(BUILD_GetPaths ("serverApp"))>=Is a folder:K24:2)
$b_server64:=(Test path name:C476(BUILD_GetPaths ("serverApp64"))>=Is a folder:K24:2)

$t_rutaAppInfoJson:=BUILD_GetPaths ("AppInfoJson")
OB_GET ($y_objetoJsonInfo->;->$ob_OS;$t_plataforma)

$t_version:=Choose:C955($b_mono32;$y_versionGeneracionCompleta->;"")
$t_dts:=Choose:C955($b_mono32;$y_versionGeneracionDTS->;"")
OB_SET ($y_objetoJsonInfo->;->$t_version;$t_plataforma+"."+"Mono32_version")
OB_SET ($y_objetoJsonInfo->;->$t_dts;$t_plataforma+"."+"Mono32_dts")

$t_version:=Choose:C955($b_mono64;$y_versionGeneracionCompleta->;"")
$t_dts:=Choose:C955($b_mono64;$y_versionGeneracionDTS->;"")
OB_SET ($y_objetoJsonInfo->;->$t_version;$t_plataforma+"."+"Mono64_version")
OB_SET ($y_objetoJsonInfo->;->$t_dts;$t_plataforma+"."+"Mono64_dts")

$t_version:=Choose:C955($b_Server32;$y_versionGeneracionCompleta->;"")
$t_dts:=Choose:C955($b_Server32;$y_versionGeneracionDTS->;"")
OB_SET ($y_objetoJsonInfo->;->$t_version;$t_plataforma+"."+"Server32_version")
OB_SET ($y_objetoJsonInfo->;->$t_dts;$t_plataforma+"."+"Server32_dts")

$t_version:=Choose:C955($b_Server64;$y_versionGeneracionCompleta->;"")
$t_dts:=Choose:C955($b_Server64;$y_versionGeneracionDTS->;"")
OB_SET ($y_objetoJsonInfo->;->$t_version;$t_plataforma+"."+"Server64_version")
OB_SET ($y_objetoJsonInfo->;->$t_dts;$t_plataforma+"."+"Server64_dts")

OB_ObjectToJsonDocument ($y_objetoJsonInfo->;$t_rutaAppInfoJson;True:C214)


