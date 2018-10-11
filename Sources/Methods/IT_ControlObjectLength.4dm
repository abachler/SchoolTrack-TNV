//%attributes = {}
  //IT_ControlObjectLength

  //`xShell, Alberto Bachler
  //Metodo: IT_ControlObjectLength
  //Por Administrator
  //Creada el 16/06/2005, 09:40:33
  //Modificaciones:
If ("DESCRIPCION"="")
	  //limita el máximo de caracteres ingresados en un objeto al largo definido en $2
	  //$1: Puntero sobre el objeto
	  //$2: maximo de caracteres aceptados
	  //$3: texto del mensaje de alerta (opcional)
	  //     si $3 no es pasado como argumento se muestra el mensaje de alerta por defecto
	  //     si $3="": no se muestra mensaje de alerta, suena un beep
	  //     si $3#"": se muestra el mensaje de alerta con el texto en $3
	  //Si el texto digitado sobrepasa el máximo de caracteres, es reducido al máximo y el cursor pasa al campo siguiente
	
	  //IMPORTANTE: los eventos On Getting Focus y On After Keystroke deben estar activados para el formulario y el objeto
	
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$objectPointer)
C_LONGINT:C283($2;$maxChars;$Ascii;vlObjetLength)
C_TEXT:C284($3;$alertMessage;vtEnteredChars)


  //****INICIALIZACIONES****
$objectPointer:=$1
$maxChars:=$2
If (Count parameters:C259=3)
	$alertMessage:=$3
Else 
	$alertMessage:=__ ("Este objeto no acepta más de ")+String:C10($maxChars)+__ (" caracteres.")
End if 

  //****CUERPO****
$objectPointer:=$1
$maxChars:=$2
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vlObjetLength:=0
		vtEnteredChars:=$objectPointer->
	: (Form event:C388=On After Keystroke:K2:26)
		$Ascii:=Character code:C91(Keystroke:C390)
		If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34))
			vlObjetLength:=vlObjetLength+1
			vtEnteredChars:=Get edited text:C655
			If (vlObjetLength>$maxChars)
				vtEnteredChars:=Substring:C12(vtEnteredChars;1;$maxChars)
				$objectPointer->:=vtEnteredChars
				If ($alertMessage#"")
					$ignore:=CD_Dlog (0;$alertMessage)
				Else 
					BEEP:C151
				End if 
				POST KEY:C465(9;0)
			End if 
		Else 
			vtEnteredChars:=Get edited text:C655
			vlObjetLength:=Length:C16(vtEnteredChars)
		End if 
End case 

  //****LIMPIEZA****


