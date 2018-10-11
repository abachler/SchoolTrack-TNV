//%attributes = {}
  //Metodo: SYS_StoreFile
  //Por abachler
  //Creada el 26/06/2008, 20:21:07
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES

C_BLOB:C604($blob)
C_TEXT:C284($1;$docfilePath;$2;$externalFilePath;$text)
C_BOOLEAN:C305($invisible;$isStream;$openDocument)

$docfilePath:=$1
$externalFilePath:=$2
$invisible:=False:C215
If (Count parameters:C259=3)
	$invisible:=$3
End if 

USE CHARACTER SET:C205("MacRoman";1)

  //$ref:=Open document($docFilePath;"";Read Mode)  //abro el documento que se debe enviar en modo lectura


  //CUERPO
DOCUMENT TO BLOB:C525($docFilePath;$blob)
$isStream:=True:C214  //determino que el envio se hace en un stream
$openDocument:=True:C214  //indico que el primer envio es simplemente la orden de creación del documento
$p:=IT_UThermometer (1;0;__ ("Guardando documento externo ")+__ ("..."))
xDOC_StoreDocument ($externalFilePath;->$blob)
$p:=IT_UThermometer (-2;$p)

USE CHARACTER SET:C205(*;0)



