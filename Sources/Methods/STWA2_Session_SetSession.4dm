//%attributes = {}

C_TEXT:C284($0;$uuid;$cookie)
C_LONGINT:C283($1;$2;$userID;$profID;$t)
C_BOOLEAN:C305($3;$persistent)
C_REAL:C285($real)
C_BOOLEAN:C305($b_usu_rplazo)
C_OBJECT:C1216($ob_preferencias)

$userID:=$1
$profID:=$2
$persistent:=$3
$browserIP:=$4
$cultura:=$5
$clasica:=$6
C_LONGINT:C283($userID_rplazo)
C_LONGINT:C283($profID_rplazo)
  //ASM

$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";$userID)

  // Modificado por: Alexis Bustamante (10-06-2017)
  //TICKET 179869
  //Cambio de plugin a comando nativo.


While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 

If (<>vbSTWA2_UseArrayBasedSessions)
	$uuid:=Generate UUID:C1066  // ABK 20131228: genero un uuid en la variable en caso que se usen arreglos
	APPEND TO ARRAY:C911(<>atSTWA2_Session_UUIDs;$uuid)
	APPEND TO ARRAY:C911(<>alSTWA2_Session_UserID;$userID)
	APPEND TO ARRAY:C911(<>alSTWA2_Session_ProfID;$profID)
	APPEND TO ARRAY:C911(<>alSTWA2_Session_LastSeen;Current time:C178)
	APPEND TO ARRAY:C911(<>atSTWA2_Session_BrowserIP;$browserIP)
Else 
	CREATE RECORD:C68([STWA2_SessionManager:290])
	  //4D autoasigna un uuida a [STWA2_SessionManager]Auto_UUID
	[STWA2_SessionManager:290]User_ID:2:=$userID
	[STWA2_SessionManager:290]Prof_ID:3:=$profID
	[STWA2_SessionManager:290]Persistente:5:=$persistent
	[STWA2_SessionManager:290]Activa:7:=True:C214
	[STWA2_SessionManager:290]IP_Browser:6:=$browserIP
	$time:=Current time:C178
	[STWA2_SessionManager:290]Last_Seen:4:=$time*1
	SAVE RECORD:C53([STWA2_SessionManager:290])
	$uuid:=[STWA2_SessionManager:290]Auto_UUID:1  //ABK 20131228:  para recuperar en la variable $uuid el valor asignado automaticamente por 4D
End if 
CLEAR SEMAPHORE:C144("$sessionManagerAccess")
Log_RegisterEvtSTW ("Inicio de sesi—n desde: "+$browserIP;$userID)

C_OBJECT:C1216($ob_cookie)
$ob_cookie:=OB_Create 

  //$cookieT:=JSON New 
$extraData:=""
$extraAttr:=""
If ($persistent)
	$extraData:="&expira="+String:C10(Add to date:C393(Current date:C33;1;0;0);Date RFC 1123:K1:11;Current time:C178)
	$fechaexp:=String:C10(Add to date:C393(Current date:C33;1;0;0);Date RFC 1123:K1:11;Current time:C178)
	C_BLOB:C604($blob)
	CONVERT FROM TEXT:C1011($fechaexp;"ISO-8859-1";$blob)
	BASE64 ENCODE:C895($blob;$fechaexp)
	OB_SET ($ob_cookie;->$fechaexp;"expira")
	  //$node:=JSON Append text ($cookieT;"expira";$fechaexp)
	$extraAttr:=$extraAttr+"expires="+String:C10(Add to date:C393(Current date:C33;1;0;0);Date RFC 1123:K1:11;Current time:C178)
End if 
If ($userID<0)
	$extraData:=$extraData+"&su=si"
	  //$node:=JSON Append text ($cookieT;"su";"si")
	$vt_si:="si"
	OB_SET ($ob_cookie;->$vt_si;"su")
