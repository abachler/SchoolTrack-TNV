//%attributes = {}
  //ST_AbbreviateString

  //`xShell, Alberto Bachler
  //Metodo: ST_AbbreviateString
  //Por Administrator
  //Creada el 16/06/2005, 09:55:49
  //Modificaciones:
If ("DESCRIPCION"="")
	  // abrevia un string al numero de caracteres pasado en $2
	  //las vocales son eliminadas (excepto cuando hay una en primera posición)
	  //toma en cuenta sólo las tres primeras palabras de una cadena
End if 

  //****DECLARACIONES****
C_TEXT:C284($1;$text;$0)
C_LONGINT:C283($2;$length)

  //****INICIALIZACIONES****
$text:=$1
$length:=$2

  //****CUERPO****
If ($text#"")
	$text:=Replace string:C233($text;" y ";" ")
	$words:=ST_CountWords ($text)
	Case of 
		: ($words=1)
			$firstChar:=$text[[1]]
			$text:=Replace string:C233($text;"a";"")
			$text:=Replace string:C233($text;"e";"")
			$text:=Replace string:C233($text;"i";"")
			$text:=Replace string:C233($text;"o";"")
			$text:=Replace string:C233($text;"u";"")
			If (Position:C15($firstChar;"aeiou")>0)
				$0:=$firstChar+Substring:C12($text;1;$length-1)
			Else 
				$0:=Substring:C12($text;1;$length)
			End if 
		: ($words=2)
			$maxFirstWord:=Round:C94($length*0.6;0)
			$maxSecondWord:=Round:C94($length*0.4;0)
			If (($maxFirstWord+$maxSecondWord)#$length)
				$maxSecondWord:=$length-$maxFirstWord
			End if 
			$0:=Substring:C12(ST_GetWord ($text;1);1;$maxFirstWord)+Substring:C12(ST_GetWord ($text;2);1;$maxSecondWord)
		Else 
			$maxFirstWord:=Round:C94($length*0.4;0)
			$maxSecondWord:=Round:C94($length*0.3;0)
			$maxThirdWord:=Round:C94($length*0.3;0)
			If (($maxFirstWord+$maxSecondWord+$maxThirdWord)#$length)
				$maxThirdWord:=$length-$maxFirstWord-$maxSecondWord
			End if 
			$0:=Substring:C12(ST_GetWord ($text;1);1;2)+Substring:C12(ST_GetWord ($text;2);1;2)+Substring:C12(ST_GetWord ($text;3);1;1)
	End case 
End if 

  //****LIMPIEZA****



