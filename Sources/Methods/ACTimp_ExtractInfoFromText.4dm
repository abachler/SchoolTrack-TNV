//%attributes = {}
  //ACTimp_ExtractInfoFromText

  //$1 -> Delimitado o ancho fijo. TRUE-> ANCHO FIJO. FALSE ->DELIMITADO
  //$2 -> línea completa leida desde archivo
  //$3->alineado
  //$4->inicio
  //$5->largo
  //$6->relleno
C_BOOLEAN:C305($1;$anchoFijo)
C_TEXT:C284($alineado;$source;$relleno;$delimitador;$2;$3;$6;$7;$0)
C_LONGINT:C283($inicio;$largo;$tipoDato;$4;$5)

  //$tipoDato:=
$anchoFijo:=$1
$source:=$2
$alineado:=$3
$inicio:=$4
$largo:=$5
$relleno:=$6
$delimitador:=$7

If ($relleno="Espacio")
	$relleno:=" "
Else 
	If ($relleno="Cero")
		$relleno:="0"
	End if 
End if 

Case of 
	: ($anchoFijo)
		If ($alineado="Der")
			$0:=ST_DeleteCharsLeft (Substring:C12($source;$inicio;$largo);$relleno)
		Else 
			If ($alineado="Izq")
				$0:=ST_ClearSpaces (Substring:C12($source;$inicio;$largo))
			End if 
		End if 
	: (Not:C34($anchoFijo))
		If ($alineado="Der")
			$0:=ST_DeleteCharsLeft (ST_GetWord ($source;$inicio;$delimitador);$relleno)
		Else 
			$0:=ST_ClearSpaces (ST_GetWord ($source;$inicio;$delimitador))
		End if 
End case 