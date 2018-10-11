//%attributes = {"executedOnServer":true}
  // FTP_TestConnection_onServer(ftpServer:T ; login:T; password:T; rutaCarpetaFTP:T {;conexionPasiva:L})
  // establece un conexión con ftpServer, con la cuenta login y password, crea un archivo de prueba
  // intenta el envío a rutaCarpetaFTP y lo destruye si la prueba es exitosa
  //
  // creado por: Alberto Bachler Klein: 22/02/17, 09:55:30
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)

C_LONGINT:C283($l_conexionPasiva)
C_TEXT:C284($t_login;$t_password;$t_rutaDocumento;$t_servidorFTP)


If (False:C215)
	C_TEXT:C284(FTP_TestConnection_onServer ;$0)
	C_TEXT:C284(FTP_TestConnection_onServer ;$1)
	C_TEXT:C284(FTP_TestConnection_onServer ;$2)
	C_TEXT:C284(FTP_TestConnection_onServer ;$3)
	C_TEXT:C284(FTP_TestConnection_onServer ;$4)
	C_LONGINT:C283(FTP_TestConnection_onServer ;$5)
End if 

$t_servidorFTP:=$1
$t_login:=$2
$t_password:=$3
$t_rutaDocumento:=$4

$l_conexionPasiva:=<>ftp_UsePassive
If (Count parameters:C259=5)
	$l_conexionPasiva:=$5
End if 

$0:=FTP_TestConnection ($1;$2;$3;$4;$l_conexionPasiva)



