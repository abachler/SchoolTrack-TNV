//%attributes = {}
  // BKP_RespaldaFotografias()
  // Por: Alberto Bachler K.: 06-09-14, 18:02:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

If (Application type:C494=4D Remote mode:K5:5)
	$l_idProceso:=Execute on server:C373(Current method name:C684;128000;Current method name:C684)
Else 
	$l_carpetaOrigen:=<>syT_ArchivosFolder+"Fotografías "+<>gCountryCode+" "+<>grolBD
	$t_hora:=Substring:C12(String:C10(Current time:C178(*);2);1;2)+Substring:C12(String:C10(Current time:C178(*);2);4;2)
	$t_fecha:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
	$t_carpetaRespaldo:=<>syT_ArchivosFolder+"Respaldo Fotografías "+<>gCountryCode+" "+<>grolBD+" - "+$t_fecha+$t_hora
	SYS_CopyFolder ($l_carpetaOrigen;$t_carpetaRespaldo)
End if 

