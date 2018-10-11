//%attributes = {"publishedSoap":true,"executedOnServer":true}
  // VC4Dws_UpdateMethod()
  // Por: Alberto Bachler K.: 01-10-14, 08:34:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_BLOB:C604($1)

C_BLOB:C604($x_code;$x_data;$x_respuesta)
C_OBJECT:C1216($o_atributos;$o_parametros;$o_Retorno)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_currentUserID;$l_errorCode;$l_pathType;$l_resultado;$l_UserID)
C_TIME:C306($h_hora)
C_POINTER:C301($y_tablePointer)
C_TEXT:C284($t_code;$t_comments;$t_currentOnErrCall;$t_dts;$t_dtsIntegracion;$t_error;$t_formObjectName;$t_objectName;$t_password;$t_path)
C_TEXT:C284($t_UserName)


If (False:C215)
	C_BLOB:C604(VC4Dws_UpdateMethod ;$0)
	C_BLOB:C604(VC4Dws_UpdateMethod ;$1)
End if 

SOAP DECLARATION:C782($1;Is BLOB:K8:12;SOAP input:K46:1;"data")
SOAP DECLARATION:C782($0;Is BLOB:K8:12;SOAP output:K46:2;"output")
  //$t_json:=$1
  //BASE64 DECODE($t_json;$x_data)
  //$l_HLcrypt:=Load list("Crypt")
  //GET LIST ITEM PARAMETER($l_HLcrypt;2;"pub";$t_llavePublica)
  //TEXT TO BLOB($t_llavePublica;$x_llavePublica;UTF8 text without length)
  //DECRYPT BLOB($x_data;$x_llavePublica)


$x_data:=$1
$l_resultado:=OB_BlobToObject (->$x_data;->$o_parametros)
OB_GET ($o_parametros;->$t_UserName;"user")
OB_GET ($o_parametros;->$t_password;"passw")
OB_GET ($o_parametros;->$t_path;"path")
OB_GET ($o_parametros;->$t_code;"code")
OB_GET ($o_parametros;->$t_dts;"dts")
OB_GET ($o_Parametros;->$o_atributos;"atributos")
OB_GET ($o_Parametros;->$t_comments;"comentarios")


  //$t_code:=BLOB to text($x_code;UTF8 text without length)

  //TRACE
$l_currentUserID:=<>lUSR_CurrentUserID
If (USR_IsSuperUser ($t_UserName;$t_password))
	$l_UserID:=<>lUSR_CurrentUserID
	If (($l_UserID>-99) & ($l_UserID<0))
		$t_currentOnErrCall:=Method called on error:C704
		ON ERR CALL:C155("ERR_EventoError")
		METHOD RESOLVE PATH:C1165($t_path;$l_pathType;$y_tablePointer;$t_objectName;$t_formObjectName;*)
		METHOD GET MODIFICATION DATE:C1170($t_path;$d_fecha;$h_hora;*)
		
		Case of 
			: (error=0)
				METHOD SET CODE:C1194($t_path;$t_code;*)
				METHOD SET ATTRIBUTES:C1335($t_path;$o_atributos;*)
				METHOD SET COMMENTS:C1193($t_path;$t_comments;*)
				
			: (error#0)
				Case of 
					: ($l_pathType=Path project method:K72:1)
						error:=0
						METHOD SET CODE:C1194($t_path;$t_code;*)
						METHOD SET ATTRIBUTES:C1335($t_path;$o_atributos;*)
						METHOD SET COMMENTS:C1193($t_path;$t_comments;*)
					: (($l_pathType=Path database method:K72:2) | ($l_pathType=Path trigger:K72:4))
						error:=0
						METHOD SET CODE:C1194($t_path;$t_code;*)
						METHOD SET COMMENTS:C1193($t_path;$t_comments;*)
				End case 
			Else 
				  //METHOD SET CODE($t_path;$t_codeCurrent;*)
		End case 
		
		
		If (error=0)
			METHOD GET MODIFICATION DATE:C1170($t_path;$d_fecha;$h_hora;*)
			$t_dtsIntegracion:=String:C10($d_fecha;ISO date:K1:8;$h_hora)
			VC4D_SaveMethod_onServer ($t_path;$t_code;$t_UserName;$t_dtsIntegracion)
		Else 
			  //TRACE
			$l_errorCode:=error
			Case of 
				: (error=-9776)
					$t_error:="Unable to create method: "+$t_path
				: (error=-9775)
					$t_error:="Unable to write method code"+$t_path
				: (error=-9774)
					$t_error:="Unable to read method code: "+$t_path
				: (error=-9768)
					$t_error:="Invalid object path: "+$t_path
				: (error=-9767)
					$t_error:="Cannot update methods. One or more resources are locked"
				: (error=-9766)
					$t_error:="The method is currently being edited"
				Else 
					$t_error:="Unknown error"
			End case 
		End if 
	Else 
		$t_error:="user no allowed to write code"
		$l_errorCode:=-2
	End if 
Else 
	$t_error:="unknown user"
	$l_errorCode:=-1
End if 
ON ERR CALL:C155($t_currentOnErrCall)


If (Error#0)
	Case of 
		: (Error=-9768)
			$t_error:=__ ("El objeto no existe en el formulario.")
			$l_errorCode:=Error
	End case 
Else 
	
	
	  //$t_rutaVC4D:=VC4D_GetDBPath
	
	  //Begin SQL
	  //USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
	  //End SQL
	
	  //Begin SQL
	  //select auto_uuid from VC4D_Metodos
	  //where ruta=:$t_path into :$t_uuidMetodo;
	
	  //UPDATE VC4D_Metodos
	  //SET code=$t_code,  Where auto_uuid=:$t_uuidMetodo;
	
	  //Insert VC4D_HistorialCambios
	  //SET commited=True,  Where uuid_metodo=:$t_uuidMetodo and commited=False;
	
	  //End SQL
	
	
	  //Begin SQL
	  //USE DATABASE SQL_INTERNAL;
	  //End SQL
	
	  //VC4D_SetCommited
	
End if 
$o_Retorno:=OB_Create 
OB_SET ($o_Retorno;->$t_dtsIntegracion;"dtsIntegration")
OB_SET ($o_Retorno;->$t_error;"errorText")
OB_SET ($o_Retorno;->$l_errorCode;"errorCode")
OB_ObjectToBlob (->$o_Retorno;->$x_respuesta)

$0:=$x_respuesta





