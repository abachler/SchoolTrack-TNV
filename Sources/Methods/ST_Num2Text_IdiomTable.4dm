//%attributes = {}
  //ST_Num2Text_IdiomTable

C_TEXT:C284($1;$vt_FindNumber)
C_TEXT:C284($2;$vt_Idiom2)
C_TEXT:C284($3;$vt_Mantisa2)
$vt_FindNumber:=$1
$vt_Idiom2:=$2
$vt_Mantisa2:=$3


C_LONGINT:C283($vl_Result)
C_TEXT:C284($0;$vt_Result;$vt_SumResult)
ARRAY TEXT:C222(at_Result;0)
Case of 
	: (($vt_Idiom2="Spanish") | ($vt_Idiom2="es"))
		ARRAY TEXT:C222($atNum_Letras;31)
		ARRAY TEXT:C222($atNum_Letras2;Size of array:C274($atNum_Letras))
		$atNum_Letras{1}:=("cero")
		$atNum_Letras2{1}:="0"
		$atNum_Letras{2}:=("uno")
		$atNum_Letras2{2}:="1"
		$atNum_Letras{3}:=("dos")
		$atNum_Letras2{3}:="2"
		$atNum_Letras{4}:=("tres")
		$atNum_Letras2{4}:="3"
		$atNum_Letras{5}:=("cuatro")
		$atNum_Letras2{5}:="4"
		$atNum_Letras{6}:=("cinco")
		$atNum_Letras2{6}:="5"
		$atNum_Letras{7}:=("seis")
		$atNum_Letras2{7}:="6"
		$atNum_Letras{8}:=("siete")
		$atNum_Letras2{8}:="7"
		$atNum_Letras{9}:=("ocho")
		$atNum_Letras2{9}:="8"
		$atNum_Letras{10}:=("nueve")
		$atNum_Letras2{10}:="9"
		$atNum_Letras{11}:=("diez")
		$atNum_Letras2{11}:="10"
		$atNum_Letras{12}:=("once")
		$atNum_Letras2{12}:="11"
		$atNum_Letras{13}:=("doce")
		$atNum_Letras2{13}:="12"
		$atNum_Letras{14}:=("trece")
		$atNum_Letras2{14}:="13"
		$atNum_Letras{15}:=("catorce")
		$atNum_Letras2{15}:="14"
		$atNum_Letras{16}:=("quince")
		$atNum_Letras2{16}:="15"
		$atNum_Letras{17}:=("diez y seis")
		$atNum_Letras2{17}:="16"
		$atNum_Letras{18}:=("diez y siete")
		$atNum_Letras2{18}:="17"
		$atNum_Letras{19}:=("diez y ocho")
		$atNum_Letras2{19}:="18"
		$atNum_Letras{20}:=("diez y nueve")
		$atNum_Letras2{20}:="19"
		$atNum_Letras{21}:=("veinte")
		$atNum_Letras2{21}:="20"
		$atNum_Letras{22}:=("treinta")
		$atNum_Letras2{22}:="30"
		$atNum_Letras{23}:=("cuarenta")
		$atNum_Letras2{23}:="40"
		$atNum_Letras{24}:=("cincuenta")
		$atNum_Letras2{24}:="50"
		$atNum_Letras{25}:=("sesenta")
		$atNum_Letras2{25}:="60"
		$atNum_Letras{26}:=("setenta")
		$atNum_Letras2{26}:="70"
		$atNum_Letras{27}:=("ochenta")
		$atNum_Letras2{27}:="80"
		$atNum_Letras{28}:=("noventa")
		$atNum_Letras2{28}:="90"
		
		$atNum_Letras{29}:=("cien")
		$atNum_Letras{30}:=("ciento")
		$atNum_Letras{31}:=("cientos")
		  // /Casos Especiales
		  //$atNum_Letras{29}:=("quinientos")
		  //$atNum_Letras2{29}:="500"
		
		$vl_Result:=Find in array:C230($atNum_Letras2;$vt_FindNumber)
		
		  //Iteration search
		C_LONGINT:C283($i)
		If ($vl_Result=-1)
			Case of 
				: ((Num:C11($vt_FindNumber)>20) & (Num:C11($vt_FindNumber)<30))
					$vt_Result:=$atNum_Letras{21}
				: ((Num:C11($vt_FindNumber)>30) & (Num:C11($vt_FindNumber)<40))
					$vt_Result:=$atNum_Letras{22}
				: ((Num:C11($vt_FindNumber)>40) & (Num:C11($vt_FindNumber)<50))
					$vt_Result:=$atNum_Letras{23}
				: ((Num:C11($vt_FindNumber)>50) & (Num:C11($vt_FindNumber)<60))
					$vt_Result:=$atNum_Letras{24}
				: ((Num:C11($vt_FindNumber)>60) & (Num:C11($vt_FindNumber)<70))
					$vt_Result:=$atNum_Letras{25}
				: ((Num:C11($vt_FindNumber)>70) & (Num:C11($vt_FindNumber)<80))
					$vt_Result:=$atNum_Letras{26}
				: ((Num:C11($vt_FindNumber)>80) & (Num:C11($vt_FindNumber)<90))
					$vt_Result:=$atNum_Letras{27}
				: ((Num:C11($vt_FindNumber)>90) & (Num:C11($vt_FindNumber)<100))
					$vt_Result:=$atNum_Letras{28}
				: (Num:C11($vt_FindNumber)=100)
					$vt_Result:=$atNum_Letras{29}
				: (Num:C11($vt_FindNumber)>100) & (Num:C11($vt_FindNumber)<200)
					$vt_Result:=$atNum_Letras{30}
				: (Num:C11($vt_FindNumber)>=200) & (Num:C11($vt_FindNumber)<1000)
					If (Num:C11($vt_FindNumber)#500)
						$vt_Result:=$atNum_Letras{31}
					End if 
			End case 
		Else 
			  //1 es un digito de verificacion especial que dice a la funcion que el numero fue hallado en la primera pasada y no debe ser llamada de nuevo
			$vt_Result:="1"+$atNum_Letras{$vl_Result}
		End if 
		
End case 
$0:=$vt_Result
