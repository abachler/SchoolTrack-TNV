//%attributes = {}
  // XSstat_UsuariosDocentes_out()
  // Por: Alberto Bachler: 14/05/13, 10:10:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_Docentes;$l_usuarios)
C_TEXT:C284($t_codigoPais;$t_rolBD;$t_uuidInstitucion;vt_ErrorWebService;$t_rolBD;$t_codigoPais;$t_uuidInstitucion)
C_BOOLEAN:C305(<>bXS_esServidorOficial)

  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json;$t_resultado)
C_LONGINT:C283($httpStatus_l)
C_BOOLEAN:C305($b_errorResponse)

Case of 
	: (Count parameters:C259=1)
		$b_forzarParaPruebas:=$1
End case 

If (((Application type:C494=4D Server:K5:6) & (<>bXS_esServidorOficial)) | ($b_forzarParaPruebas))
	
	$t_rolBD:=<>gRolBD
	$t_codigoPais:=<>gCountryCode
	$t_uuidInstitucion:=<>gUUID
	
	
	ALL RECORDS:C47([Asignaturas:18])
	KRL_RelateSelection (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4)
	CREATE SET:C116([Profesores:4];"$profesoresAsignaturas")
	ALL RECORDS:C47([Cursos:3])
	KRL_RelateSelection (->[Profesores:4]Numero:1;->[Cursos:3]Numero_del_profesor_jefe:2)
	CREATE SET:C116([Profesores:4];"$profesoresJefes")
	ALL RECORDS:C47([Actividades:29])
	KRL_RelateSelection (->[Profesores:4]Numero:1;->[Actividades:29]No_Profesor:3)
	CREATE SET:C116([Profesores:4];"$profesoresActividades")
	UNION:C120("$profesoresAsignaturas";"$profesoresJefes";"$docentes")
	UNION:C120("$profesoresActividades";"$docentes";"$docentes")
	$l_docentes:=Records in set:C195("$docentes")
	$l_usuarios:=Records in table:C83([xShell_Users:47])
	
	$ob_request:=OB_Create 
	OB_SET ($ob_request;-><>GROLBD;"rolbd")
	OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
	OB_SET ($ob_request;-><>gUUID;"uuid")
	OB_SET ($ob_request;->$l_usuarios;"usuarios")
	OB_SET ($ob_request;->$l_Docentes;"docentes")
	
	$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
	$httpStatus_l:=Intranet3_LlamadoWS ("WSstat_UsuariosDocentes_in";$t_jsonRequest;->$t_json)
	
	If ($httpStatus_l=200)
		$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
		OB_GET ($ob_response;->$b_errorResponse;"error")
		OB_GET ($ob_response;->vt_ErrorWebService;"mensaje")
		OB_GET ($ob_response;->$t_resultado;"resultado")
	End if 
	
End if 