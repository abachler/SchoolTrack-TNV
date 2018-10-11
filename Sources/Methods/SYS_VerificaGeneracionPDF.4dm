//%attributes = {}
  //SYS_VerificaGeneracionPDF
C_BOOLEAN:C305($0;$go)
$go:=True:C214
If (SYS_IsWindows )
	ACTcfg_LoadPrinters 
	  //If (Application version<"13@")
	$l_pdf:=Find in array:C230(atACT_SystemPrinters;"Win2PDF@")
	If ($l_pdf#-1)
		$err:=sys_GetDefPrinter ($t_currPrinter)
		$err:=sys_SetDefPrinter (atACT_SystemPrinters{$l_pdf})
	Else 
		CD_Dlog (0;__ ("AccountTrack funciona con la impresora PDF WIN2PDF. Por favor instale dicha impresora e intente el envío a continuación."+"\r\r"+"Puede descargar el instalador desde ftp.colegium.com"))
		$go:=False:C215
	End if 
End if 

$0:=$go