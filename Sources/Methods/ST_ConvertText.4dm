//%attributes = {}
  //ST_ConvertText

C_TEXT:C284($text;$0;$1)
$text:=$1
$0:=$text
_O_PLATFORM PROPERTIES:C365($platForm)
Case of 
	: (Count parameters:C259=1)
		If ($platForm=Windows:K25:3)
			$text:=_O_Mac to Win:C463($text)
		Else 
			$0:=$text
		End if 
	: (Count parameters:C259=3)
		$source:=$2
		$destination:=$3
		Case of 
			: (($source="Mac") & ($destination="Win"))
				$text:=_O_Mac to Win:C463($text)
			: (($source="Win") & ($destination="Mac"))
				$text:=_O_Win to Mac:C464($text)
			: (($source="Mac") & ($destination="ISO"))
				$text:=_O_Mac to ISO:C519($text)
			: (($source="ISO") & ($destination="Mac"))
				$text:=_O_ISO to Mac:C520($text)
		End case 
		$0:=$text
End case 
