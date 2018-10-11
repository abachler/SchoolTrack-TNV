//%attributes = {}
  //ST_Num2Text_FUnits

C_TEXT:C284($1;$vt_Number)
C_TEXT:C284($2;$vt_Idioma)
C_TEXT:C284($3;$vt_Mantisa)

$vt_Number:=$1
$vt_Idioma:=$2
$vt_Mantisa:=$3

C_TEXT:C284($0;$vt_SumResult)
C_TEXT:C284($vt_FindNumber)
$vt_FindNumber:=Substring:C12($vt_Number;1;1)
$vt_SumResult:=ST_Num2Text_IdiomTable ($vt_FindNumber;$vt_Idioma;$vt_Mantisa)
If (Substring:C12($vt_SumResult;1;1)="1")
	  //$vt_SumResult:="un"
	  //Else 
	$vt_SumResult:=Substring:C12($vt_SumResult;2)
End if 

$0:=$vt_SumResult