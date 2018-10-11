//%attributes = {"shared":true,"publishedSoap":true}
  // VC4Dws_CheckServerConnection()
  // 
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 15:33:41
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_BLOB:C604($1)

C_BLOB:C604($x_data)
C_BOOLEAN:C305($b_validUser)
C_LONGINT:C283($l_pathType;$l_resultado)
C_POINTER:C301($y_table)
C_TEXT:C284($t_formObjectName;$t_objectName;$t_password;$t_UserName)
C_OBJECT:C1216($ob_Parametros)


If (False:C215)
	C_TEXT:C284(VC4Dws_CheckServerConnection ;$0)
	C_BLOB:C604(VC4Dws_CheckServerConnection ;$1)
End if 

SOAP DECLARATION:C782($1;Is BLOB:K8:12;SOAP input:K46:1;"data")
SOAP DECLARATION:C782($0;Is text:K8:3;SOAP output:K46:2;"isValid")

  //TRACE
$x_data:=$1
BLOB TO VARIABLE:C533($x_data;$ob_Parametros)
$t_UserName:=OB Get:C1224($ob_Parametros;"user")
$t_password:=OB Get:C1224($ob_Parametros;"passw")

METHOD RESOLVE PATH:C1165("VC4D_CheckUser_devHook";$l_pathType;$y_table;$t_objectName;$t_formObjectName;*)
If ($t_objectName="VC4D_CheckUser_devHook")
	$l_resultado:=VC4D_CheckUser_devHook ($t_UserName;$t_password)
	Case of 
		: ($l_resultado=-1)
			$0:=Choose:C955(Validate password:C638($t_UserName;$t_password);"Disponible";"Error login")
		: ($l_resultado=1)
			$0:="Disponible"
	End case 
Else 
	$0:=Choose:C955(Validate password:C638($t_UserName;$t_password);"Disponible";"Error login")
End if 

