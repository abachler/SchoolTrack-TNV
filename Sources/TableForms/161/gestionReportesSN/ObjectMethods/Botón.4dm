  // [SN3_PublicationPrefs].gestionReportesSN.Botón()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-04-16, 11:54:52
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_registros)  //MONO 18-07-2018 Ticket 210195
C_BOOLEAN:C305($error)

ARRAY LONGINT:C221($alSelection;0)
ARRAY TEXT:C222($at_rutaDocumentosPdf;0)
ARRAY LONGINT:C221($al_recnumInformes;0)

For ($i;1;Size of array:C274(abQR_SNEnviar))
	If (abQR_SNEnviar{$i})
		APPEND TO ARRAY:C911($alSelection;alQR_SNRecNumsRegistros{$i})
	End if 
End for 
CREATE SELECTION FROM ARRAY:C640(vyQR_TablePointer->;$alSelection)
$l_registros:=Size of array:C274($alSelection)  //MONO 18-07-2018 Ticket 210195
COPY NAMED SELECTION:C331(vyQR_TablePointer->;"<>Editions")
$reportRecNum:=Record number:C243([xShell_Reports:54])
$printPreview:=False:C215
$t_rutaCarpetaPDF:=Temporary folder:C486+"4D"+Folder separator:K24:12+Generate UUID:C1066+Folder separator:K24:12
CREATE FOLDER:C475($t_rutaCarpetaPDF;*)
If (False:C215)
	SHOW ON DISK:C922($t_rutaCarpetaPDF)
End if 

$b_destinoSNT:=True:C214
If (vb_isReportFolder)
	GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
	OBJECT SET TITLE:C194(*;"informes";"Favoritos: "+$t_nombreCarpetaFavoritos)
	
	If (Is a list:C621(hl_Informes))
		CLEAR LIST:C377(hl_Informes)
	End if 
	
	hl_Informes:=New list:C375
	READ ONLY:C145([xShell_FavoriteReports:183])
	QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
	QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportParentListId:7=$l_idCarpetaFavoritos;*)
	QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
	QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=False:C215)
	KRL_RelateSelection (->[xShell_Reports:54]ID:7;->[xShell_FavoriteReports:183]ReportId:2)
	LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_recnumInformes;"")
	QR_imprimeSRP_PDFfolder ("pdf";->$al_recnumInformes;$t_rutaCarpetaPDF;->$at_rutaDocumentosPdf;$b_destinoSNT;False:C215)
Else 
	  //MONO 205388
	  //APPEND TO ARRAY($al_recnumInformes;$reportRecNum)
	  //QR_imprimeSRP_PDFfolder ("pdf";->$al_recnumInformes;$t_rutaCarpetaPDF;->$at_rutaDocumentosPdf;$b_destinoSNT;False)
	$l_registros:=QR_ImprimeInformeSRP ($reportRecNum;"pdf";$t_rutaCarpetaPDF;"";->$at_rutaDocumentosPdf;$b_destinoSNT;False:C215)  //MONO 18-07-2018 Ticket 210195
End if 

  //MONO: 215628
  //Con los PDF generados se procede a la compresión y envío al ftp de SN3
  //haré unos reintentos de la compresión y envío de los pdf, también agregué algunos mensajes si hay problemas

