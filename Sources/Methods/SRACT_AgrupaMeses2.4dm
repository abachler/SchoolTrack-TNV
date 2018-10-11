//%attributes = {}
  //SRACT_AgrupaMeses2

  //Método que agrupa los meses pasados como números en un arreglo y devuelve una variable texto con los meses agrupados en números o nombres de meses.
  //Parametro 1, arreglo texto con años meses. Ejemplo "200910", "200901"
  //Parametro 2, variable numerica que setea la forma en que se requiere agrupar los meses.1 =  Meses en palabras. 2 Meses en número
  //Los meses seguidos los junta con guión en medio y los meses saltados van con coma. 
  //$3 = 0 con año meses enteros
  //$3 = 1 no año meses enteros
  //$3 = 2 con año meses 3 caracteres
  //$3 = 3 no año meses 3 caracteres
  //20120720 RCH Acepta $4 en true para colocar meses localizados

ARRAY LONGINT:C221($al_meses;0)
ARRAY TEXT:C222($at_yearMonth;0)
ARRAY LONGINT:C221($al_year;0)
ARRAY LONGINT:C221($al_mesesNumericos;0)
ARRAY LONGINT:C221($al_yearsNumericos;0)
ARRAY TEXT:C222($aMeses;12)
C_TEXT:C284($0;$vt_retorno)
C_LONGINT:C283($i;$2)
C_BOOLEAN:C305($vb_existe;$vb_hayError)
C_LONGINT:C283($vl_opcion)
C_BOOLEAN:C305($vb_mesesLocalizados)

COPY ARRAY:C226($1->;$at_yearMonth)
If (Count parameters:C259>=3)
	$vl_opcion:=$3
End if 
If (Count parameters:C259>=4)
	$vb_mesesLocalizados:=$4
End if 
Case of 
	: ($2=1)
		If ($vb_mesesLocalizados)
			COPY ARRAY:C226(<>atXS_MonthNames;$aMeses)
		Else 
			COPY ARRAY:C226(<>atXS_MonthNames;$aMeses)
		End if 
	Else 
		ARRAY TEXT:C222(<>atXS_MonthNames;12)
		For ($i;1;Size of array:C274(<>atXS_MonthNames))
			<>atXS_MonthNames{$i}:=String:C10($i)
		End for 
		COPY ARRAY:C226(<>atXS_MonthNames;$aMeses)
End case 


AT_DistinctsArrayValues (->$at_yearMonth)
For ($i;1;Size of array:C274($at_yearMonth))
	APPEND TO ARRAY:C911($al_year;Num:C11($at_yearMonth{$i}))
	If (Length:C16($at_yearMonth{$i})#6)
		$vb_hayError:=True:C214
	End if 
End for 
If (Not:C34($vb_hayError))
	AT_DistinctsArrayValues (->$al_year)
	
	AT_Initialize (->$at_yearMonth)
	For ($i;1;Size of array:C274($al_year))
		APPEND TO ARRAY:C911($al_mesesNumericos;Num:C11(Substring:C12(String:C10($al_year{$i});5;2)))
		APPEND TO ARRAY:C911($al_yearsNumericos;Num:C11(Substring:C12(String:C10($al_year{$i});1;4)))
	End for 
	
	For ($i;1;Size of array:C274($al_mesesNumericos))
		Case of 
			: ($vl_opcion=0)
				$vt_year:=Substring:C12(String:C10($al_yearsNumericos{$i});3;2)
				$vt_meses:=$aMeses{$al_mesesNumericos{$i}}
			: ($vl_opcion=1)
				$vt_year:=""
				$vt_meses:=$aMeses{$al_mesesNumericos{$i}}
			: ($vl_opcion=2)
				$vt_year:=Substring:C12(String:C10($al_yearsNumericos{$i});3;2)
				$vt_meses:=Substring:C12($aMeses{$al_mesesNumericos{$i}};1;3)
			: ($vl_opcion=3)
				$vt_year:=""
				$vt_meses:=Substring:C12($aMeses{$al_mesesNumericos{$i}};1;3)
		End case 
		Case of 
			: ($i=1)
				If (Size of array:C274($al_mesesNumericos)=1)
					$vt_retorno:=$vt_meses+$vt_year
				Else 
					$vl_mesProximo:=$al_mesesNumericos{$i}+1
					$vl_yearProximo:=$al_yearsNumericos{$i}
					If ($vl_mesProximo=13)
						$vl_mesProximo:=1
						$vl_yearProximo:=$vl_yearProximo+1
					End if 
					If (($vl_mesProximo=$al_mesesNumericos{$i+1}) & ($vl_yearProximo=$al_yearsNumericos{$i+1}))
						$vt_retorno:=$vt_meses+$vt_year+" - "
					Else 
						$vt_retorno:=$vt_meses+$vt_year+", "
					End if 
				End if 
			: (Size of array:C274($al_mesesNumericos)=$i)
				$vt_retorno:=$vt_retorno+$vt_meses+$vt_year
			Else 
				$vl_mesProximo:=$al_mesesNumericos{$i}+1
				$vl_yearProximo:=$al_yearsNumericos{$i}
				If ($vl_mesProximo=13)
					$vl_mesProximo:=1
					$vl_yearProximo:=$vl_yearProximo+1
				End if 
				If (($vl_mesProximo=$al_mesesNumericos{$i+1}) & ($vl_yearProximo=$al_yearsNumericos{$i+1}))
					$vb_existe:=Substring:C12($vt_retorno;Length:C16($vt_retorno)-1;Length:C16($vt_retorno))="- "
					If (Not:C34($vb_existe))
						$vt_retorno:=$vt_retorno+$vt_meses+$vt_year+" - "
					End if 
				Else 
					$vt_retorno:=$vt_retorno+$vt_meses+$vt_year+", "
				End if 
		End case 
	End for 
Else 
	$vt_retorno:="ERROR"
End if 
$0:=$vt_retorno