//%attributes = {}
  //PICT_Compress

  //`xShell, Alberto Bachler
  //Metodo: PICT_Compress
  //Por abachler
  //Creada el 27/02/2004, 12:54:31
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$pictPointer)
C_TEXT:C284($2;$compressor)
C_LONGINT:C283($3;$quality;error)
C_REAL:C285($calidad)

  //****INICIALIZACIONES****
$pictPointer:=$1
$compressor:=$2
$quality:=$3
$displayMessage:=True:C214
If (Count parameters:C259=4)
	$displayMessage:=$4
End if 

  //****CUERPO****
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")

If (Picture size:C356($pictPointer->)>0)
	  //QT COMPRESS PICTURE($pictPointer->;$compressor;$quality)
	$calidad:=$quality/1000
	CONVERT PICTURE:C1002($pictPointer->;".jpg";$calidad)
	
	  //If ((error=-9955) & ($displayMessage))
	  //  //$msg:="QuickTime no está instalado.\rSchoolTrack comprime las imagenes utilizando QuickTi"+"me\r\rPuede guardar las imágenes no comprimidas, pero el tamaño de su base de datos"+" "+"aumentará considerablemente si tiene muchas imágenes."+"\rLe recmendamos descargar ahora QuickTime (HTTP://www.apple.com/quicktime/downlo"+"a"+"d) e instalarlo en su computador (una vez instalado deberá reiniciar SchoolTrack)"+"."
	  //  //$msg:=$msg+"\rLe recomendamos descargar ahora QuickTime (HTTP://www.apple.com/quicktime/downlo"+"a"+"d) e instalarlo en su computador (una vez instalado deberá reiniciar SchoolTrack)"+"."
	  //$result:=CD_Dlog (0;__ ("QuickTime no está instalado.\rSchoolTrack comprime las imagenes utilizando QuickTime\r\rPuede guardar las imágenes no comprimidas, pero el tamaño de su base de datos aumentará considerablemente si tiene muchas imágenes.\rLe rcomendamos descargar ahor"+"ickTime (HTTP://www.apple.com/quicktime/download) e instalarlo en su computador (una vez instalado deberá reiniciar SchoolTrack).");__ ("");__ ("Descargar");__ ("No comprimir"))
	  //If ($result=1)
	  //OPEN WEB URL("HTTP://www.apple.com/la/quicktime/download")
	  //End if 
	  //End if 
End if 

EM_ErrorManager ("clear")

  //****LIMPIEZA****




