//%attributes = {}
  //ST_Num2Text_Traductor

C_TEXT:C284($1;$vt_Number;$vt_NumberTemp)
C_TEXT:C284($2;$vt_Mantisa)
C_TEXT:C284($3;$vt_Idioma)

$vt_Number:=$1
$vt_Mantisa:=$2
$vt_Idioma:=$3

C_TEXT:C284($vt_FindNumber)
C_TEXT:C284($0;$vt_Result;$vt_SumResult;$vt_SumResultTemp;$vt_SumResultTemp2)

C_LONGINT:C283($i)
Case of 
	: ($vt_Mantisa="Unidades")
		$vt_SumResult:=ST_Num2Text_FUnits ($vt_Number;$vt_Idioma;$vt_Mantisa)
	: ($vt_Mantisa="Decenas")
		$vt_SumResult:=ST_Num2Text_FDecens ($vt_Number;$vt_Idioma;$vt_Mantisa)
	: ($vt_Mantisa="Centenas")
		$vt_SumResult:=ST_Num2Text_FCents ($vt_Number;$vt_Idioma;$vt_Mantisa)
	: ($vt_Mantisa="Miles")
		If (Substring:C12($vt_Number;1;1)="1")
			$vt_SumResultTemp:="un mil"
		Else 
			$vt_NumberTemp:=Substring:C12($vt_Number;1;1)
			$vt_SumResultTemp:=ST_Num2Text_FUnits ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			$vt_SumResultTemp:=$vt_SumResultTemp+" mil"
		End if 
		$vt_NumberTemp:=Substring:C12($vt_Number;2;3)
		$vt_SumResultTemp2:=ST_Num2Text_FFix1 (2;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2
		End if 
		
	: ($vt_Mantisa="Decenas de Mil")
		$vt_NumberTemp:=Substring:C12($vt_Number;1;2)
		$vt_SumResultTemp:=ST_Num2Text_FDecens ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResultTemp:=$vt_SumResultTemp+" mil"
		
		$vt_NumberTemp:=Substring:C12($vt_Number;3;3)
		$vt_SumResultTemp2:=ST_Num2Text_FFix1 (3;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2
		End if 
	: ($vt_Mantisa="Centenas de Mil")
		$vt_NumberTemp:=Substring:C12($vt_Number;1;3)
		$vt_SumResultTemp:=ST_Num2Text_FCents ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResultTemp:=$vt_SumResultTemp+" mil"
		
		$vt_NumberTemp:=Substring:C12($vt_Number;4;3)
		$vt_SumResultTemp2:=ST_Num2Text_FFix1 (4;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2
		End if 
	: ($vt_Mantisa="Millones")
		If (Substring:C12($vt_Number;1;1)="1")
			$vt_SumResultTemp:=" un millón"
		Else 
			$vt_NumberTemp:=Substring:C12($vt_Number;1;1)
			$vt_SumResultTemp:=ST_Num2Text_FUnits ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			$vt_SumResultTemp:=$vt_SumResultTemp+" millones"
		End if 
		
		If (Substring:C12($vt_Number;2;3)#"000")
			$vt_NumberTemp:=Substring:C12($vt_Number;2;3)
			$vt_SumResultTemp2:=ST_Num2Text_FFix1 (2;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			If ($vt_SumResultTemp="")
				$vt_SumResult:=$vt_SumResultTemp+" mil"
			Else 
				$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2+" mil"
			End if 
		Else 
			$vt_SumResult:=$vt_SumResultTemp
		End if 
		
		$vt_NumberTemp:=Substring:C12($vt_Number;5;3)
		$vt_SumResultTemp2:=$vt_SumResult+ST_Num2Text_FFix1 (5;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp2
		End if 
	: ($vt_Mantisa="Decenas de Millon")
		$vt_NumberTemp:=Substring:C12($vt_Number;1;2)
		$vt_SumResultTemp:=ST_Num2Text_FDecens ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResultTemp:=$vt_SumResultTemp+" millones"
		If (Substring:C12($vt_Number;3;3)#"000")
			$vt_NumberTemp:=Substring:C12($vt_Number;3;3)
			$vt_SumResultTemp2:=ST_Num2Text_FFix1 (3;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			If ($vt_SumResultTemp="")
				$vt_SumResult:=$vt_SumResultTemp+" mil"
			Else 
				$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2+" mil"
			End if 
		Else 
			$vt_SumResult:=$vt_SumResultTemp
		End if 
		$vt_NumberTemp:=Substring:C12($vt_Number;6;3)
		$vt_SumResultTemp2:=$vt_SumResult+ST_Num2Text_FFix1 (6;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp2
		End if 
	: ($vt_Mantisa="Centenas de Millon")
		$vt_NumberTemp:=Substring:C12($vt_Number;1;3)
		$vt_SumResultTemp:=ST_Num2Text_FCents ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		$vt_SumResultTemp:=$vt_SumResultTemp+" millones"
		
		If (Substring:C12($vt_Number;4;3)#"000")
			$vt_NumberTemp:=Substring:C12($vt_Number;4;3)
			$vt_SumResultTemp2:=ST_Num2Text_FFix1 (4;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			If ($vt_SumResultTemp="")
				$vt_SumResult:=$vt_SumResultTemp+" mil"
			Else 
				$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2+" mil"
			End if 
		Else 
			$vt_SumResult:=$vt_SumResultTemp
		End if 
		$vt_NumberTemp:=Substring:C12($vt_Number;7;3)
		$vt_SumResultTemp2:=$vt_SumResult+ST_Num2Text_FFix1 (7;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp2
		End if 
	: ($vt_Mantisa="Billones")
		
		If ((Num:C11(Substring:C12($vt_Number;1;1))>=1) & (Substring:C12($vt_Number;2;3)="000"))
			$vt_NumberTemp:=Substring:C12($vt_Number;1;1)
			$vt_SumResultTemp:=$vt_SumResultTemp+" mil millones"
		Else 
			If (Substring:C12($vt_Number;1;1)="1")
				$vt_SumResultTemp:="mil"
			Else 
				$vt_NumberTemp:=Substring:C12($vt_Number;1;1)
				$vt_SumResultTemp:=ST_Num2Text_FUnits ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
				$vt_SumResultTemp:=$vt_SumResultTemp+" mil "
			End if 
			If (Num:C11(Substring:C12($vt_Number;2;3))>=1)
				$vt_NumberTemp:=Substring:C12($vt_Number;2;3)
				$vt_SumResultTemp:=$vt_SumResultTemp+" "+ST_Num2Text_FCents ($vt_NumberTemp;$vt_Idioma;$vt_Mantisa)+" mil millones"
			End if 
		End if 
		If (Substring:C12($vt_Number;5;3)#"000")
			$vt_NumberTemp:=Substring:C12($vt_Number;5;3)
			$vt_SumResultTemp2:=ST_Num2Text_FFix1 (5;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
			If ($vt_SumResultTemp="")
				$vt_SumResult:=$vt_SumResultTemp+" mil"
			Else 
				$vt_SumResult:=$vt_SumResultTemp+$vt_SumResultTemp2+" mil"
			End if 
		Else 
			$vt_SumResult:=$vt_SumResultTemp
		End if 
		$vt_NumberTemp:=Substring:C12($vt_Number;8;3)
		$vt_SumResultTemp2:=$vt_SumResult+ST_Num2Text_FFix1 (8;3;$vt_Number;$vt_NumberTemp;$vt_Idioma;$vt_Mantisa)
		If ($vt_SumResultTemp="")
			$vt_SumResult:=$vt_SumResultTemp
		Else 
			$vt_SumResult:=$vt_SumResultTemp2
		End if 
End case 

$0:=$vt_SumResult
