//%attributes = {}
  //CMT_Get_CommTrackUsers

C_TEXT:C284($1)

AL_UpdateArrays (xALP_CMTUsers;0)
ARRAY TEXT:C222(at_CMT_UserType;0)
ARRAY TEXT:C222(at_CMT_UserName;0)
ARRAY TEXT:C222(at_CMT_Login;0)
ARRAY TEXT:C222(at_CMT_Password;0)
ARRAY BOOLEAN:C223(ab_CMT_UserInactivo;0)

$vt_codPais:=<>gCountryCode
$vt_RBD:=<>gRolBD
$vt_dato:=$1

WEB SERVICE SET PARAMETER:C777("cod_pais";$vt_codPais)
WEB SERVICE SET PARAMETER:C777("rolbd";$vt_RBD)
WEB SERVICE SET PARAMETER:C777("data_buscar";$vt_dato)

$err:=WS_CallCommTrackWebService ("send_users_schooltrack")
If ($err="")
	ARRAY TEXT:C222($at_result;0)
	WEB SERVICE GET RESULT:C779($at_result;"return";*)
	If (Size of array:C274($at_result)>0)
		For ($i;1;Size of array:C274($at_result))
			APPEND TO ARRAY:C911(at_CMT_UserType;ST_GetWord ($at_result{$i};1;"|"))
			APPEND TO ARRAY:C911(at_CMT_UserName;ST_GetWord ($at_result{$i};2;"|"))
			APPEND TO ARRAY:C911(at_CMT_Login;ST_GetWord ($at_result{$i};3;"|"))
			APPEND TO ARRAY:C911(at_CMT_Password;ST_GetWord ($at_result{$i};4;"|"))
			If (Num:C11(ST_GetWord ($at_result{$i};5;"|"))=1)
				APPEND TO ARRAY:C911(ab_CMT_UserInactivo;False:C215)
			Else 
				APPEND TO ARRAY:C911(ab_CMT_UserInactivo;True:C214)
			End if 
		End for 
		SORT ARRAY:C229(at_CMT_UserType;at_CMT_UserName;ab_CMT_UserInactivo;at_CMT_Login;at_CMT_Password;>)
	Else 
		CD_Dlog (0;__ ("No hay usuarios que correspondan a la expresión ingresada."))
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con CommTrack."))
End if 
AL_UpdateArrays (xALP_CMTUsers;-2)
vbCMT_LoadedSNLog:=True:C214