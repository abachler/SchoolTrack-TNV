//%attributes = {}
  // WSexe_LeeScript_in()
  // Por: Alberto Bachler: 02/05/13, 12:21:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_idScript)
C_POINTER:C301($y_nombreScript_t;$y_textoScript_t)
C_TEXT:C284($t_CodigoPais;$t_nombreScript;$t_rolBD;$t_TextoError;$t_textoScript)

If (False:C215)
	C_TEXT:C284(WSexe_LeeScript_in ;$0)
	C_LONGINT:C283(WSexe_LeeScript_in ;$1)
	C_POINTER:C301(WSexe_LeeScript_in ;$2)
	C_POINTER:C301(WSexe_LeeScript_in ;$3)
End if 


$t_rolBD:=<>gRolBD
$t_CodigoPais:=<>gCountryCode

$l_idScript:=$1
$y_textoScript_t:=$2
$y_nombreScript_t:=$3

WS_InitWebServicesVariables 
WEB SERVICE SET PARAMETER:C777("idScript";$l_idScript)
$t_TextoError:=WS_CallIntranetWebService ("WSexe_EnviaScript_out")

If ($t_TextoError="")
	WEB SERVICE GET RESULT:C779($x_blob;"textoScript")
	WEB SERVICE GET RESULT:C779($t_nombreScript;"nombreScript";*)  //20180514 RCH Ticket 206788
	If (BLOB size:C605($x_blob)>0)
		BLOB_Blob2Vars (->$x_blob;0;->$t_textoScript)
		$y_textoScript_t->:=$t_textoScript
		$y_nombreScript_t->:=$t_nombreScript
	End if 
End if 

$0:=$t_TextoError

