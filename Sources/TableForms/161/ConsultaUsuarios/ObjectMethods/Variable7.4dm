If (SN3_PasswordUsuarios>0)
	$login:=SN3_LoginUsuarios{SN3_LoginUsuarios}
	$pass:=SN3_PasswordUsuarios{SN3_PasswordUsuarios}
	$culture:="es_CL"
	If (($login#"") & ($pass#""))
		$path:=Temporary folder:C486+"SNOpener.html"
		SYS_DeleteFile ($path)
		$ref:=Create document:C266($path)
		If (ok=1)
			$text:="<head><meta http-equiv="+ST_Qte ("X-UA-Compatible")+"content="+ST_Qte ("IE=edge")+"</head><body>"
			$text:=$text+"<form style="+ST_Qte ("display:none")+" action="+ST_Qte ("https://schoolnet.colegium.com/es_CL/login/colegios/index")+" method="+ST_Qte ("post")+" name="+ST_Qte ("form")+" id="+ST_Qte ("form")+">"
			$text:=$text+"<input name="+ST_Qte ("vt_LoginName")+" type="+ST_Qte ("text")+" id="+ST_Qte ("vt_LoginName")+" value="+ST_Qte ($login)+"/>"
			$text:=$text+"<input name="+ST_Qte ("vt_password")+" type="+ST_Qte ("password")+" id="+ST_Qte ("vt_password")+" value="+ST_Qte ($pass)+"/>"
			$text:=$text+"<input name="+ST_Qte ("cultura")+" type="+ST_Qte ("text")+" id="+ST_Qte ("cultura")+" value="+ST_Qte ($culture)+"/>"
			$text:=$text+"</form>"
			$text:=$text+"<script type="+ST_Qte ("text/javascript")+">"
			$text:=$text+"document.form.submit();"
			$text:=$text+"</script>"
			$text:=$text+"</body>"
			IO_SendPacket ($ref;$text)
			CLOSE DOCUMENT:C267($ref)
			OPEN URL:C673($path)
			  //OPEN URL(vURL)
		End if 
	End if 
End if 