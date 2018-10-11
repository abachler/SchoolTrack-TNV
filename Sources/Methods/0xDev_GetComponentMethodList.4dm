//%attributes = {}
  //0xDev_GetComponentMethodList

ARRAY TEXT:C222($aMethodNames;0)
ARRAY LONGINT:C221($aMethodIDs;0)
  //Copia al portapapeles la lista de métodos cuyos nombres comienzan con el prefijo solicitadp

4D_GetMethodList (->$aMethodNames;->$aMethodIDs)
SORT ARRAY:C229($aMethodNames;>)
OK:=1
While (OK=1)
	$componente:=Request:C163("Nombre del Componente")
	If ($componente#"")
		$abrev:=Request:C163("Abreviación")
		If ($abrev#"")
			$abrev:=$abrev+"_@"
			$el:=Find in array:C230($aMethodNames;$abrev)
			If ($el<0)
				ALERT:C41("No se encontro ningún metodo comenzando con "+$abrev)
			Else 
				$text:=$componente+"\r"
				$aMethodNames{0}:=$abrev
				AT_SearchArray (->$aMethodNames;">>")
				If (Size of array:C274(DA_Return)>0)
					For ($i;1;Size of array:C274(DA_Return))
						$text:=$text+$aMethodNames{DA_Return{$i}}+"\r"
					End for 
				End if 
				SET TEXT TO PASTEBOARD:C523($text)
			End if 
		End if 
	End if 
End while 