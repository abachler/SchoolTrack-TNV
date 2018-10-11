//%attributes = {}
  //ST_Num2Text_FFix1

C_LONGINT:C283($1;$2;$vl_Init;$vl_Lengt)
$vl_Init:=$1
$vl_Lengt:=$2

C_TEXT:C284($3;$vt_Number)
C_TEXT:C284($4;$vt_NumberTemp)
C_TEXT:C284($5;$vt_Idioma)
C_TEXT:C284($6;$vt_Mantisa)

$vt_Number:=$3
$vt_NumberTemp:=$4
$vt_Idioma:=$5
$vt_Mantisa:=$6

C_TEXT:C284($0;$vt_SumResult;$vt_SumResultTemp)
Case of 
	: ((Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))>99) & (Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))<1000))
		$vt_NumberTemp:=Substring:C12($vt_Number;$vl_Init;$vl_Lengt)
		$vt_SumResultTemp:=$vt_SumResultTemp+" "+ST_Num2Text_FCents ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResult:=$vt_SumResultTemp
	: ((Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))>9) & (Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))<100))
		$vt_NumberTemp:=Substring:C12($vt_Number;$vl_Init+1;$vl_Lengt-1)
		$vt_SumResultTemp:=$vt_SumResultTemp+" "+ST_Num2Text_FDecens ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResult:=$vt_SumResultTemp
	: ((Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))>0) & (Num:C11(Substring:C12($vt_Number;$vl_Init;$vl_Lengt))<10))
		$vt_NumberTemp:=Substring:C12($vt_Number;$vl_Init+2;$vl_Lengt-2)
		$vt_SumResultTemp:=$vt_SumResultTemp+" "+ST_Num2Text_FUnits ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResult:=$vt_SumResultTemp
End case 

$0:=$vt_SumResult