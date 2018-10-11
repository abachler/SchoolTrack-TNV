//%attributes = {}
  //ST_Num2Text

C_REAL:C285($1)
C_BOOLEAN:C305($2;$writeDecimals;$usarSignosSeparadores)
C_TEXT:C284($0)

Case of 
	: (Count parameters:C259=2)
		$writeDecimals:=$2
	: (Count parameters:C259=3)
		$writeDecimals:=$2
		$usarSignosSeparadores:=$3
End case 


ARRAY TEXT:C222($One;19)
$one{1}:="Uno"
$one{2}:="Dos"
$one{3}:="Tres"
$one{4}:="Cuatro"
$one{5}:="Cinco"
$one{6}:="Seis"
$one{7}:="Siete"
$one{8}:="Ocho"
$one{9}:="Nueve"
$one{10}:="Diez"
$one{11}:="Once"
$one{12}:="Doce"
$one{13}:="Trece"
$one{14}:="Catorce"
$one{15}:="Quince"
$one{16}:="Dieciséis"
$one{17}:="Diecisiete"
$one{18}:="Dieciocho"
$one{19}:="Diecinueve"
ARRAY TEXT:C222($Two;9)
$two{1}:="Diez"
$two{2}:="Veinte"
$two{3}:="Treinta"
$two{4}:="Cuarenta"
$two{5}:="Cincuenta"
$two{6}:="Sesenta"
$two{7}:="Setenta"
$two{8}:="Ochenta"
$two{9}:="Noventa"
$string:=(String:C10($1))

$writeDecimals:=True:C214
If (Count parameters:C259>=2)
	$writeDecimals:=$2
End if 
If (Count parameters:C259>=3)
	$usarSignosSeparadores:=$3
End if 

If (<>tXS_RS_DecimalSeparator=",")
	If (Position:C15(",";$string)>0)
		$IntString:=Substring:C12($string;1;Position:C15(",";$string)-1)
		$decString:=Substring:C12($string;Position:C15(",";$string)+1)
	Else 
		$intString:=$string
		$decString:="0"
	End if 
Else 
	If (Position:C15(".";$string)>0)
		$IntString:=Substring:C12($string;1;Position:C15(".";$string)-1)
		$decString:=Substring:C12($string;Position:C15(".";$string)+1)
	Else 
		$intString:=$string
		$decString:="0"
	End if 
End if 

$l:=Length:C16($intString)
Case of 
	: ($l<=2)
		If (Num:C11($intString)=0)
			$0:="Cero"
		Else 
			If (Num:C11($intString)<20)
				$0:=$one{Num:C11($intString)}
			Else 
				If (Position:C15("0";$intString)=2)
					$0:=$two{Num:C11(Substring:C12($intString;1;1))}
				Else 
					$0:=$two{Num:C11(Substring:C12($intString;1;1))}+" y "+$one{Num:C11(Substring:C12($intString;2;1))}
				End if 
			End if 
		End if 
	: ($l=3)
		If (Num:C11($intString)=100)
			$0:="Cien"
		End if 
End case 


  //se consulta si el pais es chile para asignar el separador decimal
If (<>vtXS_CountryCode="cl")
	If (<>tXS_RS_DecimalSeparator=",")
		If ($usarSignosSeparadores)
			$separador:=", "
		Else 
			$separador:=" coma "
		End if 
	Else 
		If ($usarSignosSeparadores)
			$separador:=". "
		Else 
			$separador:=" punto "
		End if 
	End if 
Else 
	If (<>tXS_RS_DecimalSeparator=",")
		If ($usarSignosSeparadores)
			$separador:=", "
		Else 
			$separador:=" coma "
		End if 
	Else 
		If ($usarSignosSeparadores)
			$separador:=". "
		Else 
			$separador:=" punto "
		End if 
	End if 
End if 

  //If (<>tXS_RS_DecimalSeparator=",")
  //$separador:=" coma "
  //Else 
  //$separador:=" punto "
  //End if 


If (($decString#"") | ($writeDecimals))
	$l:=Length:C16($decString)
	Case of 
		: ($l<=2)
			If (Num:C11($decString)=0)
				If ($writeDecimals)
					$0:=$0+$separador+"Cero"
				End if 
			Else 
				If (Num:C11($decString)<20)
					$0:=$0+$separador+$one{Num:C11($decString)}
				Else 
					If (Position:C15("0";$decString)=2)
						$0:=$0+$separador+$two{Num:C11(Substring:C12($decString;1;1))}
					Else 
						$0:=$0+$separador+$two{Num:C11(Substring:C12($decString;1;1))}+" y "+$one{Num:C11(Substring:C12($decString;2;1))}
					End if 
				End if 
			End if 
	End case 
Else 
	$0:=$0  //+$separador+"Cero"
End if 
$0:=ST_Uppercase (Substring:C12($0;1;1))+ST_Lowercase (Substring:C12($0;2))