If (($l_registros>0) & ((Size of array:C274($at_rutaDocumentosPdf)>0)))  //MONO 18-07-2018 Ticket 210195
	
	$o_resp:=SN3_SendInformesPDF ($t_rutaCarpetaPDF;True:C214)
	$b_compresion:=OB Get:C1224($o_resp;"compresion")
	
	$l_try:=0
	While (Not:C34($b_compresion) & ($l_try<3))  //Intentos de compresión y envío
		$o_resp:=SN3_SendInformesPDF ($t_rutaCarpetaPDF;True:C214)
		$b_compresion:=OB Get:C1224($o_resp;"compresion")
		$l_try:=$l_try+1
	End while 
	
	$b_continuar:=False:C215
	
	If ($b_compresion)  //Compresión OK, entonces hay intento de conexión
		$t_archivoZip:=OB Get:C1224($o_resp;"archivoZip")
		$l_try:=0
		
		While ((Not:C34($b_continuar)) & ($l_try<3))
			
			$b_conexion:=OB Get:C1224($o_resp;"conexionFTP")
			If (Not:C34(OB Is defined:C1231($o_resp;"transferenciaFTP")))
				$b_transferencia:=False:C215
			Else 
				$b_transferencia:=OB Get:C1224($o_resp;"conexionFTP")
			End if 
			
			Case of 
				: (($b_conexion) & ($b_transferencia))
					$b_continuar:=True:C214
				: (Not:C34($b_conexion))
					$t_alerta:=__ ("No pudo conectar desde este equipo al FTP de Schoolnet.")
				: (Not:C34($b_transferencia))
					$t_errorTransf:=OB Get:C1224($o_resp;"transferenciaFTPError")
					$t_alerta:=__ ("No pudo transferir desde este equipo al FTP de Schoolnet, debido al siguiente error :\r - ^0";$t_errorTransf)
			End case 
			
			If (Not:C34($b_continuar))
				  //MONO: No voy a preguntar, solamente agotaré los intentos.
				  //$t_alerta:=$t_alerta+__ ("\t¿Desea intentar nuevamente conectar y transferir a Schoolnet?")
				  //$l_res:=CD_Dlog (0;$t_alerta;"Si";"No")
				
				  //If ($l_res=1)
				$o_resp:=SN3_SendInformesPDF ($t_rutaCarpetaPDF;False:C215;$t_archivoZip)
				  //Else 
				  //$l_try:=100
				  //$t_alerta:=__ ("Proceso de envio de informes fallido, usted a decidido no intentarlo nuevamente.\r Serán eliminados los archivos generados localmente.")
				  //End if 
			End if 
			
			$l_try:=$l_try+1
			If ($l_try=3)
				$t_alerta:=__ ("Proceso de envio de informes fallido, se han agotado los intentos de conexión y transferencia, intente mas tarde o intente desde otro equipo.\r Serán eliminados los archivos generados localmente.")
				SYS_DeleteFile ($t_archivoZip)
			End if 
		End while 
		
	Else 
		$t_alerta:=__ ("Problemas al comprimir informes para el envío a SchoolNet, por favor intente este proceso desde otro equipo, si el problema de compresión continúa contacte a la mesa de ayuda.")
		$b_continuar:=False:C215
	End if 
	
	If ($b_continuar)
		
		DOCUMENT LIST:C474($t_rutaCarpetaPDF;$at_documentos;Absolute path:K24:14+Ignore invisible:K24:16)
		SN3_SendInformesXML (->$at_documentos;vtQR_SNNombre;vdQR_SNDisponibleDesde;[xShell_Reports:54]UUID:47)
		
		If (Size of array:C274($at_rutaDocumentosPdf)#Size of array:C274($at_documentos))
			$linea:=""
			For ($i;1;Size of array:C274($at_rutaDocumentosPdf))
				If (Find in array:C230($at_documentos;$at_rutaDocumentosPdf{$i})=-1)
					$event:=$at_rutaDocumentosPdf{$i}
					$descriptor:=ST_GetWord ($event;2;"_")
					$alumnoid:=Num:C11(ST_GetWord ($descriptor;2;"."))
					$nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$alumnoid;->[Alumnos:2]apellidos_y_nombres:40)
					$cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$alumnoid;->[Alumnos:2]curso:20)
					$linea:=$linea+"\r"+$nombreAlumno+" ("+$cursoAlumno+")"
				End if 
			End for 
			
			If ($linea#"")
				CD_Dlog (0;__ ("El informe no pudo ser generado para los siguientes alumnos:")+"\r"+$linea)
			End if 
		End if 
		
		CD_Dlog (0;__ ("Tenga en cuenta que SchoolNet puede demorar en procesar estos archivos, por lo tanto, los informes no estarán disponibles en forma inmediata."))
	Else 
		CD_Dlog (0;$t_alerta)  //Compresión o Transferencia Fallida
	End if 
	
Else 
	  //MONO 18-07-2018 Ticket 210195
	CD_Dlog (0;__ ("No se generaron los archivos PDF por un problema en la impresión o fue cancelada, también la selección pudo quedar vacía por un filtro en el informe."))
End if 

SYS_DeleteFolder ($t_rutaCarpetaPDF)  //Eliminación de carpeta que contiene los pdf
CANCEL:C270