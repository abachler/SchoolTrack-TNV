//%attributes = {}
  //ST_FilterKeyStrokes

C_POINTER:C301($1)
C_TEXT:C284($2;vt_BeforeEntryValue;vtKeystroke_Filter)
C_LONGINT:C283($type;$event;$ascii;$length;$end;$start)
C_BOOLEAN:C305($acceptEvent)
$event:=Form event:C388

Case of 
	: ($event=On Getting Focus:K2:7)
		vt_BeforeEntryValue:=$1->
		vtKeystroke_Filter:=""  // clear filter    
		$type:=Type:C295($1->)
		Case of 
			: (($type=0) | ($type=2) | ($type=24))  // if alpha or text
				If (Count parameters:C259=2)  // if a filter was given
					vtKeystroke_Filter:=$2
				End if 
			: (($type=1) | ($type=4) | ($type=8) | ($type=9) | ($type=11))  // if numeric, time or date
				If (Count parameters:C259=4)  // if a filter was given
					vtKeystroke_Filter:=$2
				End if 
		End case 
		
		
	: ($event=On Before Keystroke:K2:6)
		TRACE:C157
		$Ascii:=Character code:C91(Keystroke:C390)
		$AcceptEvent:=True:C214
		If (vtKeystroke_Filter#"")
			If (($Ascii=Backspace key:K12:29) | ($Ascii=DEL ASCII code:K15:34))  // if filter list is given & keystroke is…
				Case of 
					: (ST_FindChar (vtKeystroke_Filter;Char:C90(Backspace key:K12:29))#-1)  // if backspace button was selected & is in filter list
						$AcceptEvent:=False:C215
					: (ST_FindChar (vtKeystroke_Filter;Char:C90(DEL ASCII code:K15:34))#-1)  // delete button was selected & is in filter list
						$AcceptEvent:=False:C215
				End case 
			End if 
		End if 
		
		If ($AcceptEvent)
			GET HIGHLIGHT:C209($1->;$start;$end)
			If (($Ascii=Backspace key:K12:29) | ($Ascii=DEL ASCII code:K15:34))
				$length:=$end-$start  // get the number of characters highlighted
				If ($length>0)  // if any characters are highlighted
					$1->:=Delete string:C232($1->;$start;$length)  // delete highlighted characters
				End if 
			End if 
		End if 
		
		Case of 
			: (($Ascii=Backspace key:K12:29) | ($Ascii=DEL ASCII code:K15:34))
				If ($AcceptEvent)
					If (($length=0) & ($start>1))  //  if no characters are highlighted & if not at left most position
						If (Length:C16($1->)>0)  // if there are any characters to delete
							$1->:=Delete string:C232($1->;$start-1;1)  // remove the character
						End if 
					End if 
				Else   // $AcceptEvent
					FILTER KEYSTROKE:C389("")  // clear the last keystroke          
				End if 
				
			: ((($Ascii>31) & ($Ascii<35)) | ($Ascii>39))  //  if is an appropriate character
				If (vtKeystroke_Filter#"")  // if a filter array was given
					If (ST_FindChar (vtKeystroke_Filter;Keystroke:C390)=-1)  // if Keystroke was not in filter array
						$1->:=Insert string:C231($1->;Keystroke:C390;$start)
					Else 
						FILTER KEYSTROKE:C389("")  // clear the last keystroke
					End if 
				Else 
					$length:=$end-$start  // get the number of characters highlighted
					  //If ($length>=Length($1->)
					  //$1->:=""
					  //End if 
					  //$1->:=Substring($1->;1;$start)+Keystroke
					If ($length>0)
						$1->:=Delete string:C232($1->;$start;$length)  // delete highlighted characters
					End if 
					If ($end>$start)
						$1->:=Insert string:C231($1->;Keystroke:C390;$start)
					Else 
						$1->:=Insert string:C231($1->;Keystroke:C390;$start+1)
					End if 
				End if 
		End case 
		
		  // $length:=Length($1->)
		  //    If (($length>0) & (($Ascii # Backspace Key) & ($Ascii # DEL ASCII code)))
		  //      $element:=Find in array($2->;$1->+"@")
		  //      If ($element # -1)
		  //          `$vpCurObj:=Last object
		  //        $1->:=$2->{$element}
		  //        FILTER KEYSTROKE("")  ` remove the last keystroke
		  //        $start:=$length+1
		  //        $end:=Length($1->)+1
		  //        HIGHLIGHT TEXT($1->;$start;$end)
		  //      Else 
		  //        HIGHLIGHT TEXT($1->;$length+1;$length+1)
		  //      End if 
		  //    End if  
		
		FILTER KEYSTROKE:C389("")  // remove the last keystroke
End case 