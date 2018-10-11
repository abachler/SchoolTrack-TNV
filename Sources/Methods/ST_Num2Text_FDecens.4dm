//%attributes = {}
  //ST_Num2Text_FDecens

C_TEXT:C284($1;$vt_Number)
C_TEXT:C284($2;$vt_Idioma)
C_TEXT:C284($3;$vt_Mantisa)

$vt_Number:=$1
$vt_Idioma:=$2
$vt_Mantisa:=$3

C_TEXT:C284($0;$vt_SumResult;$vt_SumResultTemp)
C_TEXT:C284($vt_FindNumber)


$vt_FindNumber:=Substring:C12($vt_Number;1;2)
$vt_SumResult:=ST_Num2Text_IdiomTable ($vt_FindNumber;$vt_Idioma;$vt_Mantisa)
If (Substring:C12($vt_SumResult;1;1)#"1")  //si el dato fue encontrado en la primera pasada esta parte no se ejecuta
	$vt_FindNumber:=Substring:C12($vt_FindNumber;2;1)
	$vt_SumResultTemp:=ST_Num2Text_IdiomTable ($vt_FindNumber;$vt_Idioma;$vt_Mantisa)
	If (Substring:C12($vt_SumResultTemp;1;1)="1")  //si el dato fue encontrado en la primera pasada esta rutina se ejecuta
		$vt_SumResultTemp:=Substring:C12($vt_SumResultTemp;2)
		$vt_SumResult:=$vt_SumResult+" y "+$vt_SumResultTemp
		  //No existe un caso else pues se asume que se coloco un dato invalido ejem 2a
	End if 
Else 
	$vt_SumResult:=Substring:C12($vt_SumResult;2)  //si el dato fue encontrado en la primera pasada esta rutina se ejecuta
End if 

$0:=$vt_SumResult