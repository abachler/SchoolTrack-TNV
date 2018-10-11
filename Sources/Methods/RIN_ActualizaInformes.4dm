//%attributes = {}
  // UD_v20140815_ActualizaInformes()
  // Por: Alberto Bachler K.: 15-08-14, 09:18:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$i_registros;$l_idTermometro;$l_indexActualizacion;$l_versionBD_Build;$l_versionEstructura_Principal;$l_versionEstructura_Revision;$l_versionPrincipal;$l_versionRevision)
C_TEXT:C284($t_codigoIdioma;$t_codigoPais;$t_errorWS;$t_json;$t_mensajeAvance;$t_refJson;$t_uuidColegio;$t_version;$t_versionBaseDeDatos;$t_versionConFormato)
C_TEXT:C284($t_versionEstructura)
C_OBJECT:C1216($o_retorno)

ARRAY LONGINT:C221($al_Build;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_dtsLocal;0)
ARRAY TEXT:C222($at_DtsModificacion;0)
ARRAY TEXT:C222($at_Revision;0)
ARRAY TEXT:C222($at_timeStamp_repositorio;0)
ARRAY TEXT:C222($at_uuids;0)
ARRAY TEXT:C222($at_uuidsEnBD;0)
ARRAY TEXT:C222($at_uuidVersionInforme;0)
ARRAY TEXT:C222($at_VersionDesde;0)
ARRAY TEXT:C222($at_versionMinimaLocal;0)

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionBD_Build)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")


$t_codigoPais:=""
$t_codigoIdioma:=""
$t_uuidColegio:=""
WEB SERVICE SET PARAMETER:C777("codigoPais";$t_codigoPais)
WEB SERVICE SET PARAMETER:C777("codigoLenguaje";$t_codigoIdioma)
WEB SERVICE SET PARAMETER:C777("uuidColegio";$t_uuidColegio)
WEB SERVICE SET PARAMETER:C777("versionAplicacion";$t_version)
$t_errorWS:=WS_CallIntranetWebService ("RINws_uuidInformes";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)
	$o_retorno:=JSON Parse:C1218($t_json)
	OB_GET ($o_retorno;->$at_uuids;"uuids")
	OB_GET ($o_retorno;->$at_VersionDesde;"versionDesde")
	OB_GET ($o_retorno;->$al_Build;"build")
	OB_GET ($o_retorno;->$at_DtsModificacion;"dtsModificacion")
	OB_GET ($o_retorno;->$at_timeStamp_repositorio;"timestamp")
	OB_GET ($o_retorno;->$at_uuidVersionInforme;"uuidVersion")
	
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=True:C214)
	SELECTION TO ARRAY:C260([xShell_Reports:54];$al_recNums;[xShell_Reports:54]UUID:47;$at_uuidsEnBD;[xShell_Reports:54]timestampISO_modificacion:35;$at_timeStamp_Local;[xShell_Reports:54]version_minimo:23;$at_versionMinimaLocal)
	$t_mensajeAvance:=__ ("Actualizando informes desde el repositorio...")
	$l_idTermometro:=IT_Progress (1;0;0;$t_mensajeAvance)
	For ($i_registros;1;Size of array:C274($al_recNums))
		$l_indexActualizacion:=Find in array:C230($at_uuids;$at_uuidsEnBD{$i_registros})
		
		If ($l_indexActualizacion>0)
			If (($at_timeStamp_Local{$i_registros}<$at_timeStamp_repositorio{$l_indexActualizacion}) | ($at_versionMinimaLocal{$i_registros}<$at_VersionDesde{$l_indexActualizacion}) | (($al_Build{$l_indexActualizacion}<=$l_versionBD_Build) & ($al_Build{$l_indexActualizacion}>0)))
				KRL_GotoRecord (->[xShell_Reports:54];$al_recNums{$i_registros};True:C214)
				RIN_DescargaActualizacion ($at_uuidVersionInforme{$l_indexActualizacion};False:C215)
			End if 
		Else 
			
		End if 
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums);$t_mensajeAvance+"\r"+[xShell_Reports:54]ReportName:26)
	End for 
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End if 
KRL_UnloadReadOnly (->[xShell_Reports:54])


