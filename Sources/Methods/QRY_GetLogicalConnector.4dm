//%attributes = {}
  //QRY_GetLogicalConnector

  //Function:  EvaluateOp
  //Description:  This function will convert "And", "Or", "Except"
  //                     to 4D acceptables "&", "|", "#"



  //ATENCION!!!!!
  //ESPECIFICO A ST v11
  //NO SOBREESCRIBIR CON CODIGO DE SCHOOLTRACK X


C_TEXT:C284($0;$1;$operator)

If (Application version:C493>="11@")
	$operator:=$1
	$index:=Find in array:C230(<>atXS_QueryConnectors_Text;$operator)
	If ($index>0)
		$0:=<>atXS_QueryConnectors_Symbol{$index}
	Else 
		$0:=""
	End if 
Else 
	Case of 
		: ($1=aConnect{1})
			$0:="&"
		: ($1=aConnect{2})
			$0:="|"
		: ($1=aConnect{3})
			$0:="#"
		: ($1="")
			$0:=""
	End case 
End if 