$selectedIndexEvent:=Find in array:C230(lbEventos;True:C214)
$count:=Count in array:C907(lbRegistros;True:C214)
If ($count=1)
	$selectedIndex:=Find in array:C230(lbRegistros;True:C214)
	$string2hash:=<>gRolBD+"."+<>vtXS_CountryCode+"."+atQR_SNEnviosIDEvento{$selectedIndexEvent}+"."+String:C10(alQR_SNEnviosIDRegistros{$selectedIndex})
	$err:=PHP Execute:C1058("";"hash";$res;"sha1";$string2hash)
	$string2hash:=$res+"."+[xShell_Reports:54]UUID:47
	$err:=PHP Execute:C1058("";"hash";$res;"sha1";$string2hash)
	$url:=atQR_SNEnviosLinkDownload{$selectedIndex}+"&llave="+$res
	OPEN URL:C673($url)
Else 
	For ($i;1;Size of array:C274(lbRegistros))
		If (lbRegistros{$i})
			$string2hash:=<>gRolBD+"."+<>vtXS_CountryCode+"."+atQR_SNEnviosIDEvento{$selectedIndexEvent}+"."+String:C10(alQR_SNEnviosIDRegistros{$i})
			$err:=PHP Execute:C1058("";"hash";$res;"sha1";$string2hash)
			$string2hash:=$res+"."+[xShell_Reports:54]UUID:47
			$err:=PHP Execute:C1058("";"hash";$res;"sha1";$string2hash)
			$url:=atQR_SNEnviosLinkDownload{$i}+"&llave="+$res
			OPEN URL:C673($url)
		End if 
	End for 
End if 