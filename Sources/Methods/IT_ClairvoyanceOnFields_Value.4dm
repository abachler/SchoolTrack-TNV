//%attributes = {}
  //IT_ClairvoyanceOnFields_Value

  //`xShell, Alberto Bachler
  //Metodo: IT_clairvoyanceOnFields2
  //Por abachler
  //Creada el 07/02/2004, 08:19:36
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$2;$objectPointer;$Index2query;$table;$tablePointer)
C_TEXT:C284(vt_BeforeEntryValue;vtKeystroke_Filter;$listName;$preservedValue)
C_BOOLEAN:C305($3;$stayOnObject;vb_DisableAutocomplete)

  //****INICIALIZACIONES****
$objectPointer:=$1
$Index2query:=$2
If (Count parameters:C259=3)
	$stayOnObject:=$3
Else 
	$stayOnObject:=True:C214
End if 
$table:=Table:C252(Table:C252($Index2query))

  //****CUERPO****
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vt_BeforeEntryValue:=$objectPointer->
		vb_DisableAutocomplete:=False:C215
		
	: (Form event:C388=On Before Keystroke:K2:6)
		vt_BeforeEntryValue:=Get edited text:C655
		
	: (Form event:C388=On After Keystroke:K2:26)
		
		
		$objectPointer->:=Get edited text:C655
		$Ascii:=Character code:C91(Keystroke:C390)
		$AcceptEvent:=True:C214
		
		
		If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34) & ($ascii#Left arrow key:K12:16) & ($ascii#Right arrow key:K12:17) & ($ascii#Up arrow key:K12:18) & ($ascii#Down arrow key:K12:19))
			If (Not:C34(vb_DisableAutocomplete))
				$length:=Length:C16($objectPointer->)
				If ($length>0)
					$value:=$objectPointer->+"@"
					$recNum:=Find in field:C653($Index2query->;$value)
					If ($recNum#-1)
						PUSH RECORD:C176($table->)
						GOTO RECORD:C242($table->;$recNum)
						$value:=$Index2query->
						POP RECORD:C177($table->)
						$objectPointer->:=$value
						$start:=$length+1
						$end:=Length:C16($objectPointer->)+1
						HIGHLIGHT TEXT:C210($objectPointer->;$start;$end)
					Else 
						GET HIGHLIGHT:C209($objectPointer->;$start;$end)
						If ($END=$LENGTH)
							HIGHLIGHT TEXT:C210($objectPointer->;$length+1;$length+1)
						End if 
					End if 
				End if 
			End if 
		Else 
			vb_DisableAutocomplete:=True:C214
		End if 
		
	: ((Form event:C388=On Losing Focus:K2:8) & (Not:C34(vb_DisableAutocomplete)))
		GET HIGHLIGHT:C209($objectPointer->;$start;$end)
		If ($start>1)
			If (($start>1) & ($end>$start) & ($start<Length:C16($objectPointer->)))
				$preservedValue:=$objectPointer->
				$objectPointer->:=Substring:C12($objectPointer->;0;$start-1)
				$value:=$objectPointer->
			End if 
			If (($objectPointer->#vt_BeforeEntryValue) & ($objectPointer->#""))
				PUSH RECORD:C176(Table:C252(Table:C252($objectPointer))->)
				QUERY:C277($table->;$Index2query->=($objectPointer->+"@"))
				
				Case of 
					: (Records in selection:C76($table->)=0)
						POP RECORD:C177(Table:C252(Table:C252($objectPointer))->)
						  //GOTO AREA(Table(Table($objectPointer))->)
					: (Records in selection:C76($table->)=1)
						$Value:=$Index2query->
						POP RECORD:C177(Table:C252(Table:C252($objectPointer))->)
						$objectPointer->:=$value
					: (Records in selection:C76($table->)>1)
						vyXS_CallingVariable:=$objectPointer
						$tablePointer:=Table:C252(Table:C252($index2Query))
						ARRAY TEXT:C222(atXS_Choices;0)
						ARRAY LONGINT:C221(alXS_ChoicesRef;0)
						AT_DistinctsFieldValues ($Index2query;->atXS_Choices)
						ARRAY LONGINT:C221(alXS_ChoicesRef;Size of array:C274(atXS_Choices))
						If (Size of array:C274(atXS_Choices)>1)
							POP RECORD:C177(Table:C252(Table:C252($objectPointer))->)
							$value:=IT_OpenChoiceWindow 
							If (OK=1)
								$objectPointer->:=$value
							End if 
						Else 
							POP RECORD:C177(Table:C252(Table:C252($objectPointer))->)
							$objectPointer->:=atXS_Choices{1}
						End if 
				End case 
			Else 
			End if 
			If ($objectPointer->="")
				If ($stayOnObject)
					GOTO OBJECT:C206($objectPointer->)
				End if 
			End if 
		End if 
End case 

  //****LIMPIEZA****







