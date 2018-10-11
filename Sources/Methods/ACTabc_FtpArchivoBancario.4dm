//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 03-02-18, 16:14:42
  // ----------------------------------------------------
  // Método: ACTabc_FtpArchivoBancario
  // Descripción
  // Este metodo sube un archivo pasado en su segundo parametro al FTP definido en el objeto pasado en su primer parametro
  // Parámetros
  // $1 objeto que contiene los datos de conexion al sitio ftp
  // $2 string con la ruta al archivo que se debe subir al ftp
  // ----------------------------------------------------

  // Declaraciones 
C_OBJECT:C1216($o_datosftp)
C_TEXT:C284($t_archivo;$t_servidor;$t_usuario;$t_contraseña;$t_rutaexterna;$t_cwd)
C_LONGINT:C283($l_puerto;$l_modo;$l_ConnexID;$termometro)

  // Asignaciones Globales de metodo
$t_servidor:=OB Get:C1224($1;"host")
$l_puerto:=OB Get:C1224($1;"puerto")
$t_usuario:=OB Get:C1224($1;"user")
$t_contraseña:=OB Get:C1224($1;"pass")
$l_modo:=OB Get:C1224($1;"conexion")
$t_rutaexterna:=OB Get:C1224($1;"rutaexterna")
$t_archivo:=$2

If (Not:C34(Undefined:C82($o_datosftp)))
	If (Test path name:C476($t_archivo)=Is a document:K24:1)
		$termometro:=IT_UThermometer (1;0;"Cargando archivo en ftp externo...")
		If ($t_rutaexterna#"")
			If ((Length:C16($t_rutaexterna)>1) & ($t_rutaexterna[[1]]#"/"))
				$t_rutaexterna:="/"+$t_rutaexterna
			End if 
			If ((Length:C16($t_rutaexterna)>1) & ($t_rutaexterna[[Length:C16($t_rutaexterna)]]="/"))
				$t_rutaexterna:=Substring:C12($t_rutaexterna;1;(Length:C16($t_rutaexterna)-1))
			End if 
			If ($t_rutaexterna="/")
				$t_rutaexterna:=""
			End if 
		End if 
		$0:=FTP_Upload ($l_ConnexID;$t_rutaexterna;$t_archivo;$t_servidor;$t_usuario;$t_contraseña;Current machine:C483;<>RegisteredName;False:C215;False:C215;$l_modo;False:C215)
		IT_UThermometer (-2;$termometro)
	End if 
End if 

If ($0#0)
	$t_msg:="No fue posible cargar el archivo "+SYS_Path2FileName ($t_archivo)+" en FTP externo.\n\nVerifique la informacion de conexion a FTP del modelo "+[xxACT_ArchivosBancarios:118]Nombre:3+" e intentelo mas tarde.\n\nFecha: "+String:C10(Current date:C33(*))+"\nUsuario: "+<>tUSR_CurrentUser+"\nMaquina:"+Current machine:C483
	LOG_RegisterEvt ("No fue posible cargar el archivo "+SYS_Path2FileName ($t_archivo)+" en FTP externo. Verifique la informacion de conexion a FTP del modelo "+[xxACT_ArchivosBancarios:118]Nombre:3+" e intentelo mas tarde. Fecha: "+String:C10(Current date:C33(*))+" Usuario: "+<>tUSR_CurrentUser+" Maquina:"+Current machine:C483+", error: "+IT_ErrorText ($0))
Else 
	$t_msg:="Carga de archivo finalizada sin inconvenientes.\n\nArchivo subido: "+SYS_Path2FileName ($t_archivo)+"\nFecha: "+String:C10(Current date:C33(*))+"\nUsuario: "+<>tUSR_CurrentUser+"\nMaquina:"+Current machine:C483
	LOG_RegisterEvt ("Carga de archivo finalizada sin inconvenientes. Archivo subido: "+SYS_Path2FileName ($t_archivo)+" Fecha: "+String:C10(Current date:C33(*))+" Usuario: "+<>tUSR_CurrentUser+" Maquina: "+Current machine:C483)
End if 

CD_Dlog (0;$t_msg)