//%attributes = {}
  // dhQF_PreProcessValue(campo:Y; valorliteral:T)
  // Por: Alberto Bachler: 22/02/13, 10:42:00 
  // (codigo original de R. Catalan)
  //  ---------------------------------------------
  // preprocesa el valor pasado en valorLiteral en función del campo
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($y_tipo)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_valorLiteral)

If (False:C215)
	C_TEXT:C284(dhQF_PreProcessValue ;$0)
	C_POINTER:C301(dhQF_PreProcessValue ;$1)
	C_TEXT:C284(dhQF_PreProcessValue ;$2)
End if 

$y_campo:=$1
$t_valorLiteral:=$2
$y_tipo:=Type:C295($y_campo->)
Case of 
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (KRL_isSameField (->[Personas:7]ACT_Numero_TC:54;$y_campo))
				$t_valorLiteral:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->$t_valorLiteral;->[Personas:7]ACT_xPass:91)
		End case 
		
End case 

$0:=$t_valorLiteral