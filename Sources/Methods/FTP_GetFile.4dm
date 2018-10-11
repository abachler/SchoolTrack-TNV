//%attributes = {}
  // FTP_GetFile()
  // Por: Alberto Bachler K.: 27-02-14, 09:41:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_errorFTP)
C_TEXT:C284($t_rutaArchivo;$t_rutaDirectorio;$t_rutaLocalArchivo)

If (False:C215)
	C_TEXT:C284(FTP_GetFile ;$1)
End if 

$t_rutaDirectorio:=FTP_GetPath ($1)
$t_rutaArchivo:=$1
If (Count parameters:C259=2)
	$t_rutaLocalArchivo:=$2
End if 

$l_errorFTP:=FTP_Progress (100;100;"Obteniendo "+$t_rutaDirectorio;"*";"*")
If (($l_errorFTP=0) | ($l_errorFTP=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
	$l_errorFTP:=FTP_Receive (vlFTP_ConectionID;$t_rutaArchivo;$t_rutaLocalArchivo;1)
	If ($l_errorFTP#10000)  // cancelado por el usuario
		If ($l_errorFTP#0)
			CD_Dlog (0;IT_ErrorText ($l_errorFTP))
		End if 
	End if 
Else 
	CD_Dlog (0;IT_ErrorText ($l_errorFTP))
End if 

