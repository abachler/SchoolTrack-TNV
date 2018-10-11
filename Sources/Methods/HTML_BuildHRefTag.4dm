//%attributes = {}
  //HTML_BuildHRefTag

$hRef:=$1
$text:=$2
$size:=2
$style:=""
$color:=""
$font:=""
$mouseOver:=""

Case of 
	: (Count parameters:C259=3)
		$size:=$3
	: (Count parameters:C259=4)
		$size:=$3
		$style:=$4
	: (Count parameters:C259=5)
		$size:=$3
		$style:=$4
		$color:=$5
	: (Count parameters:C259=6)
		$size:=3
		$style:=$4
		$color:=$5
		$font:=$6
	: (Count parameters:C259=7)
		$size:=$3
		$style:=$4
		$color:=$5
		$font:=$6
		$mouseOver:=$7
End case 

$hrefResult:="<a HREF="+ST_Qte ($hRef)
If ($mouseOver#"")
	$hRefResult:=$hrefResult+" "+HTML_mseOver ($mouseOver)+">"
Else 
	$hRefResult:=$hrefResult+" "+HTML_mseOver ($text)+">"
End if 
$hRefResult:=$hrefResult+HTML_Style ($text;$size;$style;$color;$font)+"</a>"

$0:=$hRefResult
