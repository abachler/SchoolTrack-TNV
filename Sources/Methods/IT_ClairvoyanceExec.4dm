//%attributes = {}
  //IT_ClairvoyanceExec


  //DECLARATIONS
C_POINTER:C301($1)
C_TEXT:C284($2;$3)

  //INITIALIZATION

  //MAIN CODE
$event:=Form event:C388
MESSAGES OFF:C175
Case of 
	: ($event=On Getting Focus:K2:7)
		vtKeystroke_Filter:=""  // clear filter   
		vl_Milliseconds:=Milliseconds:C459
		$type:=Type:C295($1->)
		Case of 
			: (($type=0) | ($type=2) | ($type=24))  // if alpha or text
				If (Count parameters:C259=3)  // if a filter was given
					vtKeystroke_Filter:=$3
				End if 
			: (($type=1) | ($type=4) | ($type=8) | ($type=9) | ($type=11))  // if numeric, time or date
				If (Count parameters:C259=3)  // if a filter was given
					vtKeystroke_Filter:=$3
				End if 
		End case 
		
	: ($event=On Before Keystroke:K2:6)
		If ((Macintosh command down:C546) | (Windows Ctrl down:C562))
			FILTER EVENT:C321
			  //FILTER KEYSTROKE("")
		Else 
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
						HIGHLIGHT TEXT:C210($1->;$start;$start)
					End if 
				End if 
			End if 
			
			Case of 
				: (($Ascii=Backspace key:K12:29) | ($Ascii=DEL ASCII code:K15:34))
					If ($AcceptEvent)
						If (($length=0) & ($start>1))  //  if no characters are highlighted & if not at left most position
							If (Length:C16($1->)>0)  // if there are any characters to delete
								$1->:=Delete string:C232($1->;$start-1;1)  // remove the character
								HIGHLIGHT TEXT:C210($1->;$start-1;$start-1)
							End if 
						End if 
					Else   // $AcceptEvent
						FILTER KEYSTROKE:C389("")  // clear the last keystroke          
					End if 
					
				: ((($Ascii>31) & ($Ascii<35)) | ($Ascii>39))  //  if is an appropriate character
					If (vtKeystroke_Filter#"")  // if a filter array was given
						If (ST_FindChar (vtKeystroke_Filter;Keystroke:C390)=-1)  // if Keystroke was not in filter array
							$1->:=Insert string:C231($1->;Keystroke:C390;$start)
							HIGHLIGHT TEXT:C210($1->;$start+1;$start+1)
						Else 
							FILTER KEYSTROKE:C389("")  // clear the last keystroke
						End if 
					Else 
						$length:=$end-$start  // get the number of characters highlighted
						If ($length>0)
							$1->:=Delete string:C232($1->;$start;$length)  // delete highlighted characters
							HIGHLIGHT TEXT:C210($1->;$start-1;$start-1)
						End if 
						If ($end>$start)
							$1->:=Insert string:C231($1->;Keystroke:C390;$start)
							HIGHLIGHT TEXT:C210($1->;$start+1;$start+1)
						Else 
							If ($end<Length:C16($1->))
								$1->:=Insert string:C231($1->;Keystroke:C390;$start)
								HIGHLIGHT TEXT:C210($1->;$start+1;$start+1)
							Else 
								$1->:=Insert string:C231($1->;Keystroke:C390;$start+1)
								HIGHLIGHT TEXT:C210($1->;$start+1;$start+1)
							End if 
						End if 
					End if 
				: ($Ascii=28)  //flecha atras
					$length:=$end-$start
					Case of 
						: ((Shift down:C543) & ((Macintosh command down:C546) | (Windows Ctrl down:C562)))
							$nextSpc:=Position:C15(" ";Substring:C12($1->;$start))
							If ($nextSpc#0)
								HIGHLIGHT TEXT:C210($1->;$start;$nextSpc-1)
							Else 
								HIGHLIGHT TEXT:C210($1->;$start;Length:C16($1->))
							End if 
						: (Shift down:C543)
							HIGHLIGHT TEXT:C210($1->;$start-1;$end)
						: ((Macintosh command down:C546) | (Windows Ctrl down:C562))
							$nextSpc:=Position:C15(" ";Substring:C12($1->;$start))
							If ($nextSpc#0)
								HIGHLIGHT TEXT:C210($1->;$nextSpc-1;$nextSpc-1)
							Else 
								HIGHLIGHT TEXT:C210($1->;Length:C16($1->);Length:C16($1->))
							End if 
						Else 
							If ($length>0)
								HIGHLIGHT TEXT:C210($1->;$start;$start)
							Else 
								HIGHLIGHT TEXT:C210($1->;$start-1;$start-1)
							End if 
					End case 
				: ($Ascii=29)
					$length:=$end-$start
					Case of 
						: ((Shift down:C543) & ((Macintosh command down:C546) | (Windows Ctrl down:C562)))
							$nextSpc:=0
							$counter:=$start-1
							While ($nextSpc=0)
								If ($counter>1)
									If ($1->[[$counter]]=" ")
										$nextSpc:=$counter
									Else 
										$counter:=$counter-1
									End if 
								Else 
									$nextSpc:=-1
								End if 
							End while 
							If ($nextSpc#-1)
								HIGHLIGHT TEXT:C210($1->;$nextSpc-1;$start)
							Else 
								HIGHLIGHT TEXT:C210($1->;1;$start)
							End if 
						: (Shift down:C543)
							HIGHLIGHT TEXT:C210($1->;$start;$end+1)
						: ((Macintosh command down:C546) | (Windows Ctrl down:C562))
							$nextSpc:=0
							$counter:=$start-1
							While ($nextSpc=0)
								If ($counter>1)
									If ($1->[[$counter]]=" ")
										$nextSpc:=$counter
									Else 
										$counter:=$counter-1
									End if 
								Else 
									$nextSpc:=-1
								End if 
							End while 
							If ($nextSpc#-1)
								HIGHLIGHT TEXT:C210($1->;$nextSpc-1;$nextSpc-1)
							Else 
								HIGHLIGHT TEXT:C210($1->;1;1)
							End if 
						Else 
							If ($length>0)
								HIGHLIGHT TEXT:C210($1->;$end;$end)
							Else 
								HIGHLIGHT TEXT:C210($1->;$end+1;$end+1)
							End if 
					End case 
					
			End case 
			EXECUTE FORMULA:C63($2)
			FILTER KEYSTROKE:C389("")  // remove the last keystroke
		End if 
	: (($event=On Losing Focus:K2:8) | ($event=On Data Change:K2:15))
		GET HIGHLIGHT:C209($1->;$start;$end)
		If ($start>0)
			$1->:=Substring:C12($1->;1;$end)
		End if 
End case 