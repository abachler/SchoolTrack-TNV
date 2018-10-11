//%attributes = {}
  // MÉTODO: FTP_CIM_Upload
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/11, 11:14:03
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // FTP_CIM_Upload()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($l_ConnexionID;$1;$l_error)
C_TEXT:C284($t_Client;$t_hostPath;$2;$t_sourcePath;$3;$t_URl;$4;$t_login;$5;$t_Password;$6;$t_SourceMachine;$7)
$l_ConnexionID:=$1
$t_hostPath:=$2
$t_sourcePath:=$3
$t_URl:=$4
$t_login:=$5
$t_Password:=$6
$t_SourceMachine:=$7


If ($t_hostPath="")
	$t_hostPath:="/"
End if 

  // CODIGO PRINCIPAL
Case of 
	: (($t_SourceMachine="Client") | ($t_SourceMachine=""))
		$p:=New process:C317("FTP_CIM_UploadFile";Pila_256K;"FTP client connection";$l_ConnexionID;$t_hostPath;$t_sourcePath;$t_URl;$t_login;$t_Password;$t_SourceMachine;<>RegisteredName)
		
	: ($t_SourceMachine="Server")
		$p:=Execute on server:C373("FTP_CIM_UploadFile";Pila_256K;"FTP client connection";$l_ConnexionID;$t_hostPath;$t_sourcePath;$t_URl;$t_login;$t_Password;$t_SourceMachine;<>RegisteredName)
		
End case 

