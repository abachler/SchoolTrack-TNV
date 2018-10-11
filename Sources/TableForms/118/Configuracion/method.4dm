
Case of 
	: (Form event:C388=On Load:K2:1)
		
		  // Declaraciones 
		C_POINTER:C301($y_activarftp;$y_host;$y_puerto;$y_usuario;$y_password)
		C_POINTER:C301($y_activarnombre;$y_prefijo;$y_rutaexterna;$y_propiedades;$y_valores)
		C_POINTER:C301($y_conexionpasiva;$y_conexionactiva;$y_extension;$y_sufijo)
		C_LONGINT:C283($i;$l_pos)
		C_REAL:C285($r_offset)
		C_OBJECT:C1216($ob_ftp;$ob_archivo)
		C_BOOLEAN:C305($b_editar)
		C_TEXT:C284($t_code;$t_extension)
		ARRAY TEXT:C222($at_dummy;0)
		ARRAY LONGINT:C221($al_dummy;0)
		ARRAY TEXT:C222($at_propiedades;0)
		ARRAY TEXT:C222($at_valores;0)
		ARRAY TEXT:C222($at_extensiones;0)
		ARRAY LONGINT:C221($al_extensiones;0)
		ARRAY TEXT:C222($at_sufijo;0)
		$lt_extensiones:=New list:C375
		$lt_sufijos:=New list:C375
		
		
		  // Punteros a controles de formulario
		$y_activarftp:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_activarftp")
		$y_host:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_host")
		$y_puerto:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_puerto")
		$y_usuario:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_usuario")
		$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_password")
		$y_activarnombre:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_activarnombre")
		$y_prefijo:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_prefijo")
		$y_sufijo:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_sufijo")
		$y_rutaexterna:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_rutaexterna")
		$y_propiedades:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_propiedades")
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_valores")
		$y_conexionpasiva:=OBJECT Get pointer:C1124(Object named:K67:5;"conexionpasiva_ob")
		$y_conexionactiva:=OBJECT Get pointer:C1124(Object named:K67:5;"conexionactiva_ob")
		$y_extension:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_extensiones")
		
		
		  // Testing de inicializacion de campo objeto 
		OB GET PROPERTY NAMES:C1232([xxACT_ArchivosBancarios:118]Configuracion:15;$at_dummy;$al_dummy)
		If (Size of array:C274($at_dummy)=0)
			
			  // Inicializacion
			  // Archivo
			OB SET:C1220($ob_archivo;"activo";0)  // default pasivo, 1 para activo
			OB SET:C1220($ob_archivo;"prefijo";"")
			OB SET:C1220($ob_archivo;"sufijo";"")
			APPEND TO ARRAY:C911($at_sufijo;"")
			APPEND TO ARRAY:C911($at_sufijo;"DDMMAA")
			APPEND TO ARRAY:C911($at_sufijo;"DDMMAAAA")
			APPEND TO ARRAY:C911($at_sufijo;"AAMMDD")
			APPEND TO ARRAY:C911($at_sufijo;"AAAAMMDD")
			OB SET ARRAY:C1227($ob_archivo;"sufijos_disp";$at_sufijo)
			$t_code:=Convert to text:C1012([xxACT_ArchivosBancarios:118]xData:2;"MacRoman")
			$l_pos:=Position:C15("vExt";$t_code)
			If ($l_pos>0)
				$t_extension:=Substring:C12($t_code;($l_pos+7);3)
			Else 
				$t_extension:="txt"
			End if 
			OB SET:C1220($ob_archivo;"extension";$t_extension)
			APPEND TO ARRAY:C911($at_extensiones;$t_extension)
			OB SET ARRAY:C1227($ob_archivo;"extensiones_disp";$at_extensiones)
			OB SET:C1220([xxACT_ArchivosBancarios:118]Configuracion:15;"Archivo";$ob_archivo)
			
			  // Ftp
			OB SET:C1220($ob_ftp;"activo";0)
			OB SET:C1220($ob_ftp;"host";"")
			OB SET:C1220($ob_ftp;"puerto";0)
			OB SET:C1220($ob_ftp;"user";"")
			OB SET:C1220($ob_ftp;"pass";"")
			OB SET:C1220($ob_ftp;"conexion";1)
			OB SET:C1220($ob_archivo;"rutaexterna";"")
			OB SET:C1220([xxACT_ArchivosBancarios:118]Configuracion:15;"DatosFtp";$ob_ftp)
			
			  // Propiedades
			OB SET ARRAY:C1227([xxACT_ArchivosBancarios:118]Configuracion:15;"Propiedades";$at_propiedades)
			OB SET ARRAY:C1227([xxACT_ArchivosBancarios:118]Configuracion:15;"Valores";$at_valores)
			
		End if 
		
		
		  // Asignacion de valores en interfaz
		  // Archivo
		$ob_archivo:=OB Get:C1224([xxACT_ArchivosBancarios:118]Configuracion:15;"Archivo")
		$y_activarnombre->:=OB Get:C1224($ob_archivo;"activo")
		$y_prefijo->:=OB Get:C1224($ob_archivo;"prefijo")
		OB GET ARRAY:C1229($ob_archivo;"sufijos_disp";$at_sufijo)
		For ($i;1;Size of array:C274($at_sufijo))
			APPEND TO LIST:C376($lt_sufijos;$at_sufijo{$i};$i)
		End for 
		OBJECT SET LIST BY REFERENCE:C1266(*;"ob_sufijo";Choice list:K42:19;$lt_sufijos)
		$l_pos:=Find in array:C230($at_sufijo;OB Get:C1224($ob_archivo;"sufijo"))
		$y_sufijo->:=$l_pos
		OB GET ARRAY:C1229($ob_archivo;"extensiones_disp";$at_extensiones)
		For ($i;1;Size of array:C274($at_extensiones))
			APPEND TO LIST:C376($lt_extensiones;$at_extensiones{$i};$i)
		End for 
		OBJECT SET LIST BY REFERENCE:C1266(*;"ob_extensiones";Choice list:K42:19;$lt_extensiones)
		$l_pos:=Find in array:C230($at_extensiones;OB Get:C1224($ob_archivo;"extension"))
		$y_extension->:=$l_pos
		
		  // FTP
		$ob_ftp:=OB Get:C1224([xxACT_ArchivosBancarios:118]Configuracion:15;"DatosFtp")
		$y_activarftp->:=OB Get:C1224($ob_ftp;"activo")
		$y_host->:=OB Get:C1224($ob_ftp;"host")
		$y_puerto->:=OB Get:C1224($ob_ftp;"puerto")
		$y_usuario->:=OB Get:C1224($ob_ftp;"user")
		$y_password->:=OB Get:C1224($ob_ftp;"pass")
		If (OB Get:C1224($ob_ftp;"conexion")=1)
			$y_conexionpasiva->:=1
		Else 
			$y_conexionactiva->:=1
		End if 
		$y_rutaexterna->:=OB Get:C1224($ob_ftp;"rutaexterna")
		
		  // Propiedades
		OB GET ARRAY:C1229([xxACT_ArchivosBancarios:118]Configuracion:15;"Propiedades";$y_propiedades->)
		OB GET ARRAY:C1229([xxACT_ArchivosBancarios:118]Configuracion:15;"Valores";$y_valores->)
		
		  // Control de edicion 
		If ($y_activarnombre->=1)
			$b_editar:=True:C214
		Else 
			$b_editar:=False:C215
		End if 
		OBJECT SET ENABLED:C1123(*;"ob_prefijo";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_sufijo";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_extensiones";$b_editar)
		If ($y_activarftp->=1)
			$b_editar:=True:C214
		Else 
			$b_editar:=False:C215
		End if 
		OBJECT SET ENABLED:C1123(*;"ob_host";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_host";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_puerto";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_usuario";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_password";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_mostrarpwd";$b_editar)
		OBJECT SET ENABLED:C1123(*;"conexionpasiva_ob";$b_editar)
		OBJECT SET ENABLED:C1123(*;"conexionactiva_ob";$b_editar)
		OBJECT SET ENABLED:C1123(*;"ob_rutaexterna";$b_editar)
		
		  // Ocultar contenido de objeto ob_password
		OBJECT SET FONT:C164(*;"ob_password";"%password")
		
		  // Filtro para objeto prefijo
		OBJECT SET FILTER:C235(*;"ob_prefijo";"&\"0-9;a-z;A-Z;_\"")
		
		  // Filtro para objeto sufijo
		OBJECT SET FILTER:C235(*;"ob_prefijo";"&\"0-9;a-z;A-Z;_\"")
		
		  // Filtro para objeto ruta externa
		  //OBJECT SET FILTER(*;"ob_rutaexterna";"&\"0-9;a-z;A-Z;/\"")
		
		  // Filtro para objeto host
		OBJECT SET FILTER:C235(*;"ob_host";"&\"0-9;a-z;A-Z;.\"")
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

