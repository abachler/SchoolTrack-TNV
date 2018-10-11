//%attributes = {}
  // MÉTODO: xDOC_Picture_Convert
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/03/11, 10:49:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Convierte la imagen pasada en $1 (puntero) utilizando el el codec pasado en $2
  // El codec debe estar disponible en la máquina en que se ejecuta
  // 
  // PARÁMETROS
  // $1: Puntero sobre imagen
  // $2: Codec
  // xDOC_Picture_Convert(puntero_imagen:Y ;codec:S)
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_POINTER:C301($1;$yPicturePointer)
C_TEXT:C284($2;$codec)
C_REAL:C285($3;$compression)
C_LONGINT:C283($error)
$yPicturePointer:=$1
$codec:=$2

If (Picture size:C356($yPicturePointer->)>0)
	
	  //$compression:=1
	  //If (Count parameters=3)
	  //$compression:=$3
	  //End if 
	  //
	  //If (($compression>1) | ($compression=0))
	  //$compression:=1
	  //End if 
	
	  // CODIGO PRINCIPAL
	If (xDOC_Picture_IsCodecAvailable ($codec))
		CONVERT PICTURE:C1002($yPicturePointer->;$codec)
	Else 
		$error:=-1
	End if 
Else 
	$error:=-2
End if 


