  // XS_CIM.seleccionHistorial()
  // Por: Alberto Bachler K.: 01-09-14, 15:26:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_itemSeleccionado)
C_POINTER:C301($y_rutaArchivoHistorial)
C_TEXT:C284($path;$t_itemsMenu;$t_nombreMaquina;$t_rutaArchivoHistorial)

ARRAY TEXT:C222($at_RutaArchivoHistorial;0)
ARRAY TEXT:C222($at_SeleccionHistorial;0)

  //$y_rutaArchivoHistorial:=OBJECT Get pointer(Object named;"rutaArchivoHistorial")
$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
  //If (Test path name($t_rutaArchivoHistorial)#Is a document)
  //$t_rutaArchivoHistorial:=Substring(Data file;1;Length(Data file)-3)+"journal"
  //End if 

$t_itemsMenu:=AT_array2text (->$at_SeleccionHistorial)
If (SYS_TestPathName ($t_rutaArchivoHistorial;Server)=Is a document:K24:1)
	APPEND TO ARRAY:C911($at_SeleccionHistorial;__ ("Copiar la ruta"))
	APPEND TO ARRAY:C911($at_SeleccionHistorial;"(-")
	APPEND TO ARRAY:C911($at_SeleccionHistorial;"("+__ ("Activar historial..."))
Else 
	APPEND TO ARRAY:C911($at_SeleccionHistorial;"("+__ ("Copiar la ruta"))
	APPEND TO ARRAY:C911($at_SeleccionHistorial;"(-")
	APPEND TO ARRAY:C911($at_SeleccionHistorial;__ ("Activar historial..."))
End if 
APPEND TO ARRAY:C911($at_SeleccionHistorial;"(-")
APPEND TO ARRAY:C911($at_SeleccionHistorial;__ ("No utilizar historial"))

$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_SeleccionHistorial)

