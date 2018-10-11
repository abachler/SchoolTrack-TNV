//%attributes = {}
  // WS_SIGE_IngresoAsistencia
  // addAsistencia
  // http://dido.mineduc.cl:9080/WsApiMineduc/wsdl/AsistenciaSigeSoapPort.wsdl 
  // 
  // M?todo generado autom‡ticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos_Inasistencias:10])

C_TEXT:C284($2;$3;$4;$5;$6;$vt_cod_envio;$childName)
C_LONGINT:C283($1;$vl_cod_resp;$no_nivel)
C_POINTER:C301($7;$8;$ptr_msg;$ptr_msg_error)

$no_nivel:=$1
$rol_bd:=String:C10(Num:C11(Substring:C12($2;1;Length:C16($2)-1)))
$tipo_enseñanza:=$3
$codigo_grado:=$4
$fecha:=Date:C102($5)
$semilla:=$6
$ptr_msg:=$7
$ptr_msg_error:=$8

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($namespace)
C_LONGINT:C283($modo_de_asistencia)

$namespace:="http://dido.mineduc.cl/Archivos/Schemas/"
$root:=DOM Create XML Ref:C861("EntradaAddAsistenciaSige";$namespace)

DOM SET XML DECLARATION:C859($root;"UTF-8")

$ref_1:=DOM_SetElementValueAndAttr ($root;"RecordAsistenciaSige")
DOM_SetElementValueAndAttr ($ref_1;"AnioEscolar";String:C10(<>gyear);True:C214)
DOM_SetElementValueAndAttr ($ref_1;"RBD";$rol_bd;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"CodigoTipoEnsenanza";$tipo_enseñanza;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"CodigoGrado";$codigo_grado;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"FechaAsistencia";String:C10(Year of:C25($fecha))+"-"+String:C10(Month of:C24($fecha);"00")+"-"+String:C10(Day of:C23($fecha);"00");True:C214)

$ref_2:=DOM_SetElementValueAndAttr ($ref_1;"Cursos")

ARRAY LONGINT:C221($al_alumnos_id;0)
ARRAY TEXT:C222($at_Cursos;0)
ARRAY TEXT:C222($at_Letra;0)
ARRAY TEXT:C222($at_alumnos_excluidos;0)

QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$no_nivel;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]cl_CodigoTipoEnseñanza:21=Num:C11($tipo_enseñanza);*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]cl_CodigoNivelEspecial:36=$codigo_grado;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
ORDER BY:C49([Cursos:3];[Cursos:3]Letra_del_curso:9;>)

$modo_de_asistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$no_nivel;->[xxSTR_Niveles:6]AttendanceMode:3)

SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_Cursos;[Cursos:3]Letra_del_curso:9;$at_Letra)

For ($i;1;Size of array:C274($at_Cursos))
	
	$ref_3:=DOM_SetElementValueAndAttr ($ref_2;"Curso")
	DOM_SetElementValueAndAttr ($ref_3;"LetraCurso";$at_Letra{$i};True:C214)
	
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$at_Cursos{$i})
	CREATE SET:C116([Alumnos:2];"alu_cur")
	Case of 
		: ($modo_de_asistencia=1)  //diario
			KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$fecha)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;"")
		: ($modo_de_asistencia=2)  //hora detallada
			KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=$fecha;*)
			QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8=2)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;"")
	End case 
	
	CREATE SET:C116([Alumnos:2];"ausentes")
	DIFFERENCE:C122("alu_cur";"ausentes";"presentes")
	
	$ref_4:=DOM_SetElementValueAndAttr ($ref_3;"Presentes")
	
	USE SET:C118("presentes")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_alumnos_id)
	
	For ($x;1;Size of array:C274($al_alumnos_id))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos_id{$x})
		If (CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)#"")
			
			$numero_de_rut:=String:C10(Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)))
			$dv:=Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5))
			
			$ref_5:=DOM_SetElementValueAndAttr ($ref_4;"Run")
			DOM_SetElementValueAndAttr ($ref_5;"numero";$numero_de_rut;True:C214)
			DOM_SetElementValueAndAttr ($ref_5;"dv";$dv;True:C214)
			
		Else 
			APPEND TO ARRAY:C911($at_alumnos_excluidos;[Alumnos:2]apellidos_y_nombres:40+" "+[Alumnos:2]curso:20)
		End if 
		
	End for 
	
	USE SET:C118("ausentes")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_alumnos_id)
	
	$ref_4:=DOM_SetElementValueAndAttr ($ref_3;"Ausentes")
	
	For ($x;1;Size of array:C274($al_alumnos_id))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_alumnos_id{$x})
		If (CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)#"")
			$numero_de_rut:=String:C10(Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)))
			$dv:=Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5))
			
			$ref_5:=DOM_SetElementValueAndAttr ($ref_4;"Run")
			DOM_SetElementValueAndAttr ($ref_5;"numero";$numero_de_rut;True:C214)
			DOM_SetElementValueAndAttr ($ref_5;"dv";$dv;True:C214)
		Else 
			APPEND TO ARRAY:C911($at_alumnos_excluidos;[Alumnos:2]apellidos_y_nombres:40+" "+[Alumnos:2]curso:20)
		End if 
		
	End for 
	
End for 

DOM_SetElementValueAndAttr ($root;"Semilla";$semilla;True:C214)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
DOM EXPORT TO VAR:C863($root;$vt_xml)
CLEAR PASTEBOARD:C402
SET TEXT TO PASTEBOARD:C523($vt_xml)

WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiMineduc/services/AsistenciaSigeSoapPort";"addAsistencia";"addAsistencia";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resroot)
	_O_C_STRING:C293(16;$ressubelem)
	
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaAddAsistenciaSige/CodigoRespuestaAsistencia")
	DOM GET XML ELEMENT VALUE:C731($ressubelem;$vl_cod_resp)
	
	Case of 
		: ($vl_cod_resp=1)
			$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaAddAsistenciaSige/CodigoEnvioAsistencia")
			DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_cod_envio)
			$ptr_msg->:=$vt_cod_envio
			
		: ($vl_cod_resp=2)
			
			$vt_msg:=""
			  //Listado de mensajes de error
			$xml_Parent_Ref:=DOM Get first child XML element:C723($resroot;$childName;$childValue)
			$xml_Parent_Ref2:=DOM Get next sibling XML element:C724($xml_Parent_Ref;$childName;$childValue)
			$xml_Parent_Ref3:=DOM Get first child XML element:C723($xml_Parent_Ref2;$childName;$childValue)
			$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref3;$childName;$childValue)
			$vt_msg:=$vt_msg+"\r"+$childValue
			
			While (OK=1)
				$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref4;$childName;$childValue)
				If (OK=1)
					$vt_msg:=$vt_msg+" "+$childValue
				End if 
			End while 
			$ptr_msg->:=$vt_msg
			
	End case 
	
	DOM EXPORT TO VAR:C863($resroot;$vt_xml)
	CLEAR PASTEBOARD:C402
	SET TEXT TO PASTEBOARD:C523($vt_xml)
	DOM CLOSE XML:C722($resroot)
	
End if 

If (Size of array:C274($at_alumnos_excluidos)>0)
	$ptr_msg_error->:=AT_array2text (->$at_alumnos_excluidos;", ")+", excluidos del envío por no poseer un RUT válido"
End if 

DOM CLOSE XML:C722($root)
$0:=String:C10($vl_cod_resp)
