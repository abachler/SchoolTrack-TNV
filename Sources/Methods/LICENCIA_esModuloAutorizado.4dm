//%attributes = {}
  // LICENCIA_esModuloAutorizado()
  // Por: Alberto Bachler K.: 29-08-14, 12:27:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$l_modo;$l_idModulo)

Case of 
	: (Count parameters:C259=2)
		$l_modo:=$1
		$l_idModulo:=$2
	: (Count parameters:C259=1)
		$l_idModulo:=$1
End case 
$l_modo:=1

$t_nombreModulo:=""

If (<>LDL_RegisterKey=0)  //llamado aquí para asegurarse que el registro de licencia sea leido cuando se verifica la licencia del módulo antes de procesar la licencia.
	READ ONLY:C145([xShell_ApplicationData:45])
	QUERY:C277([xShell_ApplicationData:45];[xShell_ApplicationData:45]ProductName:16="Main")
	<>vtXS_CountryCode:=[xShell_ApplicationData:45]Código_Pais:26
	<>LDL_RegisterKey:=[xShell_ApplicationData:45]BitRecord:19
	UNLOAD RECORD:C212([xShell_ApplicationData:45])
	REDUCE SELECTION:C351([xShell_ApplicationData:45];0)
End if 


$0:=(<>LDL_RegisterKey ?? $l_idModulo) | (USR_GetUserID <0)