Else 
	  //$extraData:=$extraData+"&su=no"
	  //$node:=JSON Append text ($cookieT;"su";"no")
	$vt_si:="no"
	$extraData:=$extraData+"&su=no"
	  //$node:=JSON Append text ($cookieT;"su";"no")
	OB_SET ($ob_cookie;->$vt_si;"su")
End if 

$extraData:=$extraData+"&st="+String:C10($l_Timeout)+"&sew="+String:C10(<>vlSTWA2_SessionExpiracyWarning)
  //$node:=JSON Append text ($cookieT;"st";String(<>vlSTWA2_Timeout))
  //$node:=JSON Append text ($cookieT;"sew";String(<>vlSTWA2_SessionExpiracyWarning))
$vt_STwa2_timeout:=String:C10($l_Timeout)
$vt_STwa2_SessionExpiracyWarning:=String:C10(<>vlSTWA2_SessionExpiracyWarning)
OB_SET ($ob_cookie;->$vt_STwa2_timeout;"st")
OB_SET ($ob_cookie;->$vt_STwa2_SessionExpiracyWarning;"sew")

$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
If (($userID<0) | ($isAdmin))
	$usuario:=USR_GetUserName ($userID)
	  //JSON Append text ($cookieT;"pj";"si")
	$vt_si:="si"
	OB_SET ($ob_cookie;->$vt_si;"pj")
	
	READ ONLY:C145([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	ARRAY TEXT:C222($cursos;0)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
	
	  //JSON Append text array ($cookieT;"cursos";$cursos)
	OB_SET ($ob_cookie;->$cursos;"cursos")
	
Else 
	$el:=Find in array:C230(<>alUSR_UserIds;$userID)
	If ($el>0)
		READ ONLY:C145([Profesores:4])
		$profRN:=Find in field:C653([Profesores:4]Numero:1;$profID)
		If (KRL_GotoRecord (->[Profesores:4];$profRN;False:C215))
			$usuario:=[Profesores:4]Apellidos_y_nombres:28
			READ ONLY:C145([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=[Profesores:4]Numero:1)
			ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
			If (Records in selection:C76([Cursos:3])>0)
				$vt_si:="si"
				  //JSON Append text ($cookieT;"pj";"si")
			Else 
				$vt_si:="no"
				  //JSON Append text ($cookieT;"pj";"no")
			End if 
			OB_SET ($ob_cookie;->$vt_si;"pj")
			ARRAY TEXT:C222($cursos;0)
			
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
			  //JSON Append text array ($cookieT;"cursos";$cursos)
			OB_SET ($ob_cookie;->$cursos;"cursos")
		Else 
			$usuario:=KRL_GetTextFieldData (->[xShell_Users:47]No:1;->$userID;->[xShell_Users:47]Name:2)
		End if 
	Else 
		$usuario:="usuario desconocido"
	End if 
End if 
C_BLOB:C604($blob)
CONVERT FROM TEXT:C1011($usuario;"ISO-8859-1";$blob)
BASE64 ENCODE:C895($blob;$usuario)
$extraData:=$extraData+"&usuario="+$usuario+"&cultura="+$cultura+"&clasica="+$clasica

$cookie:="Set-Cookie: stwa2=UUID="+$uuid+$extraData+ST_Boolean2Str (($extraAttr#"");";";"")+$extraAttr
$version:="v"+SYS_LeeVersionEstructura 
$cookie:=$cookie+"&version="+$version
  //$node:=JSON Append text ($cookieT;"UUID";$uuid)
  //$node:=JSON Append text ($cookieT;"usuario";cURL Escape url ($usuario))
  //$node:=JSON Append text ($cookieT;"cultura";$cultura)
  //$node:=JSON Append text ($cookieT;"version";$version)
  //$node:=JSON Append text ($cookieT;"clasica";$clasica)
$vt_usuario:=cURL Escape url ($usuario)

OB_SET ($ob_cookie;->$uuid;"UUID")
OB_SET ($ob_cookie;->$vt_usuario;"usuario")
OB_SET ($ob_cookie;->$cultura;"cultura")
OB_SET ($ob_cookie;->$version;"version")
OB_SET ($ob_cookie;->$clasica;"clasica")



C_LONGINT:C283($llaveLONG)
$llenMat:=LICENCIA_esModuloAutorizado (1;14)
$llenLC:=LICENCIA_esModuloAutorizado (1;15)
If (($llenMat) | ($llenLC))  //testear licencia edunet
	If ($llenMat)
		$llaveLONG:=$llaveLONG ?+ 0
	End if 
	If ($llenLC)
		$llaveLONG:=$llaveLONG ?+ 1
	End if 
	$llave:=String:C10($llaveLONG)
Else 
	$llave:="-1"
End if 
$cookie:=$cookie+"&llen="+$llave
$node:=JSON Append text ($cookieT;"llen";$llave)
If (LICENCIA_esModuloAutorizado (1;13))  //testear licencia GAFE
	$puente:="0"
Else 
	$puente:="-1"
End if 
$cookie:=$cookie+"&llgafe="+$puente

  //$node:=JSON Append text ($cookieT;"llgafe";$puente)
OB_SET ($ob_cookie;->$puente;"llgafe")
$dash:="-1"
If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;$userID)))
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	For ($i;1;Size of array:C274(alUSR_Membership))
		$groupID:=alUSR_Membership{$i}
		USR_GetGroupAppSpecificData ($groupID;"dashboards";->$real)
		If ($real=1)
			$i:=Size of array:C274(alUSR_Membership)+1
			$dash:="0"
		End if 
	End for 
Else 
	$dash:="0"
End if 
$cookie:=$cookie+"&lldb="+$dash
  //$node:=JSON Append text ($cookieT;"lldb";$dash)
OB_SET ($ob_cookie;->$dash;"lldb")
$cp:=Lowercase:C14(<>vtXS_CountryCode)
$rol:=<>gRolBD
$cookie:=$cookie+"&rdb="+$rol+"&cp="+$cp
  //$node:=JSON Append text ($cookieT;"rdb";$rol)
  //$node:=JSON Append text ($cookieT;"cp";$cp)
OB_SET ($ob_cookie;->$rol;"rdb")
OB_SET ($ob_cookie;->$cp;"cp")
$priv:=USR_checkRights ("A";->[Alumnos_FichaMedica:13];$userID)
$ve:=ST_Boolean2Text ($priv;"0";"-1")
  //$node:=JSON Append text ($cookieT;"ve";$ve)
OB_SET ($ob_cookie;->$ve;"ve")
  //$priv:=USR_GetModuleAcces ("AccountTrack";$userID)
$priv:=(USR_GetModuleAcces ("AccountTrack";$userID) & (STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_Dash_DeudaActual")))  //ticket 167469
$act:=ST_Boolean2Text ($priv;"0";"-1")
  //$node:=JSON Append text ($cookieT;"act";$act)
OB_SET ($ob_cookie;->$act;"act")
  //leo las preferencias de contraseña
$ob_preferencias:=PREF_fGetObject (0;"PreferenciaContraseñas")
OB_SET ($ob_cookie;->$ob_preferencias;"PrefPass")

$t_json:=OB_Object2Json ($ob_cookie)
  //$cookie2:="Set-Cookie: stwa2="+JSON Export to text ($cookieT;JSON_WITHOUT_WHITE_SPACE)+ST_Boolean2Str (($extraAttr#"");";";"")+$extraAttr
$cookie2:="Set-Cookie: stwa2="+$t_json+ST_Boolean2Str (($extraAttr#"");";";"")+$extraAttr
USR_RegisterUserEvent (UE_ModuleStart;0;"";"SchoolTrack Web Access";$userID)
  //JSON CLOSE ($cookieT)  //20150421 RCH Se agrega cierre
$0:=$cookie2