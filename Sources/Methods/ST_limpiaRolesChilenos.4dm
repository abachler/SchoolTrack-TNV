//%attributes = {}
  //ST_limpiaRolesChilenos

If (False:C215)
	  // Project method: ST_cleanNumString
	  // Module: 
	  // Purpose:
	  // Syntax: ST_cleanNumString()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 24/10/01  08:49, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================
_O_C_STRING:C293(255;$0;$1)

  // INITIALIZATION
  // ============================================
$string:=$1

  // MAIN CODE
  // ============================================
Case of 
	: (<>vtXS_CountryCode="cl")
		$string:=Replace string:C233($string;" ";"")
		$string:=Replace string:C233($string;"-";"")
		$string:=Replace string:C233($string;".";"")
		While (Position:C15("0";$string)=1)
			$string:=Substring:C12($string;2)
		End while 
		$0:=$string
	Else 
		$0:=$string
End case 
  // END OF METHOD