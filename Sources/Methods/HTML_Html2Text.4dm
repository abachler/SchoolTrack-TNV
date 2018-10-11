//%attributes = {}


C_TEXT:C284($t_HTMLContent;$1)



$t_HTMLContent:=$1
While (Position:C15("<";$t_HTMLContent)>0)
	$text:=Substring:C12($t_HTMLContent;1;Position:C15("<";$t_HTMLContent)-1)
	$t_HTMLContent:=Substring:C12($t_HTMLContent;Position:C15("<";$t_HTMLContent)+1)
	For ($i;1;Length:C16($t_HTMLContent))
		If ($t_HTMLContent[[$i]]=">")
			$position:=$i+1
			$i:=Length:C16($t_HTMLContent)+1
		End if 
	End for 
	$t_HTMLContent:=$text+Substring:C12($t_HTMLContent;$position)
End while 
$0:=$t_HTMLContent

$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&nbsp;";"")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&aacute;";"á")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&eacute;";"é")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&iacute;";"í")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&oacute;";"ó")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&uacute;";"ó")
$t_HTMLContent:=Replace string:C233($t_HTMLContent;"&ntilde;";"ñ")

$0:=$t_HTMLContent
