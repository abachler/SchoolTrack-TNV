//%attributes = {}
  //HL_Selection2List

  //`xShell, Alberto Bachler
  //Metodo: HL_Selection2List
  //Por abachler
  //Creada el 13/09/2004, 11:49:53
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$fieldPointer;$tablePointer)
C_LONGINT:C283($listRef;$itemRef)
C_TEXT:C284($itemText)
C_BOOLEAN:C305($abort)

  //****INICIALIZACIONES****
$fieldPointer:=$1
If (Count parameters:C259=2)
	$useRecNum:=False:C215
	$RefNumFieldPointer:=$2
	If ((Type:C295($RefNumFieldPointer->)<8) | (Type:C295($RefNumFieldPointer->)>9))
		$abort:=True:C214
	End if 
Else 
	$useRecNUm:=True:C214
End if 
$tablePointer:=Table:C252(Table:C252($fieldPointer))

  //****CUERPO****
If (Not:C34($abort))
	$listRef:=New list:C375
	While (Not:C34(End selection:C36($tablePointer->)))
		$itemText:=ST_Coerce_to_Text ($fieldPointer)
		If ($useRecNum)
			$itemRef:=Record number:C243($tablePointer->)
		Else 
			$itemRef:=$RefNumFieldPointer->
		End if 
		APPEND TO LIST:C376($listRef;$itemText;$itemRef)
		NEXT RECORD:C51($tablePointer->)
	End while 
	$0:=$listRef
Else 
	$0:=0
	ALERT:C41("El campo para Referencia no es compatible (debe ser Integer o Longint).")
End if 

  //****LIMPIEZA****