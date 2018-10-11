//%attributes = {}
  //GetGrado

C_LONGINT:C283($1)
C_TEXT:C284($2;$class)
$0:=""
$nivelNo:=$1
Case of 
	: (Count parameters:C259=3)
		$letra:=$3
		$class:=$2
	: (Count parameters:C259=2)
		$class:=$2
		$letra:=Substring:C12($class;Position:C15("-";$class)+1)
End case 

$nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNo;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)

If (Count parameters:C259=1)
	$0:=$nivel
Else 
	$year:=Position:C15(" Año ";$nivel)
	If ($year>0)
		$0:=Replace string:C233($nivel;" Año ";" Año "+$letra+" ")
	Else 
		$0:=$nivel+" ("+$class+")"
	End if 
	$0:=Replace string:C233($0;"  ";" ")
End if 
