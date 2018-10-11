If (<>vtXS_CountryCode#"cl")
	$url:="www.colegium.com."+<>vtXS_CountryCode
Else 
	$url:="www.colegium.com"
End if 
OPEN URL:C673($url)
CANCEL:C270