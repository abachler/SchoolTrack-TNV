If (SYS_IsWindows )
	  // abrir el PDF
	$t_ruta:=Get 4D folder:C485(Current resources folder:K5:16)+"Help Docs"+Folder separator:K24:12+"instructivo_ssl.pdf"
	OPEN URL:C673($t_ruta;*)
Else 
	WEB_GenerateCSR 
End if 