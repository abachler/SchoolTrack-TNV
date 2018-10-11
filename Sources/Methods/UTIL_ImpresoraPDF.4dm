//%attributes = {}
  // UTIL_ImpresoraPDF()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-16, 14:49:10
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_instalacionSilente;$b_installPDFdriver;$b_licenciado;$b_mostrar;$b_omitirPref;$b_PDF_OK;$b_visible)
C_LONGINT:C283($l_numeroUnicoProceso;$l_estadoProceso;$l_is64BitSystem;$l_opcion;$l_origenProceso;$l_ticksEjecucionProceso)
C_POINTER:C301($y_nombreImpresora)
C_TEXT:C284($t_driver1;$t_driver2;$t_impresora;$t_mensaje;$t_nombreProceso;$t_subKey;$t_subKeyPro;$t_ValorLlave)

ARRAY TEXT:C222($at_impresoras;0)


If (False:C215)
	C_BOOLEAN:C305(UTIL_ImpresoraPDF ;$0)
End if 

Case of 
	: (Count parameters:C259=2)
		$y_nombreImpresora:=$1
		$b_omitirPref:=$2
		
	: (Count parameters:C259=1)
		$y_nombreImpresora:=$1
End case 

$b_instalacionSilente:=((Current process name:C1392="End of the day tasks") | (Application type:C494=4D Server:K5:6) | (Current process name:C1392="Batch Task Procesor"))

PRINTERS LIST:C789($at_impresoras)

Case of 
	: (SYS_IsMacintosh )
		  // se usa la herramienta de impresión de pdf integrada en el OS
		$b_PDF_OK:=True:C214
		
	: (Find in array:C230($at_impresoras;"Microsoft Print to PDF")>0)
		  // si es Windows 10 o el driver nativo de windows esta disponible, se usa el driver nativo
		$t_impresora:="Microsoft Print to PDF"
		$b_PDF_OK:=True:C214
		
	: (Find in array:C230($at_impresoras;"Microsoft XPS Document Writer")>0)
		  // se agrega caso para herramienta nativa desde Windows 7 a 8.1
		$t_impresora:="Microsoft XPS Document Writer"
		$b_PDF_OK:=True:C214
		
	: (Find in array:C230($at_impresoras;"Win2Pdf")>0)
		  // si Win2Pdf esta instalado y licenciado, se usa Win2PDF, si no está instalado se instala
		$t_subKey:="Software\\Dane Prairie Systems\\Win2PDF"
		$t_subKeyPro:="Software\\Dane Prairie Systems\\Win2PDF Pro"
		$l_is64BitSystem:=Num:C11(<>sys_is64bitOS_B)
		$b_licenciado:=(sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$t_subKey;"newkey";$t_ValorLlave;$l_is64BitSystem)=1)
		$b_licenciado:=$b_licenciado | (sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$t_subKeyPro;"newkey";$t_ValorLlave;$l_is64BitSystem)=1)
		$b_licenciado:=$b_licenciado | (sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$t_subKey;"appkey";$t_ValorLlave;$l_is64BitSystem)=1)
		$b_licenciado:=$b_licenciado | (sys_GetRegText (GR_HKEY_LOCAL_MACHINE;$t_subKeyPro;"appkey";$t_ValorLlave;$l_is64BitSystem)=1)
		$b_installPDFdriver:=Not:C34($b_licenciado)
		$t_impresora:="Win2Pdf"
		  // 20180123 Patricio Aliaga Modificacion 1 de 1 ticket N° 195176 
		$b_PDF_OK:=$b_licenciado
		
		
	: (Find in array:C230($at_impresoras;"PDFCreator")>0)
		$t_impresora:=PDFCreator Printer name:K47:13
		$b_PDF_OK:=True:C214
		
	Else 
		$b_installPDFdriver:=True:C214
End case 

PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estadoProceso;$l_ticksEjecucionProceso;$b_visible;$l_numeroUnicoProceso;$l_origenProceso)
Case of 
	: ((Application type:C494#4D Remote mode:K5:5) & (SYS_IsServerRunningAsWINService ))  //4D server o local corriendo como servicio
		$b_installPDFdriver:=False:C215
		
	: ((Application type:C494#4D Remote mode:K5:5) & ($l_origenProceso=Web server process:K36:18))  // proceso web corriendo en el servidor
		$b_installPDFdriver:=False:C215
		
	: ((Application type:C494=4D Remote mode:K5:5) & ($l_origenProceso=Web process on 4D remote:K36:17))  // proceso web corriendo en un cliente
		$b_installPDFdriver:=False:C215
		
	: ((Application type:C494#4D Remote mode:K5:5) & ($l_origenProceso#None:K36:11))
		  // debiera ser el proceso principal, el instalador se puede ejecutar
		
	: ($l_origenProceso=Main process:K36:10)
		  // debiera ser el proceso principal, el instalador se puede ejecutar
End case 



If (($b_installPDFdriver) & (Not:C34(KRL_IsWebProcess )))
	$t_driver1:="Win2PDF"
	$t_driver2:="PDFCreator 1.7.3"
	IT_SetTextStyle_Bold (->$t_driver1)
	$t_driver2:=IT_SetTextStyle_Bold (->$t_driver2)+__ (" (libre)")
	If (($t_impresora="Win2Pdf") & ($b_licenciado=False:C215))
		$t_mensaje:=__ ("En este computador está instalada un versión no licenciada de la herramienta de impresión Win2PDF.\rSchooltrack integra una versión licenciada de ^1.\r\rPuede instalar la version integrada o bien instalar ^2.")
	Else 
		$t_mensaje:=__ ("Su sistema operativo requiere la instalación de una herramienta para imprimir documentos PDF\r\rSi planea imprimir documentos PDF recomendamos instalar esta herramienta ahora.\r\rPuede instalar la version integrada o bien instalar ^2.")
	End if 
	$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_driver1)
	$t_mensaje:=Replace string:C233($t_mensaje;"^2";$t_driver2)
	
	$b_mostrar:=(PREF_fGet (USR_GetUserID ;"OmitirInstalacionDriverPDF";"No")="No")
	If ($b_mostrar | $b_omitirPref)
		$l_opcion:=ModernUI_Notificacion (__ ("Instalación de herramienta de impresión PDF");$t_mensaje;"Instalar Win2PDF";"Instalar PDF Creator";"Cancelar";True:C214;True:C214)
		If (vl_noRepetirNotificacion=1)
			PREF_Set (USR_GetUserID ;"OmitirInstalacionDriverPDF";"Si")
		End if 
		Case of 
			: ($l_opcion=1)
				$b_PDF_OK:=UTIL_Instala_Win2PDF 
			: ($l_opcion=2)
				$b_PDF_OK:=UTIL_Instala_PDFcreator 
		End case 
	End if 
	
	
End if 

If (Not:C34(Is nil pointer:C315($y_nombreImpresora)))
	$y_nombreImpresora->:=$t_impresora
End if 



$0:=$b_PDF_OK


