//%attributes = {}
  // RIN_DescargaLibreria()
  // Por: Alberto Bachler K.: 15-08-14, 18:06:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_idTermometro;$l_indexActualizacion;$l_recNum;$l_versionBD_Build;$l_versionEstructura_Principal;$l_versionEstructura_Revision;$i_registros)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_errorWS;$t_json;$t_mensajeAvance;$t_refJson;$t_uuidColegio;$t_uuidInforme;$t_version;$t_versionBaseDeDatos)
C_TEXT:C284($t_versionEstructura)

ARRAY LONGINT:C221($al_Build;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_DtsModificacion;0)
ARRAY TEXT:C222($at_uuids;0)
ARRAY TEXT:C222($at_uuidVersionInforme;0)
ARRAY TEXT:C222($at_VersionDesde;0)



If (False:C215)
	C_TEXT:C284(RIN_DescargaLibreria ;$1)
	C_TEXT:C284(RIN_DescargaLibreria ;$2)
	C_TEXT:C284(RIN_DescargaLibreria ;$3)
End if 

$t_codigoPais:=""
$t_codigoLenguaje:=""
$t_uuidColegio:=""

Case of 
	: (Count parameters:C259=3)
		$t_codigoPais:=$1
		$t_codigoLenguaje:=$2
		$t_uuidColegio:=$3
End case 

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")


WEB SERVICE SET PARAMETER:C777("codigoPais";$t_codigoPais)
WEB SERVICE SET PARAMETER:C777("codigoLenguaje";$t_codigoLenguaje)
WEB SERVICE SET PARAMETER:C777("uuidColegio";$t_uuidColegio)
WEB SERVICE SET PARAMETER:C777("versionAplicacion";$t_version)
$t_errorWS:=WS_CallIntranetWebService ("RINws_uuidInformes";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)
	
	C_OBJECT:C1216($ob)
	
	$ob:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob;->$at_uuids;"uuids")
	OB_GET ($ob;->$at_VersionDesde;"versionDesde")
	OB_GET ($ob;->$al_Build;"build")
	OB_GET ($ob;->$at_DtsModificacion;"dtsModificacion")
	OB_GET ($ob;->$at_uuidVersionInforme;"uuidVersion")
	
	
	$t_mensajeAvance:=__ ("Descargando librería de informes desde el repositorio...")
	$l_idTermometro:=IT_Progress (1;0;0;$t_mensajeAvance)
	For ($i_registros;1;Size of array:C274($at_uuids))
		$t_uuidInforme:=$at_uuids{$i_registros}
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_Reports:54]UUID:47;->$t_uuidInforme;True:C214)
		If ($l_recNum=No current record:K29:2)
			CREATE RECORD:C68([xShell_Reports:54])
			RIN_DescargaActualizacion ($at_uuidVersionInforme{$i_registros};False:C215)
		Else 
			If (([xShell_Reports:54]DTS_Repositorio:45<$at_DtsModificacion{$i_registros}) | ([xShell_Reports:54]version_minimo:23<$at_VersionDesde{$i_registros}) | (($al_Build{$i_registros}<=$l_versionBD_Build) & ($al_Build{$i_registros}>0)))
				RIN_DescargaActualizacion ($at_uuidVersionInforme{$i_registros};False:C215)
			End if 
		End if 
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($at_uuids);$t_mensajeAvance+"\r"+[xShell_Reports:54]ReportName:26)
	End for 
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($at_uuids))
End if 
KRL_UnloadReadOnly (->[xShell_Reports:54])




