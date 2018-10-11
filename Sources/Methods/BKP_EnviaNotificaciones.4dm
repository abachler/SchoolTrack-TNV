//%attributes = {"executedOnServer":true}
  // Método: BKP_EnviaMail
  //
  //
  // creado por Alberto Bachler Klein
  // el 18/07/18, 06:57:05
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_creacion;$d_creacion7z;$d_fechaProximoRespaldo;$d_modificacion;$d_modificacion7z)
C_LONGINT:C283($l_codigoError)
C_TIME:C306($h_creacion;$h_creacion7z;$h_horaProximoRespaldo;$h_modificacion;$h_modificacion7z)
C_REAL:C285($r_disponible;$r_tamaño;$r_usado)
C_TEXT:C284($t_asunto;$t_copia;$t_copiaCC;$t_Cuerpo;$t_destinatario;$t_emailAviso;$t_error;$t_finCompresion;$t_infoVolumeBackup;$t_infoVolumeDatabase)
C_TEXT:C284($t_nombreBD;$t_proximoRespaldo;$t_respaldoComprimido;$t_respaldoInicio;$t_rutaBaseDeDatos;$t_rutaUltimoDiario;$t_rutaUltimoRespaldo;$t_volumeBackup;$t_volumeDatabase;$t_XMLrefPrefsRespaldo)


If (False:C215)
	C_LONGINT:C283(BKP_EnviaMail;$1)
End if 

If (Count parameters:C259=2)
	$l_codigoError:=$1
	$t_error:=$2
End if 

BKP_LeeItemPlanBackup ("BKP_emailAviso";->$t_destinatario)


Case of 
	: ($l_codigoError#0)
		$t_asunto:=__ ("Respaldo de base de datos fallido en ")+<>gCustom
		$t_cuerpo:=__ ("El respaldo de la base de datos no pudo ser efectuado a causa de un error: ")+$t_error+\
			"\r"+__ ("El equipo de soporte técnico de Colegium ya fue informado.")
		$t_copiaCC:="soporte@colegium.com,qa@colegium.com"
		
		
	: ($l_codigoError=0)
		$t_nombreBD:=Data file:C490
		
		GET BACKUP INFORMATION:C888(Next backup date:K54:3;$d_fechaProximoRespaldo;$h_horaProximoRespaldo)
		$t_XMLrefPrefsRespaldo:=BKP_ParseXML 
		$t_rutaBaseDeDatos:=Data file:C490
		$t_rutaUltimoRespaldo:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
		$t_rutaUltimoDiario:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupLogPath/Item1")
		DOM CLOSE XML:C722($t_XMLrefPrefsRespaldo)
		
		If (Test path name:C476($t_rutaUltimoRespaldo)=Is a document:K24:1)
			GET DOCUMENT PROPERTIES:C477($t_rutaUltimoRespaldo;$b_bloqueado;$b_invisible;$d_creacion;$h_creacion;$d_modificacion;$h_modificacion)
		End if 
		$t_respaldoComprimido:=$t_rutaUltimoRespaldo+".7z"
		If (Test path name:C476($t_respaldoComprimido)=Is a document:K24:1)
			GET DOCUMENT PROPERTIES:C477($t_respaldoComprimido;$b_bloqueado;$b_invisible;$d_creacion7z;$h_creacion7z;$d_modificacion7z;$h_modificacion7z)
		End if 
		
		$t_volumeDatabase:=ST_GetWord (Data file:C490;1;":")
		$t_volumeBackup:=ST_GetWord ($t_rutaUltimoRespaldo;1;":")
		VOLUME ATTRIBUTES:C472($t_volumeDatabase;$r_tamaño;$r_usado;$r_disponible)
		
		$t_infoVolumeDatabase:=__ ("* Disco de la base de datos: ")+$t_volumeDatabase+"\r"+\
			__ ("  - Tamaño: ")+String:C10($r_tamaño/1024/1024/1024;"######GB")+"\r"+\
			__ ("  - Utilizado: ")+String:C10($r_usado/1024/1024/1024;"######GB")+"\r"+\
			__ ("  - Disponible: ")+String:C10($r_disponible/1024/1024/1024;"######GB")+"\r"
		
		
		VOLUME ATTRIBUTES:C472($t_volumeBackup;$r_tamaño;$r_usado;$r_disponible)
		$t_infoVolumeBackup:=__ ("* Disco de respaldos: ")+$t_volumeDatabase+"\r"+\
			__ ("  - Tamaño: ")+String:C10($r_tamaño/1024/1024/1024;"######GB")+"\r"+\
			__ ("  - Utilizado: ")+String:C10($r_usado/1024/1024/1024;"######GB")+"\r"+\
			__ ("  - Disponible: ")+String:C10($r_disponible/1024/1024/1024;"######GB")+"\r"
		If ($t_volumeDatabase=$t_volumeBackup)
			$t_infoVolumeBackup:=$t_infoVolumeBackup+"\r"+__ ("¡¡¡ ATENCION !!! \rEl disco de respaldo es el mismo en que se encuentra la base de datos.")+"\r"+\
				__ ("Si el disco llegase a sufrir algún daño los respaldos serán dañados también.")+"\r"+\
				__ ("Le recomendamos encarecidamente considerar respaldar en otro disco")
		End if 
		
		
		$t_asunto:="Respaldo efectuado ["+<>gCustom+"]"
		$t_Cuerpo:=__ ("El respaldo y la compresión se ejecutaron exitosamente.")
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("INFORMACIÓN SOBRE EL RESPALDO")
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Ruta de la base de datos: ")+Data file:C490
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Ruta del respaldo: ")+$t_rutaUltimoRespaldo
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Inicio del respaldo: ")+String:C10($d_creacion;Internal date long:K1:5)+", "+String:C10($h_creacion;HH MM SS:K7:1)
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Término del respaldo: ")+String:C10($d_modificacion;Internal date long:K1:5)+", "+String:C10($h_modificacion;HH MM SS:K7:1)
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Inicio de la compresión: ")+String:C10($d_creacion7z;Internal date long:K1:5)+", "+String:C10($h_creacion7z;HH MM SS:K7:1)
		$t_Cuerpo:=$t_Cuerpo+"\r- "+__ ("Fin de la compresión: ")+String:C10($d_modificacion7z;Internal date long:K1:5)+", "+String:C10($h_modificacion7z;HH MM SS:K7:1)
		
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+("INFORMACIÓN SOBRE LOS DISCOS")
		$t_Cuerpo:=$t_Cuerpo+"\r "+$t_infoVolumeDatabase
		$t_Cuerpo:=$t_Cuerpo+"\r "+$t_infoVolumeBackup
		
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("PROXIMO RESPALDO PROGRAMADO PARA EL: ")+String:C10($d_fechaProximoRespaldo;System date long:K1:3)+" a las "+String:C10($h_horaProximoRespaldo;HH MM SS:K7:1)
		$t_Cuerpo:=$t_Cuerpo+"\r\r\r"+__ ("Versión SchoolTrack: ")+SYS_LeeVersionEstructura +"\r"
	Else 
		
		
		
End case 

$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaCC)
$t_UUID:=NTC_CreaMensaje ("";__ ("Respaldo de base de datos");$t_asunto)
NTC_Mensaje_Texto ($t_UUID;$t_Cuerpo)



