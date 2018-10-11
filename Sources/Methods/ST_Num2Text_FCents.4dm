//%attributes = {}
  //ST_Num2Text_FCents

C_TEXT:C284($1;$vt_Number)
C_TEXT:C284($2;$vt_Idioma)
C_TEXT:C284($3;$vt_Mantisa)

$vt_Number:=$1
$vt_Idioma:=$2
$vt_Mantisa:=$3

C_TEXT:C284($0;$vt_SumResult;$vt_SumResultTemp)
C_TEXT:C284($vt_FindNumber)

  //Generar el primer numero cien, doscientos, trescientos etc a partir del mismo ejm
  //100 = cien, >100 = ciento, 200=dos cientos
Case of 
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=200) & (Num:C11(Substring:C12($vt_Number;1;3))<300))
		$vt_SumResult:="doscientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=300) & (Num:C11(Substring:C12($vt_Number;1;3))<400))
		$vt_SumResult:="trescientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=400) & (Num:C11(Substring:C12($vt_Number;1;3))<500))
		$vt_SumResult:="cuatrocientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=500) & (Num:C11(Substring:C12($vt_Number;1;3))<600))
		$vt_SumResult:="quinientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=600) & (Num:C11(Substring:C12($vt_Number;1;3))<700))
		$vt_SumResult:="seiscientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=700) & (Num:C11(Substring:C12($vt_Number;1;3))<800))
		$vt_SumResult:="setecientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=800) & (Num:C11(Substring:C12($vt_Number;1;3))<900))
		$vt_SumResult:="ochocientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=900) & (Num:C11(Substring:C12($vt_Number;1;3))<1000))
		$vt_SumResult:="novecientos"
		
		  //: ((Num(Substring($vt_Number;1;3))>=500) & (Num(Substring($vt_Number;1;3))<600))
		  //$vt_SumResult:="quinientos"
		  //: ((Num(Substring($vt_Number;1;3))>=700) & (Num(Substring($vt_Number;1;3))<800))
		  //$vt_SumResult:="setecientos"
		  //: ((Num(Substring($vt_Number;1;3))>=900) & (Num(Substring($vt_Number;1;3))<1000))
		  //$vt_SumResult:="novecientos"
		
	: ((Num:C11(Substring:C12($vt_Number;1;3))>=100) & (Num:C11(Substring:C12($vt_Number;1;3))<500)) | ((Num:C11(Substring:C12($vt_Number;1;3))>=600) & (Num:C11(Substring:C12($vt_Number;1;3))<700) | ((Num:C11(Substring:C12($vt_Number;1;3))>=800) & (Num:C11(Substring:C12($vt_Number;1;3))<900)))
		If (Substring:C12($vt_Number;1;1)="1")
			$vt_FindNumber:=Substring:C12($vt_Number;1;3)
			$vt_SumResult:=ST_Num2Text_IdiomTable ($vt_FindNumber;$vt_Idioma;$vt_Mantisa)
			If (Substring:C12($vt_SumResult;1;1)="1")
				$vt_SumResult:=Substring:C12($vt_SumResult;2)
			End if 
		Else 
			$vt_FindNumber:=Substring:C12($vt_Number;1;1)
			$vt_SumResult:=ST_Num2Text_FUnits ($vt_Number;$vt_Idioma;$vt_Mantisa)
			  //agregar el cientos
			$vt_FindNumber:=Substring:C12($vt_Number;1;3)
			$vt_SumResultTemp:=ST_Num2Text_IdiomTable ($vt_FindNumber;$vt_Idioma;$vt_Mantisa)
			If (Substring:C12($vt_SumResult;1;1)="1")
				$vt_SumResultTemp:=Substring:C12($vt_SumResult;2)
			End if 
			$vt_SumResult:=$vt_SumResult+" "+$vt_SumResultTemp
		End if 
End case 
  //generar las decenas del numero y caso especial cuando no es decena.
If (Substring:C12($vt_Number;2;2)#"00")
	If ((Substring:C12($vt_Number;2;1)="0") & (Substring:C12($vt_Number;2;2)#"0"))
		$vt_Number:=Substring:C12($vt_Number;3;1)
		$vt_SumResultTemp:=ST_Num2Text_FUnits ($vt_Number;$vt_Idioma;$vt_Mantisa)
		$vt_SumResult:=$vt_SumResult+" "+$vt_SumResultTemp
	Else 
		$vt_Number:=Substring:C12($vt_Number;2;2)
		$vt_SumResultTemp:=ST_Num2Text_FDecens ($vt_Number;$vt_Idioma;$vt_Mantisa)
		$vt_SumResult:=$vt_SumResult+" "+$vt_SumResultTemp
	End if 
End if 

$0:=$vt_SumResult
