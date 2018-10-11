  // Actualizacion11_9.compactar()
  // Por: Alberto Bachler K.: 07-07-14, 12:33:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_CompactacionNecesaria)
C_LONGINT:C283($i)
C_TIME:C306($h_RefDoc)
C_POINTER:C301($y_diferencia;$y_nombreTabla;$y_numeroTabla;$y_registrosAntes;$y_registrosDespues)
C_TEXT:C284($t_asunto;$t_copia;$t_copiaOculta;$t_Cuerpo;$t_destinatario;$t_docXLS;$t_dts;$t_Encabezados;$t_error;$t_fechaHora)
C_TEXT:C284($t_jsonPerdidaRegistros;$t_logFolder;$t_mensaje;$t_nombreArchivoDatos;$t_nombreEstructura;$t_refJson;$t_rutaArchivoOriginal;$t_rutaConteoDespues;$t_rutaLog;$t_Texto1)
C_TEXT:C284($t_texto2;$t_versionBaseDeDatos;$t_versionEstructura)

ARRAY TEXT:C222($at_adjuntos;0)

If (Application type:C494=4D Remote mode:K5:5)
	vt_client:=<>registeredName
	vl_ClientProgressProcessID:=IT_Progress (1;0;0;__ ("Verificando base de datos...");-5)
End if 

ARRAY TEXT:C222(at_DataFileError;0)

CIM_CuentaRegistros ("GuardaArchivo")
$b_noReiniciar:=True:C214
$t_rutaArchivoOriginal:=CIM_CompactDataFile ("";$b_noReiniciar)
$t_jsonPerdidaRegistros:=CIM_CuentaRegistros 


$t_nombreArchivoDatos:=SYS_GetServerProperty (XS_DataFileName)
$t_rutaArchivoOriginal:=$t_rutaArchivoOriginal+$t_nombreArchivoDatos
OBJECT SET TITLE:C194(*;"rutabdOriginal";$t_rutaArchivoOriginal)
OBJECT SET TITLE:C194(*;"rutabdCompactada";Data file:C490)
OBJECT SET TITLE:C194(*;"bRutabdOriginal";ST_GetWord ($t_rutaArchivoOriginal;ST_CountWords ($t_rutaArchivoOriginal;0;Folder separator:K24:12);Folder separator:K24:12))
OBJECT SET TITLE:C194(*;"bRutabdCompactada";ST_GetWord (Data file:C490;ST_CountWords (Data file:C490;0;Folder separator:K24:12);Folder separator:K24:12))


ARRAY TEXT:C222(at_FragmentacionTablas;0)
ARRAY REAL:C219(ar_FragmentacionPorcentaje;0)
ARRAY LONGINT:C221(al_FragmentacionColores;0)
If (Size of array:C274(at_DataFileError)=0)
	For ($i;1;Get last table number:C254)
		If (Is table number valid:C999($i))
			APPEND TO ARRAY:C911(at_FragmentacionTablas;Table name:C256($i))
			APPEND TO ARRAY:C911(ar_FragmentacionPorcentaje;Round:C94(Get table fragmentation:C1127(Table:C252($i)->);0))
			If (ar_FragmentacionPorcentaje{Size of array:C274(at_FragmentacionTablas)}>20)
				$b_CompactacionNecesaria:=True:C214
				APPEND TO ARRAY:C911(al_FragmentacionColores;0x00FF0000)
			Else 
				APPEND TO ARRAY:C911(al_FragmentacionColores;0)
			End if 
		End if 
	End for 
End if 

SORT ARRAY:C229(ar_FragmentacionPorcentaje;at_FragmentacionTablas;al_FragmentacionColores;<)


