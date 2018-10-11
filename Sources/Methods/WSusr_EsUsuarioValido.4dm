//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WSusr_EsUsuarioValido

  //****DECLARACIONES****
C_TEXT:C284($1;$2;$t_user;$t_pass;$storedPassword;$t_mensajeError;$t_passLocal)

C_TEXT:C284($t_principal;$node;$t_err;$json;$temporal)

C_LONGINT:C283($logged)
C_BLOB:C604($blob)
C_TEXT:C284($t_nombres;$t_apellidoPat;$t_apellidoMat)
C_LONGINT:C283($l_idST)

  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"user")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"pass")

  //****SOAP OUTPUT****
SOAP DECLARATION:C782($0;Is text:K8:3;SOAP output:K46:2;"resultado")

  //****INICIALIZACIONES****
$t_user:=$1
$t_pass:=$2

  //****CUERPO****
READ ONLY:C145([xShell_Users:47])
READ ONLY:C145([Profesores:4])

QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$t_user)

If (Records in selection:C76([xShell_Users:47])=1)
	$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
	CONVERT FROM TEXT:C1011($storedPassword;"utf-8";$blob)
	$t_passLocal:=SHA512 ($blob;Crypto HEX)
	If (ST_ExactlyEqual ($t_passLocal;$t_pass)=1)
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
		$t_nombres:=[Profesores:4]Nombres:2
		$t_apellidoPat:=[Profesores:4]Apellido_paterno:3
		$t_apellidoMat:=[Profesores:4]Apellido_materno:4
		$l_idST:=[xShell_Users:47]NoEmployee:7
	Else 
		$t_mensajeError:="Usuario y/o Contraseña no válidos."
	End if 
Else 
	$t_mensajeError:="Usuario y/o Contraseña no válidos."
End if 


  // Modificado por: Alexis Bustamante (10-06-2017)
  //TICKET 179869
  //cambio de plugin a comando nativo


C_OBJECT:C1216($ob_raiz;$ob_temp)
C_BOOLEAN:C305($vb_bo)
$ob_raiz:=OB_Create 
$ob_temp:=OB_Create 

$vb_bo:=($t_mensajeError="")

OB_SET ($ob_raiz;->$t_user;"usuario")
OB_SET ($ob_raiz;->$vb_bo;"autorizado")


OB_SET ($ob_temp;->$t_nombres;"nombres")
OB_SET ($ob_temp;->$t_apellidoPat;"appaterno")
OB_SET ($ob_temp;->$t_apellidoMat;"apmaterno")
OB_SET ($ob_temp;->$l_idST;"Id_schooltrack")
OB_SET ($ob_temp;->$vb_bo;"error")
OB_SET ($ob_temp;->$t_mensajeError;"mensaje")
OB_SET ($ob_temp;->$ob_temp;"persona")

  //  //genera respuesta
  //$t_principal:=JSON New 
  //$node:=JSON Append text ($t_principal;"usuario";$t_user)
  //$node:=JSON Append bool ($t_principal;"autorizado";Num($t_mensajeError=""))
  //$temporal:=JSON Append node ($t_principal;"persona")
  //$node:=JSON Append text ($temporal;"nombres";$t_nombres)
  //$node:=JSON Append text ($temporal;"appaterno";$t_apellidoPat)
  //$node:=JSON Append text ($temporal;"apmaterno";$t_apellidoMat)
  //$node:=JSON Append long ($temporal;"Id_schooltrack";$l_idST)
  //$node:=JSON Append bool ($t_principal;"error";Num($t_mensajeError#""))
  //$node:=JSON Append text ($t_principal;"mensaje";$t_mensajeError)
  //  //$json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
  //  //SET TEXT TO PASTEBOARD($json)
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($t_principal)

$0:=$json