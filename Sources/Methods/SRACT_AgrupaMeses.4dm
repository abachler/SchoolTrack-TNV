//%attributes = {}
  //SRACT_AgrupaMeses

  //Método que agrupa los meses pasados como números en un arreglo y devuelve una variable texto con los meses agrupados en números o nombres de meses.
  //Parametro 1, arreglo numérico que contiene el número de meses.
  //Parametro 2, variable numerica que setea la forma en que se requiere agrupar los meses.1 =  Meses en palabras. 2 Meses en número
  //Los meses seguidos los junta con guión en medio y los meses saltados van con coma. 
  //Ejemplo: Si es pasado en el primer parametro un arreglo con 9 elementos (1 - 2 - 3 - 6 - 8 - 9 - 10 - 11 - 12), y 1 en el segundo parámetro, el método devolverá "Enero - Marzo, Junio, Agosto - Diciembre"

C_POINTER:C301($ptrArray)
ARRAY LONGINT:C221($al_meses;0)
ARRAY TEXT:C222($aMeses;12)
C_TEXT:C284($0;$vt_retorno)
C_LONGINT:C283($i;$2)
C_BOOLEAN:C305($vb_existe;$vb_mesLocalizado)

  //20120720 RCH Acepta mes localizado

$ptrArray:=$1
If (Count parameters:C259>=3)
	$vb_mesLocalizado:=$3
End if 
Case of 
	: ($2=1)
		If ($vb_mesLocalizado)
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
AT_DistinctsArrayValues ($ptrArray)
SORT ARRAY:C229($ptrArray->;>)
For ($i;1;Size of array:C274($ptrArray->))
	Case of 
		: ($i=1)
			If (Size of array:C274($ptrArray->)=1)
				$vt_retorno:=$aMeses{$ptrArray->{$i}}
			Else 
				If ($ptrArray->{$i}+1=$ptrArray->{$i+1})
					$vt_retorno:=$aMeses{$ptrArray->{$i}}+" - "
				Else 
					$vt_retorno:=$aMeses{$ptrArray->{$i}}+", "
				End if 
			End if 
		: (Size of array:C274($ptrArray->)=$i)
			$vt_retorno:=$vt_retorno+$aMeses{$ptrArray->{$i}}
		Else 
			If ($ptrArray->{$i}+1=$ptrArray->{$i+1})
				$vb_existe:=Substring:C12($vt_retorno;Length:C16($vt_retorno)-1;Length:C16($vt_retorno))="- "
				If (Not:C34($vb_existe))
					$vt_retorno:=$vt_retorno+$aMeses{$ptrArray->{$i}}+" - "
				End if 
			Else 
				$vt_retorno:=$vt_retorno+$aMeses{$ptrArray->{$i}}+", "
			End if 
	End case 
End for 
$0:=$vt_retorno