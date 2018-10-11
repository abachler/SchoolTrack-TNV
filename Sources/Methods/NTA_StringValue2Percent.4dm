//%attributes = {}
  //NTA_StringValue2Percent

C_LONGINT:C283($2;$3;$convertFrom)
C_REAL:C285($0;$result)
C_TEXT:C284($1)
$result:=0
$string:=EV2_Literal_Sistema ($1)


Case of 
	: (Count parameters:C259=3)
		$evStyleID:=$2
		$convertFrom:=$3
	: (Count parameters:C259>=2)
		$evStyleID:=$2
	: (Count parameters:C259=1)
		$evStyleID:=0
End case 
If ($evStyleID#0)
	EVS_ReadStyleData ($evStyleID)
End if 
If ($convertFrom=0)
	$convertFrom:=iEvaluationMode
End if 
Case of 
	: ($string="-10")
		$result:=-10
	: ($string="")
		$result:=-10
	: ($string="ERR")
		$result:=-9
	: ($string=">>>")
		$result:=-5
	: ($string="*")
		$result:=-4
	: (($string="X") | ($string="EX"))
		$result:=-3
	: ($string="P")
		$result:=-2
	: ($string="NE")
		$result:=-1
	: ($convertFrom=Notas)
		$result:=EV2_Nota_a_Real (Num:C11($string))
	: ($convertFrom=Puntos)
		$result:=EV2_Puntos_a_Real (Num:C11($string))
	: ($convertFrom=Porcentaje)
		$result:=Round:C94(Num:C11($string);1)
	: ($convertFrom=Simbolos)
		$result:=EV2_Simbolo_a_Real ($string)
End case 

$0:=$result
