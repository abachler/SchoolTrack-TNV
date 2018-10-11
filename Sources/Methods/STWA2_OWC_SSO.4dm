//%attributes = {}
  //STWA2_OWC_SSO
  //tipoUsuario: 1 para apoderados, 2 para alumnos, 3 para profesores
  //idAplicacion: ID de Cóndor de la aplicación para el cálculo de la llave. Para SchoolTrack es el 8

C_BLOB:C604($y_blob)
C_LONGINT:C283($l_idAplicacion;$l_idUsuario;$l_tipoUsuario)
C_TEXT:C284($t_llave;$t_llavePrivada;$t_textoAblob;$t_uuidColegio;$t_body;$t_resultado)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($o_parametros)

$l_tipoUsuario:=3
$l_idAplicacion:=8

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)

If ($l_idUsuario<0)
	$profID:=$l_idUsuario
End if 

  //consulto uuid de la institución
$t_uuidColegio:=LICENCIA_ObtieneUUIDinstitucion 

  //guardo llave aplicación en preferencia en caso de que enla BD no exista
$t_llavePrivada:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
PREF_Set (0;"CONDOR_llave_aplicacion";$t_llavePrivada)

$t_accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")

If (Count parameters:C259=4)
	$t_accion:=$4
End if 

Case of 
	: ($t_accion="consultaservicioscondor")
		
		$l_tipoUsuario:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tipoUsuario"))
		$l_idAplicacion:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"aplicacion"))
		
		OB SET:C1220($o_parametros;"accion";$t_accion)
		OB SET:C1220($o_parametros;"usuarioID";$l_idUsuario)
		OB SET:C1220($o_parametros;"profesorID";$profID)
		OB SET:C1220($o_parametros;"uuid_colegio";$t_uuidColegio)
		OB SET:C1220($o_parametros;"llavePrivada";$t_llavePrivada)
		OB SET:C1220($o_parametros;"tipoUsuario";$l_tipoUsuario)
		OB SET:C1220($o_parametros;"idAplicacion";$l_idAplicacion)
		
		$0:=STWA2_ConsultaServicioCondor ($o_parametros)
		CLEAR VARIABLE:C89($o_parametros)
		
	: ($t_accion="loginUsuarioSTWA")
		
		$t_URL:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"urlAplicacion")
		$l_tipoUsuario:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tipoUsuario"))
		$l_idAplicacion:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"aplicacion"))
		$l_idColegio:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idColegio"))
		
		OB SET:C1220($o_parametros;"accion";$t_accion)
		OB SET:C1220($o_parametros;"url";$t_URL)
		OB SET:C1220($o_parametros;"tipoUsuario";$l_tipoUsuario)
		OB SET:C1220($o_parametros;"idAplicacion";$l_idAplicacion)
		OB SET:C1220($o_parametros;"idColegio";$l_idColegio)
		OB SET:C1220($o_parametros;"profesorID";$profID)
		
		$0:=STWA2_ConsultaServicioCondor ($o_parametros)
		CLEAR VARIABLE:C89($o_parametros)
End case 


