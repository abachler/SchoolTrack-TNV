//%attributes = {"executedOnServer":true}
  // SYS_TamañoBD_y_Disco()
  // Por: Alberto Bachler K.: 04-10-14, 16:51:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_POINTER:C301($y_libreEnVolumen;$y_tamañoBD;$y_tamañoVolumen;$y_usadoEnVolumen)
C_TEXT:C284($t_volumen)


If (False:C215)
	C_POINTER:C301(SYS_TamañoBD_y_Disco ;$1)
	C_POINTER:C301(SYS_TamañoBD_y_Disco ;$2)
	C_POINTER:C301(SYS_TamañoBD_y_Disco ;$3)
	C_POINTER:C301(SYS_TamañoBD_y_Disco ;$4)
End if 

$y_tamañoBD:=$1
$y_tamañoVolumen:=$2
$y_usadoEnVolumen:=$3
$y_libreEnVolumen:=$4

$t_volumen:=ST_GetWord (Data file:C490;1;Folder separator:K24:12)+Folder separator:K24:12
VOLUME ATTRIBUTES:C472($t_volumen;$y_tamañoVolumen->;$y_usadoEnVolumen->;$y_libreEnVolumen->)
$y_tamañoVolumen->:=Round:C94($y_tamañoVolumen->/1024/1024;2)
$y_usadoEnVolumen->:=Round:C94($y_usadoEnVolumen->/1024/1024;2)
$y_libreEnVolumen->:=Round:C94($y_libreEnVolumen->/1024/1024;2)

$y_tamañoBD->:=Get document size:C479(Data file:C490)
$y_tamañoBD->:=Round:C94($y_tamañoBD->/1024/1024;2)

