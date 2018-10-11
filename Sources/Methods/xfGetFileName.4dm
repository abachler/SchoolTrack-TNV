//%attributes = {}
  //xfGetFileName

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 22/08/03, 09:40:39
  // -------------------------------------------------------------------------------
  // Metodo: xfGetFileName
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================

  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($0)  //ruta del archivo seleccionado
C_TEXT:C284($1)
_O_C_STRING:C293(4;$2;$fileType)  //codigo creador

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
If (Count parameters:C259=0)
	$Message:=__ ("Seleccione el archivo")
Else 
	$Message:=$1
End if 

Case of 
	: (Count parameters:C259=2)
		$fileType:=$2
		$message:=$1
	: (Count parameters:C259=1)
		$fileType:=""
		$message:=$1
	Else 
		$Message:=__ ("Seleccione el archivo")
		$fileType:=""
End case 


  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
$ref:=Open document:C264("";$fileType)
$0:=document
CLOSE DOCUMENT:C267($ref)

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------



  //


