//%attributes = {}
  //WDW_AdjustWinWidth2FormWidth

$customWidth:=0
$table:=$1
$formName:=$2
If (Count parameters:C259=3)
	$customWidth:=$3
End if 
GET WINDOW RECT:C443($left;$top;$right;$bottom)
If ($customWidth=0)
	FORM GET PROPERTIES:C674($table->;$formName;$width;$height)
	$width:=$left+$width
Else 
	$width:=$customWidth
End if 
Case of 
	: ($width<$right)
		For ($i;$right;$width;-10)
			If ($i<=$width)
				SET WINDOW RECT:C444($left;$top;$width;$bottom)
				$i:=$width
			Else 
				SET WINDOW RECT:C444($left;$top;$i;$bottom)
			End if 
		End for 
		SET WINDOW RECT:C444($left;$top;$width;$bottom)
	: ($width>$right)
		For ($i;$right;$width;10)
			If ($i>$width)
				SET WINDOW RECT:C444($left;$top;$width;$bottom)
				$i:=$width
			Else 
				SET WINDOW RECT:C444($left;$top;$i;$bottom)
			End if 
		End for 
		SET WINDOW RECT:C444($left;$top;$width;$bottom)
End case 