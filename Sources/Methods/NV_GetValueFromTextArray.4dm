//%attributes = {}
  //NV_GetValueFromTextArray

  //`xShell, Alberto Bachler
  //Metodo: Método: 
  //Por abachler
  //Creada el 26/11/2005, 11:07:58
  //Modificaciones:
If ("DESCRIPCION"="")
	  //Retorna el valor de un item nombrado desde el arreglo que contiene los pares (nombre=valor)
	  // $1: PUNTERO, puntero sobre el arreglo que contiene los pares de valores nombrados
	  // $2: TEXTO, nombre delvalor buscado
	  // $3: TEXTO, separador - opcional, por defecto el signo igual a (=)
	  // (retorna texto vacio si no encuentra el nombre)
	
	  // $valor:=NV_GetValueFromTextArray(arrayPointer;nombre{;separador})
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$textarraypointer)
C_TEXT:C284($2;$3;$0;$name;$value)

  //****INICIALIZACIONES****
$textArrayPointer:=$1
$name:=$2
$separator:="="
If (Count parameters:C259=3)
	$separator:=$3
End if 
If ($name#"")
	$name:=$name+$separator+"@"
	
	  //****CUERPO****
	$el:=Find in array:C230($textArrayPointer->;$name)
	
	If ($el>0)
		$text:=$textArrayPointer->{$el}
		$value:=ST_GetWord ($text;2;$separator)
	End if 
	
	$0:=$value
Else 
	$0:=""
End if 

  //****LIMPIEZA****







