  // Actualizacion11_1.Botón1()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 16/01/13, 13:03:38
  // ---------------------------------------------
C_BOOLEAN:C305($b_CompactacionNecesaria)
C_LONGINT:C283($i)
C_POINTER:C301($y_arregloErrores)
C_TEXT:C284($t_asunto;$t_copia;$t_copiaOculta;$t_Cuerpo;$t_destinatario;$t_error;$t_logFolder;$t_mensaje;$t_nombreEstructura;$t_rutaLog)
C_TEXT:C284($t_Texto1;$t_texto2;$t_versionBaseDeDatos;$t_versionEstructura)

ARRAY TEXT:C222($at_adjuntos;0)




ARRAY TEXT:C222(at_DataFileError;0)
OK:=CIM_VerifyDataFile ("";0)

If (Size of array:C274(at_DataFileError)=0)
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
End if 

Case of 
	: (Size of array:C274(at_DataFileError)=0)
		FORM GOTO PAGE:C247(2)
		
		
	Else 
		$t_versionEstructura:=OBJECT Get title:C1068(*;"versionAplicacion")
		$t_versionBaseDeDatos:=OBJECT Get title:C1068(*;"versionBD")
		
		$t_Cuerpo:=__ ("En la verificación de la base de datos previa a la actualización desde ^0 a ^1 se detectaron daños en la base de datos del colegio ")+<>gCustom+": \r\r"
		$t_Cuerpo:=$t_Cuerpo+AT_array2text (->at_DataFileError;"\r")
		
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("Se adjunta el log de verificación de la base de datos")
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos dañada se encuentra en el servidor SchoolTrack de la institución en la ruta siguiente:\r")+Data file:C490+"\r\r"
		
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
		$t_rutaLog:=$t_logFolder+$t_nombreEstructura+"_Verify_Log.xml"
		APPEND TO ARRAY:C911($at_adjuntos;$t_rutaLog)
		$t_asunto:="Informe de verificación de Base de datos "+<>gCustom
		$t_destinatario:="soporte@colegium.com"
		$t_copia:="qa@colegium.com"
		$t_copiaOculta:="abachler@colegium.com"
		
		$t_mensaje:=__ ("La base de datos está dañada.")+"\r"+__ ("Enviando informe a Colegium...")
		$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaOculta;->$at_adjuntos;$t_mensaje)
		
		
		If ($t_Error#"")
			ALERT:C41(__ ("No fue posible enviar el informe de anomalías en la base de datos:")+"\r\r"+$t_Error)
		Else 
			Notificacion_Mostrar ("Envio de informe a Colegium";"El informe de daños en la base de datos fue enviado a Colegium.")
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
		OBJECT SET TITLE:C194(*;"textoAnomalias";__ ("Se detectaron las siguientes anomalías durante la verificación de la base de datos."))
		
		OBJECT SET TITLE:C194(*;"textoFallaVerificacion";$t_texto1)
		OBJECT SET TITLE:C194(*;"textoApoyo";$t_texto2)
		OBJECT SET TITLE:C194(*;"bOpenCSM";__ ("Reconstruir base de datos"))
		
		FORM GOTO PAGE:C247(3)
End case 


