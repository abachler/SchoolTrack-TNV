
Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		  // Declaraciones 
		C_POINTER:C301($y_activarftp;$y_host;$y_puerto;$y_usuario;$y_password;$y_listbox;$y_activarnombre;$y_prefijo;$y_propiedades;$y_valores;$y_extension)
		C_POINTER:C301($y_extensiontxt;$y_extensionxml;$y_extensioncft;$y_rutaexterna)
		C_POINTER:C301($y_conexionpasiva;$y_conexionactiva;$y_sufijo)
		
		C_OBJECT:C1216($ob_ftp;$ob_archivo)
		C_TEXT:C284($vt_msg;$vt_msg1;$vt_msg2)
		C_LONGINT:C283($i)
		ARRAY TEXT:C222($at_verificacion;0)
		ARRAY TEXT:C222($at_propiedades;0)
		ARRAY TEXT:C222($at_valores;0)
		C_BOOLEAN:C305($vb_guardar)
		ARRAY TEXT:C222($at_extensiones;0)
		
		
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
		
		$vb_guardar:=True:C214
		
		
		
		If ($y_activarnombre->=1)
			If (($y_prefijo->="") & ($y_sufijo->{$y_sufijo->}=""))
				$vt_msg1:=$vt_msg1+"- Si utiliza el nombre de archivo personalizado debe utilizar un prefijo o un sufijo.\n"
			End if 
			If ($vt_msg1#"")
				$vt_msg1:="Propiedades del archivo\n"+$vt_msg1
			End if 
		End if 
		
		If ($y_activarftp->=1)
			If (($y_host->="") | (Position:C15("http";$y_host->;1)>0))
				$vt_msg2:=$vt_msg2+"- Direccion de host invalida.\n"
			End if 
			  // Se deja codigo, para futuras implementaciones de esta variable
			  //If ($y_puerto->=0)
			  //$vt_msg2:=$vt_msg2+"- Puerto del host.\n"
			  //End if 
			If ($y_usuario->="")
				$vt_msg2:=$vt_msg2+"- Usuario.\n"
			End if 
			If ($y_password->="")
				$vt_msg2:=$vt_msg2+"- Contraseña.\n"
			End if 
			If ($vt_msg2#"")
				$vt_msg2:="Propiedades del sitio FTP\n"+$vt_msg2
			End if 
		End if 
		
		If (($vt_msg1#"") | ($vt_msg2#""))
			$vt_msg:="Para guardar la configuracion debe verificar:\n\n"+$vt_msg1+$vt_msg2
			CD_Dlog (0;$vt_msg)
			$vb_guardar:=False:C215
		End if 
		
		
		If ($vb_guardar)
			
			  // Guardo lo ingresado en los controles al objeto de la tabla
			OB SET:C1220($ob_archivo;"activo";$y_activarnombre->)
			OB SET:C1220($ob_archivo;"prefijo";$y_prefijo->)
			OB SET:C1220($ob_archivo;"sufijo";$y_sufijo->{$y_sufijo->})
			OB SET ARRAY:C1227($ob_archivo;"sufijos_disp";$y_sufijo->)
			OB SET:C1220($ob_archivo;"extension";$y_extension->{$y_extension->})
			OB SET ARRAY:C1227($ob_archivo;"extensiones_disp";$y_extension->)
			
			OB SET:C1220([xxACT_ArchivosBancarios:118]Configuracion:15;"Archivo";$ob_archivo)
			
			OB SET:C1220($ob_ftp;"activo";$y_activarftp->)
			OB SET:C1220($ob_ftp;"host";$y_host->)
			OB SET:C1220($ob_ftp;"puerto";$y_puerto->)
			OB SET:C1220($ob_ftp;"user";$y_usuario->)
			OB SET:C1220($ob_ftp;"pass";$y_password->)
			If ($y_conexionpasiva->=1)
				OB SET:C1220($ob_ftp;"conexion";1)
			Else 
				OB SET:C1220($ob_ftp;"conexion";0)
			End if 
			OB SET:C1220($ob_ftp;"rutaexterna";$y_rutaexterna->)
			OB SET:C1220([xxACT_ArchivosBancarios:118]Configuracion:15;"DatosFtp";$ob_ftp)
			
			
			For ($i;Size of array:C274($y_propiedades->);1;-1)
				If (($y_propiedades->{$i}="") & ($y_valores->{$i}=""))
					AT_Delete ($i;1;$y_propiedades;$y_valores)
				End if 
			End for 
			OB SET ARRAY:C1227([xxACT_ArchivosBancarios:118]Configuracion:15;"Propiedades";$y_propiedades->)
			OB SET ARRAY:C1227([xxACT_ArchivosBancarios:118]Configuracion:15;"Valores";$y_valores->)
			
			ACCEPT:C269
		End if 
		
		
End case 