Case of 
	: ($l_itemSeleccionado=Size of array:C274($at_SeleccionHistorial))  // sin historial
		$t_titulo:=__ ("Activar el uso de un archivo de historial")
		$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
		If ($t_rutaArchivoHistorial#"")
			$t_mensaje:=__ ("Hay un archivo de historial activo actualmente.\r"+\
				"Si desactiva el registro de las operaciones en una archivo de historial perderá la posibilidad de recuperar las operaciones "+\
				"registradas desde el último respaldo si la base de datos está dañada.\r\r"+\
				"La opciones de restauración automática de respaldo e integración del historial serán inhabilitadas.\r\r"+\
				"¿Está seguro de querer desactivar el registro de las operaciones en un archivo de historial?")
			$l_respuesta:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Cancelar");__ ("Aceptar"))
		Else 
			$l_respuesta:=2
		End if 
		
		If ($l_respuesta=2)
			BKP_DesactivaHistorial 
			(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_integracionAutomaticaLog"))->:=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_restauracionAutomatica"))->:=0
			OBJECT SET ENABLED:C1123(*;"BKP_integracionAutomaticaLog";False:C215)
			OBJECT SET ENABLED:C1123(*;"BKP_restauracionAutomatica";False:C215)
			OBJECT SET TITLE:C194(*;"seleccionHistorial";__ ("No utilizar historial"))
		End if 
		
	: ($l_itemSeleccionado=(Size of array:C274($at_SeleccionHistorial)-2))  // seleccionar
		$t_titulo:=__ ("Activar el uso de un archivo de historial")
		$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
		If ($t_rutaArchivoHistorial#"")
			$t_mensaje:=__ ("Hay un archivo de historial activo actualmente.\r"+\
				"Si crea y activa un nuevo archivo de historial perderá la posibilidad de recuperar las operaciones "+\
				"registradas desde el último respaldo si la base de datos está dañada.\r\r"+\
				"Antes de crear un nuevo archivo de historial es preferible verificar la base de datos para asegurarse que no tenga ningún daño.\r\r"+\
				"¿Está seguro de querer activar un nuevo archivo de historial?")
			$l_respuesta:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Cancelar");__ ("Aceptar"))
		Else 
			$l_respuesta:=2
		End if 
		
		If ($l_respuesta=2)
			$t_titulo:=__ ("Activar el uso de un archivo de historial")
			$t_mensaje:=__ ("Cuando se activa el uso de un nuevo archivo de historial es necesario hacer un respaldo de la base de datos.\r"+\
				"Mientras el respaldo se ejecuta ningún usuario podrá realizar ninguna acción que modifique la base de datos.\r\r"+\
				"¿Desea usted proceder a respaldar la base de datos y activar el nuevo archivo de historial?")
			$l_respuesta:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Respaldar y activar historial");__ ("Cancelar"))
		End if 
		
		If ($l_respuesta=1)
			  //$t_titulo:=__ ("Activar el uso de un archivo de historial")
			  //$t_mensaje:=__ ("Hay un archivo de historial activo actualmente\r. ")
			  //
			  //If (Application type=4D Remote Mode)
			  //$t_nombreHistorial:=ModernUI_Peticion (__ ("Activación de archivo Historial");__ ("El nuevo archivo de historial se almacenará junto al archivo de datos.\rPor favor ingrese el nombre que desea darle al archivo:");__ ("Nombre del archivo Historial");"";__ ("Aceptar");__ ("Cancelar"))\
				
			
			
			
			
			  //
			  //Else 
			  //$t_nombreHistorial:=ModernUI_Peticion (__ ("Activación de archivo Historial");__ ("El nuevo archivo de historial se almacenará junto al archivo de datos.\rPor favor ingrese el nombre que desea darle al archivo:");__ ("Nombre del archivo Historial");"";__ ("Aceptar");__ ("Cancelar"))\
				
			
			
			
			
			  //
			  //End if 
			
			$b_respaldoInhabilitado:=Semaphore:C143("ImpedirRespaldo")
			$t_nombreArchivo:=SYS_GetServerProperty (XS_DataFileName)
			$t_nombreArchivo:=Substring:C12($t_nombreArchivo;1;Length:C16($t_nombreArchivo)-3)+"journal"
			
			$t_rutaArchivoHistorial:=SYS_SaveFileOnServer ("Seleccione donde guardar el archivo historial...";$t_nombreArchivo)
			
			
			
			If (OK=1) & ($t_rutaArchivoHistorial#"")
				$b_respaldoInhabilitado:=Semaphore:C143("ImpedirRespaldo")
				CIM_BKP_GuardaPreferencias 
				SELECT LOG FILE:C345($t_rutaArchivoHistorial)
				CLEAR SEMAPHORE:C144("ImpedirRespaldo")
				BACKUP:C887
				
				$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)
				SYS_PathToArray ($t_rutaArchivoHistorial;->$at_RutaArchivoHistorial)
				If (Application type:C494=4D Remote mode:K5:5)
					$t_nombreMaquina:=SYS_GetServerProperty (XS_MachineName)
					OBJECT SET TITLE:C194(*;"seleccionHistorial";$at_RutaArchivoHistorial{1}+__ (" en ")+$t_nombreMaquina)
				Else 
					OBJECT SET TITLE:C194(*;"seleccionHistorial";$at_RutaArchivoHistorial{1}+__ (" en ")+$at_RutaArchivoHistorial{Size of array:C274($at_RutaArchivoHistorial)})
				End if 
			Else 
				CLEAR SEMAPHORE:C144("ImpedirRespaldo")
			End if 
		End if 
		
	: ($l_itemSeleccionado=(Size of array:C274($at_SeleccionHistorial)-4))  // copiar ruta
		SET TEXT TO PASTEBOARD:C523($t_rutaArchivoHistorial)
		
End case 

$b_logValido:=(SYS_GetServerProperty (XS_LogFilePath)#"")
$b_respaldosActivos:=((OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->>1)
OBJECT SET ENABLED:C1123(*;"BKP_integracionAutomaticaLog";$b_logValido & $b_respaldosActivos)
OBJECT SET ENABLED:C1123(*;"BKP_restauracionAutomatica";$b_logValido & $b_respaldosActivos)
OBJECT SET ENABLED:C1123(*;"verHistorial";$b_logValido)