Case of 
	: ($t_rutaArchivoOriginal="")
		CD_Dlog (0;__ ("Se produjo un error al compactar la base de datos."))
		
	: (Size of array:C274(at_DataFileError)>0)
		$t_versionEstructura:=OBJECT Get title:C1068(*;"versionAplicacion")
		$t_versionBaseDeDatos:=OBJECT Get title:C1068(*;"versionBD")
		
		$t_Cuerpo:=__ ("La compactación de la base de datos previa a la actualización desde ^0 a ^1 no fue posible a causa de los siguientes errores ")+<>gCustom+": \r\r"
		$t_Cuerpo:=$t_Cuerpo+AT_array2text (->at_DataFileError;"\r")
		
		$t_Cuerpo:=$t_Cuerpo+__ ("Se adjunta el log de compactación de la base de datos")
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack del colegio en la ruta siguiente:\r")+Data file:C490+"\r\r"
		
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_versionBaseDeDatos)
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionEstructura)
		
		$t_logFolder:=Get 4D folder:C485(Logs folder:K5:19)
		$t_nombreEstructura:=SYS_GetServerProperty (XS_StructureName)
		Case of 
			: (SYS_GetServerProperty (XS_StructureName)="@.4DB")
				$t_nombreEstructura:=Replace string:C233($t_nombreEstructura;".4DB";"")
			: (SYS_GetServerProperty (XS_StructureName)="@.4DC")
				$t_nombreEstructura:=Replace string:C233($t_nombreEstructura;".4DC";"")
		End case 
		$t_rutaLog:=$t_logFolder+$t_nombreEstructura+"_Compact_Log.xml"
		APPEND TO ARRAY:C911($at_adjuntos;$t_rutaLog)
		$t_asunto:="Reporte de verificación de Base de datos"+<>gCustom
		$t_destinatario:="soporte@colegium.com"
		$t_copia:="qa@colegium.com"
		$t_copiaOculta:="abachler@colegium.com"
		
		$t_mensaje:=__ ("No fue posible compactar la base de datos.")+"\r"+__ ("Enviando informe a Colegium...")
		$t_Error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaOculta;->$at_adjuntos;$t_mensaje)
		
		
		If ($t_Error#"")
			ALERT:C41(__ ("No fue posible enviar el informe de errores de compactación:")+"\r\r"+$t_Error)
		Else 
			Notificacion_Mostrar ("Envio de informe a Colegium";"El informe de errores de compactación de la base de datos fue enviado a Colegium.")
		End if 
		
		
		If (Application type:C494=4D Server:K5:6)
			$t_Texto1:=__ ("Cierre esta ventana, abra el Centro de Seguridad y Mantenimiento desde el menú Ayuda, seleccione la opción REPARAR en la barra lateral izquierda y haga una REPARACIÓN ESTÁNDAR.")+"\r"+__ ("Una vez finalizada la reparación reinicie SchoolTrack.")+"\r"+__ ("Al reiniciar se verificará nuevamente la base de datos (en algunos casos puede ser necesario reparar la base de datos varias veces antes).")+"\r"+__ ("Mientras la base de datos no haya sido reparada ningún podrá iniciar una sesión")
			
		Else 
			$t_Texto1:=__ ("Abra el Centro de Seguridad, seleccione la opción REPARAR en la barra lateral izquierda y haga una REPARACIÓN ESTÁNDAR.")+"\r"+__ ("Una vez finalizada la reparación reinicie SchoolTrack.")+"\r"+"Al reiniciar se verificará nuevamente la base de datos (en algunos casos puede ser necesario reparar la base de datos varias veces antes de resolver todas las anomalías)."
		End if 
		If ($t_error="")
			$t_texto2:=__ ("Se envió un informe Colegium. Si necesita apoyo por favor pongase en contacto con la mesa de ayuda.")
		Else 
			$t_texto2:=__ ("No fue posible enviar automáticamente el informe a Colegium. Si necesita apoyo por favor envíe el informe y pongase en contacto con la mesa de ayuda.")
		End if 
		OBJECT SET TITLE:C194(*;"textoFallaVerificacion";$t_texto1)
		OBJECT SET TITLE:C194(*;"textoApoyoP";$t_texto2)
		FORM GOTO PAGE:C247(3)
		
	: (($t_jsonPerdidaRegistros#"") & ($t_jsonPerdidaRegistros#"0"))
		
		$y_numeroTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroTabla")
		$y_nombreTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreTabla")
		$y_registrosAntes:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosAntes")
		$y_registrosDespues:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosDespues")
		$y_diferencia:=OBJECT Get pointer:C1124(Object named:K67:5;"diferencia")
		
		
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //Ticket 179869 
		
		C_OBJECT:C1216($ob)
		
		$ob:=JSON Parse:C1218($t_jsonPerdidaRegistros;Is object:K8:27)
		
		OB_GET ($ob;$y_numeroTabla;"numeroTabla")
		OB_GET ($ob;$y_nombreTabla;"nombreTabla")
		OB_GET ($ob;$y_registrosAntes;"registrosAntes")
		OB_GET ($ob;$y_registrosDespues;"registrosDespues")
		OB_GET ($ob;$y_diferencia;"registrosPerdidos")
		
		
		  //$t_refJson:=JSON Parse text ($t_jsonPerdidaRegistros)
		  //JSON_ExtraeValorElemento ($t_refJson;$y_numeroTabla;"numeroTabla")
		  //JSON_ExtraeValorElemento ($t_refJson;$y_nombreTabla;"nombreTabla")
		  //JSON_ExtraeValorElemento ($t_refJson;$y_registrosAntes;"registrosAntes")
		  //JSON_ExtraeValorElemento ($t_refJson;$y_registrosDespues;"registrosDespues")
		  //JSON_ExtraeValorElemento ($t_refJson;$y_diferencia;"registrosPerdidos")
		  //JSON CLOSE ($t_refJson)
		
		$t_rutaConteoDespues:=Temporary folder:C486+"Comparacion registros - DTS"+$t_dts+".xls"
		$h_RefDoc:=Create document:C266($t_rutaConteoDespues)
		$t_Encabezados:="Nº Tabla\tNombre de la tabla\tRegistros antes\tRegistros despues\tDiferencia\r"
		SEND PACKET:C103($h_RefDoc;$t_Encabezados)
		$t_docXLS:=AT_Arrays2Text ("\r";"\t";$y_numeroTabla;$y_nombreTabla;$y_registrosAntes;$y_registrosDespues;$y_diferencia)
		SEND PACKET:C103($h_RefDoc;$t_docXLS)
		CLOSE DOCUMENT:C267($h_RefDoc)
		
		APPEND TO ARRAY:C911($at_adjuntos;$t_rutaConteoDespues)
		
		$t_versionEstructura:=OBJECT Get title:C1068(*;"versionAplicacion")
		$t_versionBaseDeDatos:=OBJECT Get title:C1068(*;"versionBD")
		
		$t_Cuerpo:=__ ("Se detectó pérdida de registros en algunas tablas después de la compactación previa a la actualización la aplicación desde ^0 a ^1 de la base de datos de ")+<>gCustom+": \r\r"
		$t_Cuerpo:=$t_Cuerpo+__ ("Se adjunta un documento con el detalle de las diferencias.")
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack del colegio en la ruta siguiente:\r")+Data file:C490+"\r\r"
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_versionBaseDeDatos)
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionEstructura)
		$t_asunto:="Reporte de pérdida en base de datos de "+<>gCustom
		$t_destinatario:="soporte@colegium.com"
		$t_copia:="qa@colegium.com"
		$t_copiaOculta:="abachler@colegium.com"
		
		$t_mensaje:=__ ("Se detectó pérdida de registros...")+"\r"+__ ("Enviando informe a Colegium...")
		$t_Error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaOculta;->$at_adjuntos;$t_mensaje)
		
		
		If ($t_Error#"")
			ALERT:C41(__ ("No fue posible enviar el informe de errores de compactación:")+"\r\r"+$t_Error)
		Else 
			Notificacion_Mostrar ("Envio de informe a Colegium";"El informe de errores de compactación de la base de datos fue enviado a Colegium.")
		End if 
		
		If ($t_error="")
			$t_texto2:=__ ("Se envió un informe Colegium. Si necesita apoyo por favor pongase en contacto con la mesa de ayuda.")
		Else 
			$t_texto2:=__ ("No fue posible enviar automáticamente el informe a Colegium. Si necesita apoyo por favor envíe el informe y pongase en contacto con la mesa de ayuda.")
		End if 
		OBJECT SET TITLE:C194(*;"textoApoyoP4";$t_texto2)
		FORM GOTO PAGE:C247(4)
		
	Else 
		OBJECT SET TITLE:C194(*;"rutabdOriginal";$t_rutaArchivoOriginal)
		OBJECT SET TITLE:C194(*;"rutabdCompactada";Data file:C490)
		OBJECT SET TITLE:C194(*;"bRutabdOriginal";ST_GetWord ($t_rutaArchivoOriginal;ST_CountWords ($t_rutaArchivoOriginal;0;Folder separator:K24:12);Folder separator:K24:12))
		OBJECT SET TITLE:C194(*;"bRutabdCompactada";ST_GetWord (Data file:C490;ST_CountWords (Data file:C490;0;Folder separator:K24:12);Folder separator:K24:12))
		FORM GOTO PAGE:C247(5)
End case 

