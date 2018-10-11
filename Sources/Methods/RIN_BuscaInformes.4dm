//%attributes = {}
  // RIN_BuscaInformes()
  // Por: Alberto Bachler K.: 05-08-14, 19:05:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_palabrasCompletas)
C_LONGINT:C283($i;$l_azulRGB;$l_listRef;$l_refModulo;$l_refTipo;$l_rojoRGB;$l_tablaPrincipal;$l_tipoComparacion;$l_verdeRGB;$l_versionEstructura_Principal)
C_LONGINT:C283($l_versionEstructura_Revision)
C_POINTER:C301($y_Idioma;$y_pais)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_dtsLocal;$t_errorWS;$t_expresion;$t_json;$t_modulo;$t_panel;$t_refjSon;$t_texto)
C_TEXT:C284($t_tipoInforme;$t_uuidInforme;$t_version;$t_versionDesde;$t_versionEstructura;$t_versionHasta)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_DTSrepositorio;0)
ARRAY TEXT:C222($at_NombresInformes;0)
ARRAY TEXT:C222($at_timestampRepositorio;0)
ARRAY TEXT:C222($at_uuidActualizacion;0)
ARRAY TEXT:C222($at_uuidInformes;0)

If (False:C215)
	C_TEXT:C284(RIN_BuscaInformes ;$1)
End if 



If (False:C215)
	C_TEXT:C284(RIN_BuscaInformes ;$1)
End if 


$t_expresion:=$1

$t_codigoPais:=<>vtXS_CountryCode
$t_codigoLenguaje:=<>vtXS_langage
GET LIST ITEM:C378(hlRIN_Tipo;*;$l_refTipo;$t_tipoInforme)
Case of 
	: ($l_refTipo=1)
		$t_tipoInforme:="gSR2"
	: ($l_refTipo=2)
		$t_tipoInforme:="4DSE"
	: ($l_refTipo=3)
		$t_tipoInforme:="4DFO"
	: ($l_refTipo=4)
		$t_tipoInforme:="4DET"
	: ($l_refTipo=5)
		$t_tipoInforme:="4DWR"
	: ($l_refTipo=6)
		$t_tipoInforme:="4DVW"
	: ($l_refTipo=7)
		$t_tipoInforme:="4DDW"
	: ($l_refTipo=8)
		$t_tipoInforme:="4DCT"
	Else 
		$t_tipoInforme:=""
End case 

$y_tipoComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoComparacion")
$y_palabrasCompletas:=OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas")
$l_tipoComparacion:=Num:C11($y_tipoComparacion->)
$b_palabrasCompletas:=($y_palabrasCompletas->=1)

GET LIST ITEM:C378(hlRIN_Modulos;*;$l_refModulo;$t_modulo)
If ($l_refModulo=-1)
	$t_modulo:=""
End if 
GET LIST ITEM:C378(hlRIN_Paneles;*;$l_tablaPrincipal;$t_panel)

$y_pais:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoPais")
$y_Idioma:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoIdioma")
$t_codigoPais:=$y_pais->
$t_codigoLenguaje:=$y_Idioma->

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")


WEB SERVICE SET PARAMETER:C777("texto";$t_expresion)
WEB SERVICE SET PARAMETER:C777("version";$t_version)
WEB SERVICE SET PARAMETER:C777("tipoComparacion";$l_tipoComparacion)
WEB SERVICE SET PARAMETER:C777("palabrasCompletas";$b_palabrasCompletas)
WEB SERVICE SET PARAMETER:C777("codigoPais";$t_codigoPais)
WEB SERVICE SET PARAMETER:C777("codigoLenguaje";$t_codigoLenguaje)
WEB SERVICE SET PARAMETER:C777("tipo";$t_tipoInforme)
WEB SERVICE SET PARAMETER:C777("modulo";$t_modulo)
WEB SERVICE SET PARAMETER:C777("tablaPrincipal";$l_tablaPrincipal)

$t_errorWS:=WS_CallIntranetWebService ("RINws_BuscaInformes";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
	
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob;->$al_RecNums;"recnum")
	OB_GET ($ob;->$at_uuidInformes;"uuid")
	OB_GET ($ob;->$at_NombresInformes;"nombre")
	OB_GET ($ob;->$at_DTSrepositorio;"dtsRepositorio")
	OB_GET ($ob;->$at_timestampRepositorio;"timestampISO")
	OB_GET ($ob;->$at_uuidActualizacion;"uuidActualizacion")
	
	HL_ClearList (hlRIN_Informes)
	hlRIN_Informes:=New list:C375
	$l_rojoRGB:=IT_IndexColor2RGB (Red:K11:4)
	$l_azulRGB:=IT_IndexColor2RGB (Dark blue:K11:6)
	$l_verdeRGB:=IT_IndexColor2RGB (Dark green:K11:10)
	
	For ($i;1;Size of array:C274($at_NombresInformes))
		$t_uuidInforme:=$at_uuidInformes{$i}
		APPEND TO LIST:C376(hlRIN_Informes;$at_NombresInformes{$i};$al_RecNums{$i})
		SET LIST ITEM PARAMETER:C986(hlRIN_Informes;0;"uuidInforme";$at_uuidInformes{$i})
		SET LIST ITEM PARAMETER:C986(hlRIN_Informes;0;"uuidActualizacion";$at_uuidActualizacion{$i})
		$t_timestampLocal:=KRL_GetTextFieldData (->[xShell_Reports:54]UUID:47;->$t_uuidInforme;->[xShell_Reports:54]timestampISO_repositorio:37)
		$t_dtsLocal:=KRL_GetTextFieldData (->[xShell_Reports:54]UUID:47;->$t_uuidInforme;->[xShell_Reports:54]DTS_Repositorio:45)
		If (Size of array:C274($at_timestampRepositorio)=Size of array:C274($at_NombresInformes))
			Case of 
				: ($t_timestampLocal="")  // el informe no existe en la librería local
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;1;0;$l_verdeRGB)
				: ($at_timestampRepositorio{$i}>$t_timestampLocal)  // hay una versión más reciente en el repositorio
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;0;0;$l_rojoRGB)
				: ($at_timestampRepositorio{$i}<=$t_timestampLocal)
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;0;0;$l_azulRGB)
			End case 
		Else 
			Case of 
				: ($t_dtsLocal="")  // el informe no existe en la librería local
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;1;0;$l_verdeRGB)
				: ($at_DTSrepositorio{$i}>$t_dtsLocal)  // hay una versión más reciente en el repositorio
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;0;0;$l_rojoRGB)
				: ($at_DTSrepositorio{$i}<=$t_dtsLocal)
					SET LIST ITEM PROPERTIES:C386(HlRIN_Informes;$al_RecNums{$i};False:C215;0;0;$l_azulRGB)
			End case 
		End if 
	End for 
	SORT LIST:C391(hlRIN_Informes)
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
End if 

