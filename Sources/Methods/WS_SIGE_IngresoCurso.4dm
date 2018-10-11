//%attributes = {}
  // WS_SIGE_IngresoCurso
  // addCurso
  // http://dido.mineduc.cl:9080/WsApiMineduc/wsdl/CursoSigeSoapPort.wsdl 
  // 
  // M?todo generado autom‡ticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($0;$1)
_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_POINTER:C301($ptr_msg;$2)
C_TEXT:C284($namespace;$semilla;vt_sige_ing_cur_log;$RBD;$childName)
ARRAY TEXT:C222($at_log_env_curso;0)
$semilla:=$1
$ptr_msg:=$2
$vt_cod_resp:=""
$namespace:="http://dido.mineduc.cl/Archivos/Schemas/"
vt_sige_ing_cur_log:=""

If ([Cursos:3]cl_RolBaseDatos:20="")
	APPEND TO ARRAY:C911($at_log_env_curso;"Rol de bd vacía en la ficha del curso")
End if 
If ([Cursos:3]cl_CodigoTipoEnseñanza:21=0)
	APPEND TO ARRAY:C911($at_log_env_curso;"Curso sin código de tipo de enseñanaza")
End if 
If (([Cursos:3]cl_CodigoNivelEspecial:36="0") | ([Cursos:3]cl_CodigoNivelEspecial:36=""))
	APPEND TO ARRAY:C911($at_log_env_curso;"Curso sin código de grado")
End if 
If ([Cursos:3]Letra_Oficial_del_Curso:18="")
	APPEND TO ARRAY:C911($at_log_env_curso;"Curso sin letra")
End if 

QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)

$numero_de_rut:=String:C10(Num:C11(Substring:C12([Profesores:4]RUT:27;1;Length:C16([Profesores:4]RUT:27)-1)))
$dv:=Substring:C12([Profesores:4]RUT:27;Length:C16([Profesores:4]RUT:27))

If (($numero_de_rut="") | ($dv=""))
	APPEND TO ARRAY:C911($at_log_env_curso;"Run del profesor jefe en blanco")
End if 
If ([Cursos:3]Jornada:32=0)
	APPEND TO ARRAY:C911($at_log_env_curso;"El curso no cuenta con jornada en SchoolTrack")
End if 

If (Size of array:C274($at_log_env_curso)>0)
	$vt_cod_resp:="-9"
	vt_sige_ing_cur_log:=AT_array2text (->$at_log_env_curso;", ")
	$vt_msg:="-9"
Else 
	
	$root:=DOM Create XML Ref:C861("EntradaAddCursoSige";$namespace)
	DOM SET XML DECLARATION:C859($root;"UTF-8")
	
	$ref_1:=DOM_SetElementValueAndAttr ($root;"RecordCursoSige")
	$ref_2:=DOM_SetElementValueAndAttr ($ref_1;"PKCursoSige")
	DOM_SetElementValueAndAttr ($ref_2;"AnioEscolar";String:C10(<>gyear);True:C214)
	
	$RBD:=String:C10(Num:C11(Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)))
	
	DOM_SetElementValueAndAttr ($ref_2;"RBD";$RBD;True:C214)
	DOM_SetElementValueAndAttr ($ref_2;"CodigoTipoEnsenanza";String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21);True:C214)
	DOM_SetElementValueAndAttr ($ref_2;"CodigoGrado";[Cursos:3]cl_CodigoNivelEspecial:36;True:C214)
	DOM_SetElementValueAndAttr ($ref_2;"LetraCurso";[Cursos:3]Letra_Oficial_del_Curso:18;True:C214)
	
	$ref_2:=DOM_SetElementValueAndAttr ($ref_1;"Run")
	DOM_SetElementValueAndAttr ($ref_2;"numero";$numero_de_rut;True:C214)
	DOM_SetElementValueAndAttr ($ref_2;"dv";$dv;True:C214)
	
	DOM_SetElementValueAndAttr ($ref_1;"CursoCombinado";ST_Boolean2Text (False:C215;"true";"false");True:C214)  //que es esto ?
	DOM_SetElementValueAndAttr ($ref_1;"NumeroCursoCombinado";"0";True:C214)  //esto se queda así por ahora
	
	DOM_SetElementValueAndAttr ($ref_1;"CodigoTipoJornada";String:C10([Cursos:3]Jornada:32);True:C214)
	If ([Cursos:3]cl_SectorEconomicoTP:27="")
		[Cursos:3]cl_SectorEconomicoTP:27:="0"
	End if 
	
	If (([Cursos:3]cl_CodigoTipoEnseñanza:21#10) & ([Cursos:3]cl_CodigoTipoEnseñanza:21#110) & ([Cursos:3]cl_CodigoTipoEnseñanza:21#310))  //estos tipos de enseñanza no cuentan con sector economico no codigo de especialidad, si envio estos elementos devuelve un error
		DOM_SetElementValueAndAttr ($ref_1;"CodigoSectorEconomico";String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21);True:C214)
		DOM_SetElementValueAndAttr ($ref_1;"CodigoEspecialidad";String:C10([Cursos:3]cl_CodigoEspecialidadTP:29);True:C214)
		  //DOM_SetElementValueAndAttr ($ref_1;"CodigoAlternativaDesarrolloCurricular";"1";True)  `no se donde se registra esto en ST `Según el schema los valores permitidos para el nodo CodigoAlternativaDesarrolloCurricular son 1 (Tradicional - Solo Establecimiento), 2 (Formación Dual - Establecimiento y Empresa) y 3 (Otra), por lo tanto el valor 0 no es permitido, para los cursos que el nodo en cuestión no aplica no se debe enviar el nodo. 
	End if 
	
	DOM_SetElementValueAndAttr ($root;"Semilla";$semilla;True:C214)
	
	WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
	WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;60)
	
	vtWS_ErrorNum:=""
	vtWS_ErrorString:=""
	$methodCalledOnError:=Method called on error:C704
	ON ERR CALL:C155("WS_ErrorHandler")
	
	WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiMineduc/services/CursoSigeSoapPort";"addCurso";"addCurso";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)
	
	ON ERR CALL:C155($methodCalledOnError)
	
	If (OK=1)
		
		C_BLOB:C604($blob)
		_O_C_STRING:C293(16;$resroot)
		_O_C_STRING:C293(16;$ressubelem)
		C_TEXT:C284($vt_msg)
		
		WEB SERVICE GET RESULT:C779(vtWS_ResultString;"XMLOut")
		WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
		$resroot:=DOM Parse XML variable:C720($blob)
		  //código de respuesta
		  //DOM EXPORT TO FILE($resroot;"") exporta a un archivo el xmnl de respuesta
		$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaAddCursoSige/CodigoRespuestaCurso")
		DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_cod_resp)
		
		If ($vt_cod_resp="2")
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
			
		End if 
		
		DOM CLOSE XML:C722($resroot)
		
	Else 
		$vt_cod_resp:="-10"
		$vt_msg:=vtWS_ErrorString
	End if 
	DOM CLOSE XML:C722($root)
End if 

$ptr_msg->:=$vt_msg
$0:=$vt_cod_resp
