//%attributes = {}
  // UTIL_Instala_Win2PDF()
  //
  //
  // creado por: Alberto Bachler Klein: 29-12-16, 11:22:53
  // -----------------------------------------------------------

C_BOOLEAN:C305($b_PDF_OK;$b_instalar)
C_LONGINT:C283($l_impresora;$l_resultado)
C_TEXT:C284($t_comando;$t_error;$t_errStream;$t_in;$t_out;$t_rutaInstalador;$t_rutaLocal;$t_ValorLlave)

ARRAY TEXT:C222($at_impresoras;0)


  // obtengo la ruta del instalador
$t_rutaInstalador:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+SYS_FolderDelimiterOnServer +"w2pdf_schooltrack.exe"

If (Application type:C494=4D Remote mode:K5:5)
	  // si es una aplicación cliente copio el archivo instalador a la carpeta temporal local
	$t_rutaLocal:=Temporary folder:C486+"w2pdf_schooltrack.exe"
	$t_error:=KRL_CopyFileFromServer ($t_rutaInstalador;$t_rutaLocal)
	$t_rutaInstalador:=$t_rutaLocal
Else 
	$t_error:=Choose:C955(Test path name:C476($t_rutaInstalador)=Is a document:K24:1;"";"ERROR")
End if 

If ($t_error="")
	$t_comando:=$t_rutaInstalador+" /VERYSILENT /NORESTART"
	$l_proceso:=IT_UThermometer (1;0;__ ("Instalando PDFCreator…"))
	LAUNCH EXTERNAL PROCESS:C811($t_comando;$t_in;$t_out;$t_errStream)
	$l_proceso:=IT_UThermometer (-2;$l_proceso)
	
	PRINTERS LIST:C789($at_impresoras)
	If ((Find in array:C230($at_impresoras;"Win2PDF")>0))
		$b_PDF_OK:=True:C214
		$t_mensaje:=__ ("Win2PDF fue instalado exitosamente en este computador")
		PREF_Set (USR_GetUserID ;"OmitirInstalacionDriverPDF";"No")
	Else 
		$t_mensaje:=__ ("No fue posible instalar Win2PDF en este computador")
	End if 
End if 
Notificacion_Mostrar (__ ("Instalación de Win2PDF");$t_mensaje)
LOG_RegisterEvt ($t_mensaje)

If ($b_PDF_OK)  //la instalación fue exitosa, reestablezco la preferencia a su valor por defecto en caso de que la impresora pdf deje de estar disponible
	PREF_Set (USR_GetUserID ;"OmitirInstalacionDriverPDF";"No")
End if 

$0:=$b_PDF_OK