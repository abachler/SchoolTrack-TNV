//%attributes = {}
  //WDW_AdjustWinHeight2FormHeight

$customHeight:=0
$table:=$1
$formName:=$2
If (Count parameters:C259=3)
	$customHeight:=$3
End if 
GET WINDOW RECT:C443($left;$top;$right;$bottom)
If ($customHeight=0)
	FORM GET PROPERTIES:C674($table->;$formName;$width;$height)
	$height:=$top+$height
Else 
	$height:=$customHeight
End if 
Case of 
	: ($height<$bottom)
		For ($i;$bottom;$height;-10)
			If ($i<=$height)
				SET WINDOW RECT:C444($left;$top;$right;$height)
				$i:=$height
			Else 
				SET WINDOW RECT:C444($left;$top;$right;$i)
			End if 
		End for 
		SET WINDOW RECT:C444($left;$top;$right;$height)
	: ($height>$bottom)
		For ($i;$bottom;$height;10)
			If ($i>$height)
				SET WINDOW RECT:C444($left;$top;$right;$height)
				$i:=$height
			Else 
				SET WINDOW RECT:C444($left;$top;$right;$i)
			End if 
		End for 
		SET WINDOW RECT:C444($left;$top;$right;$height)
End case 