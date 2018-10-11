//%attributes = {}
  // MÉTODO: FTP_DeleteObject
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 14/06/11, 14:50:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // FTP_CIM_DeleteObject()
  // ----------------------------------------------------



  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($l_ConnexionID;$l_error;$l_objectType)
C_TEXT:C284($t_Client;$t_path)
$l_ConnexionID:=$1
$t_path:=$2
$l_objectType:=$3
$t_URl:=$4
$t_login:=$5
$t_Password:=$6


If (Count parameters:C259=7)
	$t_Client:=$7
End if 

If ($t_path="")
	$t_path:="/"
End if 

  // CODIGO PRINCIPAL
$t_ObjectName:="\""+ST_GetWord ($t_path;ST_CountWords ($t_path;0;"/");"/")+"\""
$l_error:=FTP_VerifyConexionStatus ($l_ConnexionID;$t_URl;$t_login;$t_Password;->$l_ConnexionID)
$l_ConnexionID:=vlFTP_ConectionID
If ($l_error#0)
	CD_Dlog (0;__ ("No fue posible establecer la conexión al servidor FTP"))
Else 
	If ($l_objectType=0)
		$l_error:=FTP_Delete ($l_ConnexionID;$t_path)
		$t_message:=__ ("El documento ")+$t_ObjectName+__ (" fue eliminado en el FTP")
	Else 
		$l_error:=FTP_RemoveDir ($l_ConnexionID;$t_path)
		$t_message:=__ ("La carpeta ")+$t_ObjectName+__ (" y su contenido fue eliminada en el FTP")
	End if 
	
	If ($l_error#0)
		$t_error:=IT_ErrorText ($l_error)
		$t_message:=__ ("No fue posible eliminar el archivo. El servidor FTP respondió: \r\r")+$t_error
		CD_Dlog (0;$t_message)
	Else 
		Notificacion_Mostrar (__ ("Eliminación de documentos en FTP");$t_Message)
	End if 
End if 