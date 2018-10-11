//%attributes = {"executedOnServer":true}
  // LICENCIA_ObtieneUUIDinstitucion()
  // Por: Alberto Bachler K.: 29-08-14, 13:19:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($t_codigoPais;$t_errorWS;$t_IdInstitucion;$t_mensajeError;$t_rolDB;$t_UUID)
C_BOOLEAN:C305($b_forzarEjecucion)
  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

If (False:C215)
	C_TEXT:C284(LICENCIA_ObtieneUUIDinstitucion ;$0)
End if 

If (Count parameters:C259>=1)
	$b_forzarEjecucion:=$1
End if 

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>gCountryCode:=[Colegio:31]Codigo_Pais:31
<>gRolBD:=[Colegio:31]Rol Base Datos:9
<>gRut:=[Colegio:31]RUT:2
<>gUUID:=[Colegio:31]UUID:58

  //20160706 RCH Se actualiza solo si el UUID es inválido o si se fuerza desde la configuración
If (((Not:C34(CIM_esBaseDeDatosNueva )) & (Application type:C494#4D Remote mode:K5:5) & (Not:C34(Util_isValidUUID (<>gUUID)))) | ($b_forzarEjecucion))
	  //MONO ticket 144984
	$ob_request:=OB_Create 
	OB_SET ($ob_request;-><>GROLBD;"rolbd")
	OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
	OB_SET ($ob_request;-><>gRut;"idnacional")
	
	$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
	$httpStatus_l:=Intranet3_LlamadoWS ("WS_Get_UUID_Institucion";$t_jsonRequest;->$t_json)
	
	If ($httpStatus_l=200)
		
		$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
		If ((OB Is defined:C1231($ob_response;"error")))
			OB_GET ($ob_response;->$b_errorResponse;"error")
		End if 
		
		If (Not:C34($b_errorResponse))
			OB_GET ($ob_response;->$t_UUID;"resultado")
			READ WRITE:C146([Colegio:31])
			LOAD RECORD:C52([Colegio:31])
			[Colegio:31]UUID:58:=$t_UUID
			SAVE RECORD:C53([Colegio:31])
			KRL_FindAndLoadRecordByIndex (->[xShell_ApplicationData:45]ID_Organizacion:17;->[Colegio:31]Rol Base Datos:9;True:C214)
			[xShell_ApplicationData:45]UUID:31:=[Colegio:31]UUID:58
			SAVE RECORD:C53([xShell_ApplicationData:45])
		Else 
			OB_GET ($ob_response;->$t_errormsg;"mensaje")
			LOG_RegisterEvt ("Error al obetener UUID Institucion: "+$t_errormsg)
		End if 
		
	End if 
	
End if 

<>vtXS_UUID:=[Colegio:31]UUID:58
<>gUUID:=[Colegio:31]UUID:58

$0:=[Colegio:31]UUID:58

KRL_UnloadReadOnly (->[Colegio:31])
KRL_UnloadReadOnly (->[xShell_ApplicationData:45])
