//%attributes = {}
  // FTP_TestConnection (ftpServer:T ; login:T; password:T; rutaCarpetaFTP:T {;conexionPasiva:L})
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

C_LONGINT:C283($l_conexionPasiva;$l_error;$l_idConexion)
C_TEXT:C284($t_login;$t_nombreArchivo;$t_password;$t_rutaCarpetaFTP;$t_rutaLocal;$t_rutaRemota;$t_servidorFTP;$t_test)


If (False:C215)
	C_TEXT:C284(FTP_TestConnection ;$0)
	C_TEXT:C284(FTP_TestConnection ;$1)
	C_TEXT:C284(FTP_TestConnection ;$2)
	C_TEXT:C284(FTP_TestConnection ;$3)
	C_TEXT:C284(FTP_TestConnection ;$4)
	C_LONGINT:C283(FTP_TestConnection ;$5)
End if 

$t_servidorFTP:=$1
$t_login:=$2
$t_password:=$3
$t_rutaCarpetaFTP:=$4

$l_conexionPasiva:=1
If (Count parameters:C259=5)
	$l_conexionPasiva:=$5
End if 

If ($t_servidorFTP="ftp://")
	$t_servidorFTP:=Replace string:C233($t_servidorFTP;"ftp://";"")
End if 

$t_nombreArchivo:="Test"+<>gRolBD+".txt"
$t_rutaLocal:=Temporary folder:C486+$t_nombreArchivo
$t_test:=<>gRolBD
TEXT TO DOCUMENT:C1237($t_rutaLocal;$t_test)


$t_rutaRemota:=$t_rutaCarpetaFTP+$t_nombreArchivo
$l_error:=FTP_Login ($t_servidorFTP;$t_login;$t_password;$l_idConexion)

If ($l_error=0)
	$l_error:=FTP_SetPassive ($l_idConexion;1)
End if 

If ($l_error=0)
	$l_error:=FTP_Send ($l_idConexion;$t_rutaLocal;$t_rutaRemota)
End if 

If (($l_error#0) & ($l_error#1000))
	$0:=String:C10($l_error)+": "+IT_ErrorText ($l_error)
Else 
	$l_error:=FTP_Delete ($l_idConexion;$t_rutaRemota)
End if 
FTP_Logout ($l_idConexion)




