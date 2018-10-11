//%attributes = {"executedOnServer":true}
  // FTP_UploadFromServer()
  // Por: Alberto Bachler K.: 04-11-14, 09:00:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)

C_TEXT:C284($t_clienteRegistrado;$t_login;$t_Password;$t_rutaArchivo;$t_rutaDestino;$t_SourceMachine;$t_URl)


If (False:C215)
	C_TEXT:C284(FTP_UploadFromServer ;$1)
	C_TEXT:C284(FTP_UploadFromServer ;$2)
	C_TEXT:C284(FTP_UploadFromServer ;$3)
	C_TEXT:C284(FTP_UploadFromServer ;$4)
	C_TEXT:C284(FTP_UploadFromServer ;$5)
	C_TEXT:C284(FTP_UploadFromServer ;$6)
End if 

$t_rutaDestino:=$1
$t_rutaArchivo:=$2
$t_login:=$3
$t_Password:=$4
$t_SourceMachine:=$5
$t_clienteRegistrado:=$6
FTP_Upload (0;$t_rutaDestino;$t_rutaArchivo;$t_URl;$t_login;$t_Password;$t_SourceMachine;<>RegisteredName)

