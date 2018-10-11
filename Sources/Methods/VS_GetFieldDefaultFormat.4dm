//%attributes = {}
  //VS_GetFieldDefaultFormat

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 30/07/03, 12:00:24
  // -------------------------------------------------------------------------------
  // Metodo: VS_GetDefaultFieldFormat
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283($tableRef;$fieldRef;$1;$2;$length)
C_TEXT:C284($format;$0)
C_BOOLEAN:C305($indexed;$unique;$invisible)
  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$tableRef:=$1
$fieldRef:=$2

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
GET FIELD PROPERTIES:C258($tableRef;$fieldRef;$type;$length;$indexed;$unique;$invisible)
Case of 
	: (($type=Is text:K8:3) | ($type=Is alpha field:K8:1))
		$format:=""
	: ($type=Is longint:K8:6)
		$format:="### ### ### ##0"
	: ($type=Is integer:K8:5)
		$format:="### ##0"
	: ($type=Is real:K8:4)
		$format:="### ### ### ##0,00"
	: ($type=Is date:K8:7)
		$format:="00/00/0000"
	: ($type=Is time:K8:8)
		$format:="00:00"
End case 

$0:=$format

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------
