//%attributes = {"executedOnServer":true}
  // SYS_ServerDocumentList()
  // Por: Alberto Bachler K.: 21-10-14, 10:05:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_opciones)
C_POINTER:C301($y_listaDocumentos)
C_TEXT:C284($t_rutaCarpeta)


If (False:C215)
	C_TEXT:C284(SYS_ServerDocumentList ;$1)
	C_POINTER:C301(SYS_ServerDocumentList ;$2)
	C_LONGINT:C283(SYS_ServerDocumentList ;$3)
End if 

$t_rutaCarpeta:=$1
$y_listaDocumentos:=$2

If (Count parameters:C259=3)
	$l_opciones:=$3
End if 


Case of 
	: (SYS_IsWindows )
		$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;":";Folder separator:K24:12)
		$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;"\\\\";":\\")
	: (SYS_IsMacintosh )
		$t_rutaCarpeta:=Replace string:C233($t_rutaCarpeta;"\\";Folder separator:K24:12)
End case 

DOCUMENT LIST:C474($t_rutaCarpeta;$y_listaDocumentos->;$l_opciones)

