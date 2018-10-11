//%attributes = {}
  //PICT_Append2Library

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 08/06/03, 18:23:03
  // -------------------------------------------------------------------------------
  // Metodo: u_AppendPictureToLibrary
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283($0;$pictureID)
C_POINTER:C301($1;$pictureVarPointer)
C_TEXT:C284($2;$pictureName)


  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$pictureVarPointer:=$1
$pictureName:=$2
$pictureID:=0

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
PICTURE LIBRARY LIST:C564($alPicRef;$asPicNames)
Repeat 
	$pictureID:=1+Abs:C99(Random:C100)
Until (Find in array:C230($alPicRef;$pictureID)<0)
SET PICTURE TO LIBRARY:C566($pictureVarPointer->;$pictureID;$pictureName)
$0:=$pictureID

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------
