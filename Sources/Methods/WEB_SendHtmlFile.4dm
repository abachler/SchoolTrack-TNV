//%attributes = {}
  //WEB_SendHtmlFile
C_BLOB:C604($x_blob;$x_blob2)
C_TEXT:C284($t_textoProcesado)



$document2Send:=$1
If (Count parameters:C259=2)
	$folderPath:=$2
Else 
	$folderPath:=Get 4D folder:C485(HTML Root folder:K5:20)
End if 


_O_PLATFORM PROPERTIES:C365($platForm)
If ($platForm=3)
	$pathSeparator:="\\"
Else 
	$pathSeparator:=":"
End if 

$document2Send:=Replace string:C233($folderPath+$document2Send;"/";$pathSeparator)
$fileExists:=Test path name:C476($document2Send)
If ($fileExists=1)
	DOCUMENT TO BLOB:C525($document2Send;$x_blob)
	PROCESS 4D TAGS:C816($x_blob;$x_blob2)
	$t_textoProcesado:=BLOB to text:C555($x_blob2;Mac text without length:K22:10)
	$t_textoProcesado:=HTML_reemplazaTildes ($t_textoProcesado)  //20160526 ASM Ticket 162046
	WEB SEND TEXT:C677($t_textoProcesado)
	
Else 
	vtSNET_ErrorMsg:="<P>"+HTML_Style ("La página solicitada no existe.";3;"B";"Red")+"</P>"
	vtSNET_ErrorMsg:=vtSNET_ErrorMsg+HTML_Style ("Vuelva atrás  usando el botón <B>Atrás</B> "+"de su navegador.";3)
	$document2Send:=$folderPath+$pathSeparator+"error.html"
	WEB SEND FILE:C619($document2Send)
End if 