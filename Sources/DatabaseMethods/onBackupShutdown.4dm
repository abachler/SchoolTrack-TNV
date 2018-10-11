  // On Backup Shutdown()
  // Por: Alberto Bachler K.: 03-09-14, 17:41:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284(<>gRolBD;<>gCustom)

C_DATE:C307($d_fechaProximoRespaldo;$d_fechaUltimoRespaldo)
C_LONGINT:C283($l_errorRespaldo;$l_modoAutenticacion;$l_puerto;$l_statusRespaldo;$l_usarSSL)
C_TIME:C306($h_horaProximoRespaldo;$h_horaUltimoRespaldo)
C_POINTER:C301($y_nil)
C_TEXT:C284($t_asunto;$t_BKP_xmlRef;$t_contraseña;$t_copia;$t_cuerpo;$t_destinatario;$t_emailAviso;$t_error)
C_TEXT:C284($t_nombreUsuario;$t_remitente;$t_rutaCarpetaRespaldos;$t_rutaCopiaPrefBackup;$t_rutaPorDefecto;$t_rutaUltimoRespaldo;$t_servidor;$t_statusRespaldo;$t_UUID;$t_volumen)
C_TEXT:C284($t_XMLrefPrefsRespaldo)


$l_errorRespaldo:=$1

  //If ($l_errorRespaldo<0)
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>gCustom:=[Colegio:31]Nombre_Colegio:1
<>gRolBD:=[Colegio:31]Rol Base Datos:9
  //End if 

If ($l_errorRespaldo=-99)
	  // el error -99 lo entrega on backup startup ciuando la se está ejecutando  On Startup o On Server Startup (el semáforo "ImpedirRespaldo" está puesto)
	  // no se hace nada, se espera que la ejecución termine
Else 
	Case of 
		: ($l_errorRespaldo=0)
			  // backup exitoso
			
		: ($l_errorRespaldo=-99)
			  // se está ejecutando el método de inicio. se inhabilita el respaldo 
			
		: ($l_errorRespaldo=-1)
			  // base de datos nueva o en reconstruccion. No se hace el respaldo y no se registra ningun evento.
			
		: ($l_errorRespaldo=-2)
			  // el script de backup correspondia a otra base de datos.
			  // Se a a esta base de datos. No se registra ningun evento.
			  // Se reintentará el respaldo.
			
		: ($l_errorRespaldo=-3)
			  // la carpeta de respaldo designada en el plan de respaldo no existe
			  // en el proximo intento se respaldará en la carpeta por defecto sin alterar el plan de respaldo
			  // se registra un evento y se informa al correo indicado en el plan de respaldo que se intentará respaldar en la carpeta por defecto
			BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
			$t_error:=__ ("La carpeta de respaldos indicada en el plan de respaldos \"^0\" no existe.\r\\Se intentará respaldar en la carpeta por defecto \"^1\".")
			$t_rutaPorDefecto:=SYS_GetFolderNam (Data file:C490)+"Respaldos_"+<>gRolBD+Folder separator:K24:12
			$t_error:=Replace string:C233($t_error;"^0";$t_rutaCarpetaRespaldos)
			$t_error:=Replace string:C233($t_error;"^1";$t_rutaPorDefecto)
			
		: ($l_errorRespaldo=-4)
			  // no hay espacio disponible para el respaldo en el volumen de la carpeta de respaldo
			  // el respaldo es abortado hasta el proximo reintento
			  // se registra un evento y se informa al correo indicado en el plan de respaldo que el respaldo no pudo realizarse
			$t_error:=__ ("No hay suficiente espacio disponible en el volumen ^0 en que se encuentra la carpeta designada en el plan de respaldo (^1).")
			BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
			$t_volumen:=SYS_NombreVolumen_Servidor ($t_rutaCarpetaRespaldos)
			$t_error:=Replace string:C233($t_error;"^0";$t_volumen)
			$t_error:=Replace string:C233($t_error;"^1";$t_rutaCarpetaRespaldos)
			
		: ($l_errorRespaldo=-5)
			  // no se puede escribir en la carpeta de respaldos
			  // el respaldo es abortado hasta el proximo reintento
			  // se registra un evento y se informa al correo indicado en el plan de respaldo que el respaldo no pudo realizarse
			$t_error:=__ ("No es posible escribir en la carpeta designada en el plan de respaldo (^0).")
			BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
			$t_error:=Replace string:C233($t_error;"^0";$t_rutaCarpetaRespaldos)
			
		: ($l_errorRespaldo=-6)
			$t_error:=__ ("Error #-6: El documento de preferencias de respaldo está mal formado")
			
		Else 
			
			Case of 
				: ($l_errorRespaldo=1401)
					$t_error:="The maximum number of backup attempts has been reached;automatic backup is temporarily disabled."
				: ($l_errorRespaldo=1403)
					$t_error:="No log file."
				: ($l_errorRespaldo=1404)
					$t_error:="A transaction is opened in this process."
				: ($l_errorRespaldo=1405)
					$t_error:="The maximum timeout for transactions to end in a concurrent process has been"
				: ($l_errorRespaldo=1406)
					$t_error:="Backup canceled by user."
				: ($l_errorRespaldo=1407)
					$t_error:="Destination folder is not valid."
				: ($l_errorRespaldo=1408)
					$t_error:="Error during log file backup."
				: ($l_errorRespaldo=1409)
					$t_error:="Error during backup."
				: ($l_errorRespaldo=1410)
					$t_error:="Cannot find the backup file to be checked."
				: ($l_errorRespaldo=1411)
					$t_error:="Error during backup file check."
				: ($l_errorRespaldo=1412)
					$t_error:="Cannot find the log backup file to be checked."
				: ($l_errorRespaldo=1413)
					$t_error:="Error during log backup file check."
				: ($l_errorRespaldo=1414)
					$t_error:="This comando can only be executed on 4D Server."
				: ($l_errorRespaldo=1415)
					$t_error:="Cannot back up log file;a critical operation is in progress."
				: ($l_errorRespaldo=1416)
					$t_error:="This log file does not correspond to the database opened."
				: ($l_errorRespaldo=1417)
					$t_error:="A log integration operation is already running. The backup cannot be launched"
				: ($l_errorRespaldo=1420)
					$t_error:="Integration aborted due to detection of locked records."
				: ($l_errorRespaldo=1421)
					$t_error:="This command cannot be used in a client/server environment."
				Else 
					$t_error:="Undefined error #"+String:C10($l_errorRespaldo)
			End case 
			
	End case 
	
	If (($l_errorRespaldo<-2) | ($l_errorRespaldo=0))
		$l_idProceso:=New process:C317("BKP_CierraRespaldo";Pila_256K;"Cierre Respaldo";$l_errorRespaldo;$t_error)
	End if 
	
End if 


  //End if 

