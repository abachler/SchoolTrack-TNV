//%attributes = {}
  // WSexe_ActivacionScript_out()
  // Por: Alberto Bachler: 02/05/13, 11:22:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($b_activar)
C_LONGINT:C283($l_IdScript)
C_TEXT:C284($t_CodigoPais;$t_rolBD;$t_TextoError)

If (False:C215)
	C_TEXT:C284(WSexe_ActivacionScript_out ;$0)
	C_LONGINT:C283(WSexe_ActivacionScript_out ;$1)
	C_BOOLEAN:C305(WSexe_ActivacionScript_out ;$2)
	C_TEXT:C284(WSexe_ActivacionScript_out ;$3)
	C_TEXT:C284(WSexe_ActivacionScript_out ;$4)
End if 


$t_rolBD:=<>gRolBD
$t_CodigoPais:=<>gCountryCode

$l_IdScript:=$1
$b_activar:=$2
If (Count parameters:C259=4)
	$t_rolBD:=$3
	$t_CodigoPais:=$4
End if 

WS_InitWebServicesVariables 
WEB SERVICE SET PARAMETER:C777("codpais";$t_CodigoPais)
WEB SERVICE SET PARAMETER:C777("rol";$t_rolBD)
WEB SERVICE SET PARAMETER:C777("id_script";$l_IdScript)
WEB SERVICE SET PARAMETER:C777("accion";$b_activar)
$t_TextoError:=WS_CallIntranetWebService ("WSexe_ActivacionScript_in")

$0:=$t_TextoError