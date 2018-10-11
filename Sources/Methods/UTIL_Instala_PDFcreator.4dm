//%attributes = {}
  // UTIL_Instala_PDFcreator()
  //
  //
  // creado por: Alberto Bachler Klein: 29-12-16, 11:23:15
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_PDF_OK)
C_LONGINT:C283($l_proceso)
C_TEXT:C284($t_comando;$t_error;$t_errStream;$t_in;$t_mensaje;$t_out;$t_rutaInstalador;$t_rutaLocal)

ARRAY TEXT:C222($at_impresoras;0)



If (False:C215)
	C_BOOLEAN:C305(UTIL_Instala_PDFcreator ;$0)
End if 

  // obtengo la ruta del instalador
$t_rutaInstalador:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+SYS_FolderDelimiterOnServer +"PDFCreator-1_7_3_setup.exe"

If (Application type:C494=4D Remote mode:K5:5)
	  // si es una aplicación cliente copio el archivo instalador a la carpeta temporal local
	$t_rutaLocal:=Temporary folder:C486+"PDFCreator-1_7_3_setup.exe"
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
	
	If ((Find in array:C230($at_impresoras;"PDFCreator")>0))
		$b_PDF_OK:=True:C214
		$t_mensaje:=__ ("PDF Creator fue instalado exitosamente en este computador")
	Else 
		$t_mensaje:=__ ("No fue posible instalar PDF Creator en este computador")
	End if 
End if 

Notificacion_Mostrar (__ ("Instalación de PDF Creator");$t_mensaje)
LOG_RegisterEvt ($t_mensaje)

$0:=$b_PDF_OK


