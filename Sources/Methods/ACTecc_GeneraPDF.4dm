//%attributes = {}
  //ACTecc_GeneraPDF

ARRAY TEXT:C222(aDeletedNames;0)
ARRAY TEXT:C222(aMotivo;0)
C_BOOLEAN:C305($b_licenciaSNT)
ARRAY TEXT:C222($at_rutaDocumentos;0)
C_LONGINT:C283($l_idApdo)

C_TEXT:C284($t_nombreAC)
C_REAL:C285($r_idAC)


If (ACT_VerificaInicioProceso (__ ("Si continúa con el proceso se enviarán correos electrónicos a los apoderados.")))
	
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([xShell_Reports:54])
	
	$y_idsApoderados:=$1
	$r_reportRecNum:=$2
	
	If ($r_reportRecNum>No current record:K29:2)
		TRACE:C157  //probar
		
		ARRAY LONGINT:C221($alSelection;0)
		For ($i;1;Size of array:C274($y_idsApoderados->))
			$l_idApdo:=$y_idsApoderados->{$i}
			APPEND TO ARRAY:C911($alSelection;KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo))
		End for 
		CREATE SELECTION FROM ARRAY:C640([Personas:7];$alSelection;"")
		  //COPY NAMED SELECTION([Personas];"<>Editions")
		CUT NAMED SELECTION:C334([Personas:7];"<>Editions")  //20170315 RCH La selección se crea con CUT
		
		$t_rutaCartasCobranza:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"+SYS_FolderDelimiterOnServer +"CartasCobranzaPDF"+SYS_FolderDelimiterOnServer 
		$t_rutaCartasCobranzaSNT:=SYS_CarpetaAplicacion (CLG_Intercambios_ACT)+"CartasCobranzaPDF4SN"+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpetaServidor ($t_rutaCartasCobranza)
		SYS_CreaCarpetaServidor ($t_rutaCartasCobranzaSNT)
		
		If (Application type:C494=4D Remote mode:K5:5)
			  // si estamos en una aplicación cliente la impresión se hace en la carpeta Temporal del OS
			$t_rutaCarpetaPDFs:=Temporary folder:C486+"CartasCobranzaPDF"
			
			  // Modificado por: Saúl Ponce (20-02-2017) - Ticket Nº 175361 Creación de la ubicación de las cartas de cobranza.
			  //SYS_CreaCarpeta ($t_rutaTemporal)
			SYS_CreaCarpeta ($t_rutaCarpetaPDFs)
		Else 
			  // si estamos en monousuario o servidor la impresión se hace directamente en la carpeta CartasCobranzaPDF
			$t_rutaCarpetaPDFs:=$t_rutaCartasCobranza
		End if 
		
		$t_destinoImpresion:="pdf"
		$t_expresionNombreDocumento:="string([Personas]No)"
		CLEAR VARIABLE:C89($at_rutaDocumentos)
		QR_ImprimeInformeSRP ($r_reportRecNum;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento;->$at_rutaDocumentos)  //20170224 RCH OJO QUE EL NOMBRE DEL ARCHIVO SE UTILIZA PARA IDENTIFICAR EL APODERADO
		  //CLEAR NAMED SELECTION("<>Editions")
		
		
		$b_licenciaSNT:=LICENCIA_esModuloAutorizado (1;SchoolNet)
		If (Application type:C494=4D Remote mode:K5:5)
			  // estamos en una aplicación cliente enviamos los documentos PDF a la carpeta CartasCobranzaPDF y copiamos a la carpeta /Intercambios/AccountTrack/CartasCobranzaPDF4SN
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando archivos al servidor…"))
			For ($i;1;Size of array:C274($at_rutaDocumentos))
				$t_nombreDocumento:=SYS_Path2FileName ($at_rutaDocumentos{$i})
				
				If (Test path name:C476($at_rutaDocumentos{$i})=Is a document:K24:1)
					$t_RutaCartaPDF:=$t_rutaCartasCobranza+$t_nombreDocumento
					$t_rutaCartaSN:=$t_rutaCartasCobranzaSNT+$t_nombreDocumento
					$t_error:=KRL_CopyFileToServer ($at_rutaDocumentos{$i};$t_RutaCartaPDF;True:C214)
					
					  // si hay licencia SN y se envían documentos a SNT
					  // copiamos a la carpeta /Intercambios/AccountTrack/CartasCobranzaPDF4SN
					If (($b_licenciaSNT) & (cs_ACTecc_PublicarSN=1) & ($t_error=""))  // si tiene licencia y el check esta marcado, se guarda en la carpeta...
						SYS_CopyFileOnServer ($t_RutaCartaPDF;$t_rutaCartaSN)
					End if 
					DELETE DOCUMENT:C159($at_rutaDocumentos{$i})  // eliminamos el documento temporal
					
				Else 
					$t_idAp:=ST_GetWord ($t_nombreDocumento;2;"_")
					$t_idAp:=ST_GetWord ($t_idAp;2;".")
					$l_idAp:=Num:C11($t_idAp)
					$t_msj:="La carta de cobranza en PDF, para el apoderado id: "+$t_idAp+", no pudo ser generada. Posiblemente el usuario de la máquina no tiene los permisos necesarios."
					LOG_RegisterEvt ($t_msj)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idAp)
					APPEND TO ARRAY:C911(aDeletedNames;[Personas:7]Apellidos_y_nombres:30)
					APPEND TO ARRAY:C911(aMotivo;$t_msj)
				End if 
				
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_rutaDocumentos))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
		Else 
			  // estamos en una aplicación local (mono o server), solo es necesario copiar el documento a la carpeta /Intercambios/AccountTrack/CartasCobranzaPDF4SN
			For ($i;1;Size of array:C274($at_rutaDocumentos))
				$t_rutaCartaSN:=$t_rutaCartasCobranzaSNT+SYS_Path2FileName ($at_rutaDocumentos{$i})
				
				If (Test path name:C476($at_rutaDocumentos{$i})=Is a document:K24:1)
					If (($b_licenciaSNT) & (cs_ACTecc_PublicarSN=1))  // si tiene licencia y el check esta marcado, se guarda en la carpeta...
						COPY DOCUMENT:C541($at_rutaDocumentos{$i};$t_rutaCartaSN;*)
					End if 
					
				Else 
					$t_idAp:=ST_GetWord ($t_nombreDocumento;2;"_")
					$t_idAp:=ST_GetWord ($t_idAp;2;".")
					$l_idAp:=Num:C11($t_idAp)
					$t_msj:="La carta de cobranza en PDF, para el poderado id: "+$t_idAp+", no pudo ser generada. Posiblemente el usuario de la máquina no tiene los permisos necesarios."
					LOG_RegisterEvt ($t_msj)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idAp)
					APPEND TO ARRAY:C911(aDeletedNames;[Personas:7]Apellidos_y_nombres:30)
					APPEND TO ARRAY:C911(aMotivo;$t_msj)
				End if 
			End for 
			
		End if 
		
		$t_nombreAC:=atACTecc_Informes{atACTecc_Informes}
		$r_idAC:=alACTecc_Informes{atACTecc_Informes}
		
		  //despues de generar los PDF se inicia el procesi que los envia desde el servidor...
		$p:=Execute on server:C373("ACTecc_EnviaEmail";256000;"Envio de Cartas de Cobranza";$t_nombreAC;$r_idAC)
		
		
		If (Size of array:C274(aDeletedNames)>0)
			vReportTitle:="Archivos PDF no generados"
			vBtnTitle:="Ok"
			vbACT_AllowGeneration:=False:C215
			vbACT_MostrarBoton:=False:C215
			vbACT_formPDFs:=True:C214
			SORT ARRAY:C229(aDeletedNames;aMotivo;>)
			WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;__ ("PDFs no generados"))
			DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
			CLOSE WINDOW:C154
			vbACT_formPDFs:=False:C215
		End if 
		
	End if 
End if 