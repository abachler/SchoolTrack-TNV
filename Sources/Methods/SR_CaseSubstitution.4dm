//%attributes = {}
$script:=$1



If (Position:C15("Case Of";$script)>0)
	$script:=Replace string:C233($script;"\r"+Char:C90(10);"\r")
	$script:=Replace string:C233($script;": (";":(")
	
	ARRAY TEXT:C222($aTextArray;0)
	ARRAY TEXT:C222($aNewTextArray;0)
	AT_Text2Array (->$aTextArray;$script;"\r")
	For ($i;Size of array:C274($aTextArray);1;-1)
		If ($aTextArray{$i}="")
			DELETE FROM ARRAY:C228($aTextArray;$i)
		Else 
			$aTextArray{$i}:=ST_TrimLeadingChars ($aTextArray{$i};" ")
		End if 
	End for 
	
	$caseCount:=1
	$endCaseFound:=0
	$caseStartAT:=Find in array:C230($aTextArray;"@Case of@")
	If ($caseStartAT>0)
		For ($i;$caseStartAT+1;Size of array:C274($aTextArray))
			Case of 
				: ($aTextArray{$i}="@Case Of@")
					$caseCount:=$caseCount+1
				: ($aTextArray{$i}="@End Case@")
					$endCaseFound:=$endCaseFound+1
					If ($endCaseFound=$caseCount)
						$caseEndAt:=$i
						$i:=Size of array:C274($aTextArray)
					End if 
			End case 
		End for 
	End if 
	
	
	  //$caseEndAt:=Find in array($aTextArray;"@End Case@";$caseStartAT)
	$endIfCount:=0
	For ($i;1;$caseStartAT-1)
		APPEND TO ARRAY:C911($aNewTextArray;$aTextArray{$i})
	End for 
	
	$recallCaseSubstitution:=False:C215
	  //While ($caseStartAT>0)
	For ($i;$caseStartAT+1;$caseEndAt-1)
		Case of 
			: ($aTextArray{$i}="@Case of@")  //case in case
				$recallCaseSubstitution:=True:C214
				While ($aTextArray{$i}#"@End Case@")
					APPEND TO ARRAY:C911($aNewTextArray;$aTextArray{$i})
					$i:=$i+1
				End while 
				
			: (($aTextArray{$i}="@:(@") & ($i<($caseEndAt-1)))
				$if:=ST_ClearSpaces (Replace string:C233($aTextArray{$i};":(";"If("))
				APPEND TO ARRAY:C911($aNewTextArray;ST_TrimLeadingChars ($if;" "))
				$endIfCount:=$endIfCount+1
				If ($i<($caseEndAt-1))
					$i:=$i+1
					$stop:=False:C215
					$dontAddElse:=False:C215
					While (($aTextArray{$i}#"@:(@") & ($stop=False:C215))
						If ($aTextArray{$i}="@Case of@")
							$recallCaseSubstitution:=True:C214
							While ($aTextArray{$i}#"@End Case@")
								If ($aTextArray{$i}="@Else@")
									$dontAddElse:=True:C214
								End if 
								APPEND TO ARRAY:C911($aNewTextArray;ST_TrimLeadingChars ($aTextArray{$i};" "))
								$i:=$i+1
							End while 
							If (Not:C34($dontAddElse))
								APPEND TO ARRAY:C911($aNewTextArray;"Else")
							End if 
						Else 
							If ($aTextArray{$i}="@Else@")
								$dontAddElse:=True:C214
							End if 
							APPEND TO ARRAY:C911($aNewTextArray;ST_TrimLeadingChars ($aTextArray{$i};" "))
							If ($i<($caseEndAt-1))
								$i:=$i+1
							Else 
								$stop:=True:C214
							End if 
						End if 
					End while 
					If (Not:C34($dontAddElse))
						APPEND TO ARRAY:C911($aNewTextArray;"Else")
					End if 
					
					$i:=$i-1
				Else 
					APPEND TO ARRAY:C911($aNewTextArray;"Else")
					$endIfCount:=$endIfCount+1
				End if 
		End case 
	End for 
	For ($i;1;$endIfCount)
		APPEND TO ARRAY:C911($aNewTextArray;"End If")
	End for 
	
	For ($i;$caseEndAt+1;Size of array:C274($aTextArray))
		APPEND TO ARRAY:C911($aNewTextArray;$aTextArray{$i})
	End for 
	
	$ifCount:=0
	For ($i;1;Size of array:C274($aNewTextArray))
		If ($aNewTextArray{$i}="If@")
			$ifCount:=$ifCount+1
		End if 
	End for 
	
	$endIfCount:=0
	For ($i;1;Size of array:C274($aNewTextArray))
		If ($aNewTextArray{$i}="End If@")
			$endIfCount:=$endIfCount+1
		End if 
	End for 
	
	While ($endIfCount>$ifCount)
		DELETE FROM ARRAY:C228($aNewTextArray;Size of array:C274($aNewTextArray))
		$endIfCount:=$endIfCount-1
	End while 
	
	While ($ifCount>$endIfCount)
		APPEND TO ARRAY:C911($aNewTextArray;"End If")
		$endIfCount:=$endIfCount+1
	End while 
	
	  //$caseStartAT:=Find in array($aTextArray;"@Case of";$caseEndAt)
	  //$caseEndAt:=Find in array($aTextArray;"@End Case";$caseStartAT)
	  //End while 
	
	$script:=AT_array2text (->$aNewTextArray;"\r")
	$script:=Replace string:C233($script;"Else\rElse";"Else")
	
	While (Position:C15("Case Of";$script)>0)
		$script:=SR_CaseSubstitution ($script)
	End while 
	
	  //SET TEXT TO PASTEBOARD($script)
	
End if 
$0:=$script


