//%attributes = {}
  // Método: EV2_ALT_FormatoString
  //
  //
  // por Alberto Bachler Klein
  // creación 18/07/17, 19:26:46
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_decimales)
C_TEXT:C284($t_formato)


If (False:C215)
	C_TEXT:C284(EV2_ALT_FormatoString ;$0)
	C_LONGINT:C283(EV2_ALT_FormatoString ;$1)
End if 

$l_decimales:=$1


Case of 
	: ($l_decimales=0)
		If (rGradesFrom=0)
			$t_formato:="####0"
		Else 
			$t_formato:="#####"
		End if 
	: ($l_decimales=1)
		$t_formato:="##0"+<>tXS_RS_DecimalSeparator+"0"
	: ($l_decimales=2)
		$t_formato:="#0"+<>tXS_RS_DecimalSeparator+"00"
	: ($l_decimales=3)
		$t_formato:="#"+<>tXS_RS_DecimalSeparator+"###"
End case 


$0:=$t_formato