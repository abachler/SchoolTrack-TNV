//%attributes = {}
  //ST_GetStringByLen
  //RCH metodo para obtener una frase o palabra con un largo maximo. 
  //El metodo no corta una palabra a no ser de que la primera sea mas larga que el largo maximo.
  // por lo tanto, puede entregar frases que originalmente eran mayores al largo con un largo menor al maximo.
  //NOTA no esta probado para cadenas que contengan mas de una linea...

C_TEXT:C284($0)

C_LONGINT:C283($vl_contador;$vl_countWord;$vl_largoMax)
C_TEXT:C284($vt_frase;$vt_frase2;$vt_primeraPalabra;$vt_retorno)

$vt_frase:=$1
$vl_largoMax:=$2

  //si la frase es mayor proceso, sino retorno lo mismo.
If (Length:C16($vt_frase)>$vl_largoMax)
	  //obtengo los espacios...
	$vl_countWord:=ST_CountWords ($vt_frase;1;" ")
	  //obtengo la primera palabra de la frase
	$vt_primeraPalabra:=ST_GetWord ($vt_frase;1;" ")
	  //si el largo de la primera palabra es mayor que el largo maximo, corto la palabra...
	If (Length:C16($vt_primeraPalabra)>$vl_largoMax)
		$vt_retorno:=Substring:C12($vt_primeraPalabra;1;$vl_largoMax)
	Else 
		  //voy agregando palabra por palabra hasta que la cadena es superior al largo maximo.
		$vl_contador:=2
		$vt_frase2:=$vt_primeraPalabra
		$vt_retorno:=$vt_frase2
		While ((Length:C16($vt_frase2)<=$vl_largoMax) & ($vl_contador<=$vl_countWord))
			$vt_frase2:=$vt_frase2+" "+ST_GetWord ($vt_frase;$vl_contador;" ")
			If (Length:C16($vt_frase2)<=$vl_largoMax)
				$vt_retorno:=$vt_frase2
			End if 
			$vl_contador:=$vl_contador+1
		End while 
	End if 
Else 
	$vt_retorno:=$vt_frase
End if 
$0:=$vt_retorno