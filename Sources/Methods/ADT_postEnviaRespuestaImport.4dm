//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 15-03-17, 08:43:30
  // ----------------------------------------------------
  // Método: ADT_postEnviaRespuestaImport
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_rutaArchivo;$t_rutaArchivoLog;$t_urlPostulaciones;$t_respuesta)
C_LONGINT:C283($l_contador;$l_conexionOK)
C_TEXT:C284($t_text;$delimiter)
C_LONGINT:C283($l_posInArray)
C_TIME:C306($h_ref)
C_BLOB:C604($x_blob)

ARRAY TEXT:C222($at_httpHeaderNames;0)
ARRAY TEXT:C222($at_httpHeaderValues;0)
ARRAY TEXT:C222($at_header;0)
ARRAY TEXT:C222($at_lineaArchivo;0)
ARRAY TEXT:C222($at_AlumnosRutInscritos;0)
ARRAY TEXT:C222($at_uuids;0)

$t_rutaArchivoLog:="Importación de alumnos[web].log"
$t_uuidProceso:=Generate UUID:C1066


  //If (SYS_IsWindows )
  //USE CHARACTER SET("windows-1252";1)
  //Else 
  //USE CHARACTER SET("MacRoman";1)
  //End if 

C_OBJECT:C1216($ob_detalle)
Case of 
	: (Count parameters:C259=1)
		$t_rutaArchivoImportacion:=$1
	: (Count parameters:C259=2)
		$t_rutaArchivoImportacion:=$1
		$t_uuidProceso:=$2
	: (Count parameters:C259=3)
		$t_rutaArchivoImportacion:=$1
		$t_uuidProceso:=$2
		$t_urlPostulaciones:=$3
	: (Count parameters:C259=4)
		$t_rutaArchivoImportacion:=$1
		$t_uuidProceso:=$2
		$t_urlPostulaciones:=$3
		$t_rutaArchivoLog:=$4
	: (Count parameters:C259=5)
		$t_rutaArchivoImportacion:=$1
		$t_uuidProceso:=$2
		$t_urlPostulaciones:=$3
		$t_rutaArchivoLog:=$4
		$ob_detalle:=$5
End case 


  //Guardo el uuid del colegio
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$t_uuidColegio:=[Colegio:31]UUID:58
UNLOAD RECORD:C212([Colegio:31])

  // leo el archivo generado del log para enviar a postulaciones
C_BLOB:C604($x_blob)
C_OBJECT:C1216($ob_raiz)
C_TEXT:C284($t_Base64Postulaciones)
DOCUMENT TO BLOB:C525($t_rutaArchivoLog;$x_blob)
BASE64 ENCODE:C895($x_blob;$t_Base64Postulaciones)


  //  //agrego al Json los datos de los alumnos importados
  //$h_ref:=Open document($t_rutaArchivoImportacion;Read mode)
  //$delimiter:=ACTabc_DetectDelimiter ($t_rutaArchivoImportacion)
  //If ($h_ref#?00:00:00?)
  //RECEIVE PACKET($h_ref;$t_text;$delimiter)
  //AT_Text2Array (->$at_header;$t_text;"\t")
  //RECEIVE PACKET($h_ref;$t_text;$delimiter)

  //While ($t_text#"")
  //AT_Text2Array (->$at_lineaArchivo;$t_text;"\t")
  //$l_posInArray:=Find in array($at_header;"[alumno]Rut")
  //If ($l_posInArray#-1)
  //QUERY([Alumnos];[Alumnos]RUT=$at_lineaArchivo{$l_posInArray})
  //If (Records in selection([Alumnos])>0)
  //APPEND TO ARRAY($at_AlumnosRutInscritos;[Alumnos]RUT)
  //APPEND TO ARRAY($at_uuids;[Alumnos]Auto_UUID)
  //End if 
  //End if 
  //RECEIVE PACKET($h_ref;$t_text;$delimiter)
  //End while 

  //End if 

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$t_uuidProceso;"uuidProceso")
OB_SET ($ob_raiz;->$t_uuidColegio;"uuidColegio")
OB_SET ($ob_raiz;->$t_Base64Postulaciones;"logProceso")
  //OB_SET ($ob_raiz;->$at_AlumnosRutInscritos;"RutInscritos")
  //enviar uuid alumno
OB_SET ($ob_raiz;->$ob_detalle;"detalle_importacion")  //ABC20180106
  //OB SET($ob_raiz;"detalle_importacion";$ob_detalle)  //20171122 RCH
$t_json:=OB_Object2Json ($ob_raiz)

If (Not:C34(Is compiled mode:C492))
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ob_raiz;*))
End if 

BLOB_Variables2Blob (->$x_blob;0;->$t_urlPostulaciones;->$t_json)
If (Not:C34(ADTwa_EnviaRespuestaImportWeb ($x_blob)))
	BM_CreateRequest ("envio log importacion alumnos web";$t_uuidProceso;$t_uuidProceso;$x_blob)
End if 


  //CLEAR SEMAPHORE("PostulacionesImportacionAlumno")
DELETE DOCUMENT:C159($t_rutaArchivoImportacion)
USE CHARACTER SET:C205(*;1)