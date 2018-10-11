//%attributes = {}
  // ERR_LogExecutionError({uuidError:Y}) --> mensaje de error en texto enriquecido
  // almacena detalles del error en la tabla [xShell_ExecutionErrors], incluyendo la pila del error
  // en uuidError, pasado como puntero, devuelve el uuid del registro de error
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 18:55:31
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_hasErrorFormula)
C_DATE:C307($d_Date)
C_LONGINT:C283($l_build;$l_error;$l_errores)
C_TIME:C306($h_hora)
C_POINTER:C301($y_ObjetoErrorStack)
C_POINTER:C301($y_uuidError)
C_TEXT:C284($t_componente;$t_mensaje;$t_mensajeError;$t_metodo;$t_version)
C_OBJECT:C1216($o_error;$o_errorStack)

ARRAY LONGINT:C221($al_errorCodes;0)
ARRAY LONGINT:C221($i;0)
ARRAY TEXT:C222($at_componentes;0)
ARRAY TEXT:C222($at_mensajes;0)
ARRAY OBJECT:C1221($ao_errorStack;0)


If (False:C215)
	C_TEXT:C284(ERR_LogExecutionError ;$0)
End if 


$t_version:=Application version:C493($l_build)

$d_Date:=Current date:C33
$h_hora:=Current time:C178
GET LAST ERROR STACK:C1015($al_errorCodes;$at_componentes;$at_mensajes)

$l_errores:=Size of array:C274($al_errorCodes)
If ($l_errores>0)
	For ($i;1;Size of array:C274($al_errorCodes))
		$o_error:=OB_Create 
		$l_error:=$al_errorCodes{$i}
		$t_componente:=$at_componentes{$i}
		$t_mensaje:=$at_mensajes{$i}
		OB_SET ($o_error;->$t_componente;"component")
		OB_SET ($o_error;->$l_error;"error_Id")
		OB_SET ($o_error;->$t_mensaje;"error_Message")
		APPEND TO ARRAY:C911($ao_errorStack;$o_error)
	End for 
	$o_errorStack:=OB_Create 
	OB_SET ($o_errorStack;->$ao_errorStack;"errorStack")
End if 


$t_metodo:=IT_SetTextStyle_Bold (->ERROR METHOD)
$t_metodo:=IT_SetTextStyle_Italic (->$t_metodo)
$t_metodo:=IT_SetTextColor_Hexa (->$t_metodo;color RGB darkblue)
$t_mensajeError:=__ ("ERROR ^0 en línea ^1 durante la ejecución del método:\r\r^2\rComando: ^3:\r")
$t_mensajeError:=Replace string:C233($t_mensajeError;"^0";String:C10(ERROR))
$t_mensajeError:=Replace string:C233($t_mensajeError;"^1";String:C10(ERROR LINE))
$t_mensajeError:=Replace string:C233($t_mensajeError;"^2";$t_metodo)
$t_mensajeError:=Replace string:C233($t_mensajeError;"^3";ERROR FORMULA)
If ($l_errores>0)
	$t_mensaje:=$at_mensajes{$l_errores}
	$t_mensajeError:=$t_mensajeError+"\r"+IT_SetTextStyle_Bold (->$t_mensaje)
End if 

REDUCE SELECTION:C351([xShell_ExecutionErrors:196];0)
CREATE RECORD:C68([xShell_ExecutionErrors:196])
[xShell_ExecutionErrors:196]method:3:=ERROR METHOD
[xShell_ExecutionErrors:196]error_formula:7:=ERROR FORMULA
[xShell_ExecutionErrors:196]line:2:=ERROR LINE
[xShell_ExecutionErrors:196]error_date:8:=Current date:C33(*)
[xShell_ExecutionErrors:196]error_hour:9:=Current time:C178(*)
[xShell_ExecutionErrors:196]errorStack:6:=$o_errorStack
[xShell_ExecutionErrors:196]mensajeError:4:=$t_mensajeError
[xShell_ExecutionErrors:196]machineName:5:=Current machine:C483
[xShell_ExecutionErrors:196]user_SessionName:10:=Current system user:C484
[xShell_ExecutionErrors:196]user_Name:11:=Choose:C955(Application type:C494=4D Server:K5:6;"server";<>tUSR_CurrentUserName)
SAVE RECORD:C53([xShell_ExecutionErrors:196])
If (Not:C34(Is nil pointer:C315($y_uuidError)))
	$y_uuidError->:=[xShell_ExecutionErrors:196]auto_uuid:1
End if 
UNLOAD RECORD:C212([xShell_ExecutionErrors:196])


$0:=$t_mensajeError







