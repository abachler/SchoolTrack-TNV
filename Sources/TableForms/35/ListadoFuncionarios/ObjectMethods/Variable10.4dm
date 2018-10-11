READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
vLogo:=[xShell_ApplicationData:45]Logo:9
PICTURE PROPERTIES:C457(vLogo;$width;$height)
Case of 
	: (($height>113) & ($height>$width))
		$percent:=113/$height
		vLogo:=vLogo*$percent
	: (($width>113) & ($width>$height))
		$percent:=113/$width
		vLogo:=vLogo*$percent
End case 