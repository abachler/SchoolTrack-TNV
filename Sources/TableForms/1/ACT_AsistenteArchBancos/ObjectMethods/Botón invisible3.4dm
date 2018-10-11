$text:=AT_array2text (->atACT_ABArchivoNombreCUP)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vExportadorCUP:=atACT_ABArchivoNombreCUP{$choice}
	vlACT_ExportadorCUPID:=alACT_ABArchivoIDCUP{$choice}
End if 
$case1:=((cbPAT=1) & (vlACT_ExportadorPATID#0))
$case2:=((cbPAC=1) & (vlACT_ExportadorPACID#0))
$case3:=((cbCuponera=1) & (vlACT_ExportadorCUPID#0))
If (($case1) | ($case2) | ($case3))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 