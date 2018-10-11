//%attributes = {}
  //IT_Clairvoyance

  //`xShell, Alberto Bachler
  //Metodo: IT_Clairvoyance
  //Por abachler
  //Creada el 04/02/2004, 22:11:45
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

C_POINTER:C301($1;$2;$5;$objectPointer;$arrayPointer;$ArrayRefPointer)
C_TEXT:C284($3;vt_BeforeEntryValue;vtKeystroke_Filter;$listName;$preservedValue;vt_EditedText)
C_POINTER:C301(vyXS_ChoiceList;$tablePointer)
C_BOOLEAN:C305($4;$preserveEnteredValue)

  //****INICIALIZACIONES****
$objectPointer:=$1
$arrayPointer:=$2
Case of 
	: (Count parameters:C259=6)
		$comparisonMode:=$6
		$ArrayRefPointer:=$5
		$preserveEnteredValue:=$4
		$listName:=$3
		
	: (Count parameters:C259=5)
		$listName:=$3
		$preserveEnteredValue:=$4
		$ArrayRefPointer:=$5
	: (Count parameters:C259=4)
		$listName:=$3
		$preserveEnteredValue:=$4
	: (Count parameters:C259=3)
		$listName:=$3
End case 


  //****CUERPO****
$event:=Form event:C388
Case of 
	: ($event=On After Edit:K2:43)
		
	: ($event=On Getting Focus:K2:7)
		vt_BeforeEntryValue:=$objectPointer->
		
	: ($event=On Before Keystroke:K2:6)
		  //vt_BeforeEntryValue:=Get edited text
		
	: (Form event:C388=On After Keystroke:K2:26)
		$objectPointer->:=Get edited text:C655
		vt_EditedText:=$objectPointer->
		$Ascii:=Character code:C91(Keystroke:C390)
		
		If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34))
			$length:=Length:C16($objectPointer->)
			If ($length>0)
				$t_valorTexto:=$objectPointer->+"@"
				$element:=Find in array:C230($arrayPointer->;$t_valorTexto)
				
				If ($element#-1)
					$objectPointer->:=$arrayPointer->{$element}
					$start:=$length+1
					$end:=Length:C16($objectPointer->)+1
					HIGHLIGHT TEXT:C210($objectPointer->;$start;$end)
				Else 
					  //HIGHLIGHT TEXT($objectPointer->;$length+1;$length+1)
				End if 
			End if 
		Else 
			vt_BeforeEntryValue:=$objectPointer->
		End if 
		
		
	: (($event=On Losing Focus:K2:8) | ($event=On Data Change:K2:15))
		  //$text:=Get edited text
		$key:=Character code:C91(Keystroke:C390)
		If (($key>=13) | ($key=8) | ($key=3) | ($key=9))
			If ($key=8)
				vt_BeforeEntryValue:=""
			End if 
			
			$preservedValue:=$objectPointer->
			GET HIGHLIGHT:C209($objectPointer->;$start;$end)
			If (($start>1) & ($end>$start) & ($start<Length:C16($objectPointer->)))
				$objectPointer->:=Substring:C12($objectPointer->;0;$start-1)
			End if 
			If ($objectPointer->#vt_BeforeEntryValue)
				$objectPointer->:=IT_ShowChoices ($arrayPointer;$objectPointer;$listName;$ArrayRefPointer;$tablePointer;$comparisonMode)
				If (($preserveEnteredValue) & ($objectPointer->=""))
					$objectPointer->:=$preservedValue
				End if 
				If ($objectPointer->="")
					  //MONO 11/10/2011 si se ingresa un valor no válido en la lista este se borra pero en el spell checking se recupera
					vbSpell_StopChecking:=True:C214
				End if 
			End if 
			FILTER KEYSTROKE:C389("")
		End if 
End case 

  //****LIMPIEZA****




