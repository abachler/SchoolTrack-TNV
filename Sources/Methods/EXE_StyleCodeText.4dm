//%attributes = {}
$text:=$1

If ($text->#"")
	$text->:=Replace string:C233($text->;": (";":(")
	ARRAY TEXT:C222($estoyEn;0)
	ARRAY TEXT:C222($aLines;0)
	AT_Text2Array (->$aLines;$text->;"\r")
	For ($i;1;Size of array:C274($aLines))
		$aLines{$i}:=ST_TrimLeadingChars ($aLines{$i};" ")
		$aLines{$i}:=Replace string:C233($aLines{$i};"\t";"")
		If (Length:C16($aLines{$i})>0)
			While ($aLines{$i}[[Length:C16($aLines{$i})]]=" ")
				$aLines{$i}:=Substring:C12($aLines{$i};1;Length:C16($aLines{$i})-1)
			End while 
		End if 
	End for 
	$indent:=0
	$indentar:=False:C215
	$t:=$aLines{1}
	If (($t="if@") | ($t="for@") | ($t="Case of@") | ($t="While@") | ($t="Repeat@"))
		$indentar:=True:C214
		$indent:=4
		APPEND TO ARRAY:C911($estoyEn;$t)
	Else 
		If ($t="//@")
			$indent:=$indent+2
			$aLines{1}:=" "*$indent+$aLines{1}
			$indent:=$indent-2
		End if 
	End if 
	For ($i;2;Size of array:C274($aLines))
		$t:=ST_TrimLeadingChars ($aLines{$i};" ")
		$t:=Replace string:C233($aLines{$i};"\t";"")
		
		If (Length:C16($t)>0)
			While ($t[[Length:C16($t)]]=" ")
				$t:=Substring:C12($t;1;Length:C16($t)-1)
			End while 
		End if 
		Case of 
			: (($t="if@") | ($t="for@") | ($t="Case of@") | ($t="While@") | ($t="Repeat@"))
				If ($indentar)
					$aLines{$i}:=" "*$indent+$aLines{$i}
				End if 
				$indent:=$indent+4
				$indentar:=True:C214
				Case of 
					: ($t="if@")
						APPEND TO ARRAY:C911($estoyEn;"if")
					: ($t="for@")
						APPEND TO ARRAY:C911($estoyEn;"for")
					: ($t="Case of@")
						APPEND TO ARRAY:C911($estoyEn;"case of")
					: ($t="While@")
						APPEND TO ARRAY:C911($estoyEn;"while")
					: ($t="Repeat@")
						APPEND TO ARRAY:C911($estoyEn;"repeat")
				End case 
			: (($t="End If@") | ($t="End for@") | ($t="End Case@") | ($t="End While@") | ($t="Until@"))
				$indent:=$indent-4
				$aLines{$i}:=" "*$indent+$aLines{$i}
				Case of 
					: ($t="End if@")
						If ($estoyEn{Size of array:C274($estoyEn)}="if")
							DELETE FROM ARRAY:C228($estoyEn;Size of array:C274($estoyEn))
						End if 
					: ($t="End for@")
						If ($estoyEn{Size of array:C274($estoyEn)}="for")
							DELETE FROM ARRAY:C228($estoyEn;Size of array:C274($estoyEn))
						End if 
					: ($t="End Case@")
						If ($estoyEn{Size of array:C274($estoyEn)}="case of")
							DELETE FROM ARRAY:C228($estoyEn;Size of array:C274($estoyEn))
						End if 
					: ($t="End While@")
						If ($estoyEn{Size of array:C274($estoyEn)}="while")
							DELETE FROM ARRAY:C228($estoyEn;Size of array:C274($estoyEn))
						End if 
					: ($t="Until@")
						If ($estoyEn{Size of array:C274($estoyEn)}="repeat")
							DELETE FROM ARRAY:C228($estoyEn;Size of array:C274($estoyEn))
						End if 
				End case 
			: ($t="else@")
				If ($estoyEn{Size of array:C274($estoyEn)}="Case of")
					$indent:=$indent-2
					$aLines{$i}:=" "*$indent+$aLines{$i}
					$indent:=$indent+2
				Else 
					$indent:=$indent-4
					$aLines{$i}:=" "*$indent+$aLines{$i}
					$indent:=$indent+4
				End if 
			: (($t=": (@") | ($t=":(@"))
				If ($estoyEn{Size of array:C274($estoyEn)}="case of")
					$indent:=$indent-2
					$aLines{$i}:=" "*$indent+$aLines{$i}
					$indent:=$indent+2
				Else 
					$aLines{$i}:=" "*$indent+$aLines{$i}
				End if 
			: ($t="//@")
				$indent:=$indent+2
				$aLines{$i}:=" "*$indent+$aLines{$i}
				$indent:=$indent-2
			Else 
				$aLines{$i}:=" "*$indent+$aLines{$i}
		End case 
	End for 
	$text->:=AT_array2text (->$aLines;"\r")
End if 