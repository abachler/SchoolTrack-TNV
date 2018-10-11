//%attributes = {}
  // UTIL_ListIPAddresses(->arregloTexto: &Y)
  // devuelve la lista de direcciones IP activas en el computador
  // Por: Alberto Bachler K.: 10-09-15, 19:46:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($l_error;$l_ipAddress;$l_lineas;$l_posicion)
C_POINTER:C301($y_arregloIPAddresses)
C_TEXT:C284($t_err;$t_in;$t_ipAddress;$t_ipAdress;$t_out;$t_serverName)

ARRAY TEXT:C222($at_Lineas;0)
ARRAY TEXT:C222($at_out;0)



If (False:C215)
	C_POINTER:C301(UTIL_ListIPAddresses ;$1)
End if 

$y_arregloIPAddresses:=$1
AT_Initialize ($y_arregloIPAddresses)

If (SYS_IsMacintosh )
	LAUNCH EXTERNAL PROCESS:C811("ifconfig -a -u";$t_in;$t_out;$t_err)
	AT_Text2Array (->$at_Lineas;$t_out;Char:C90(10))
	For ($l_lineas;1;Size of array:C274($at_Lineas))
		If (Position:C15("\tinet ";$at_Lineas{$l_lineas})=1)
			$t_ipAdress:=ST_GetWord ($at_Lineas{$l_lineas};2;" ")
			If (UTIL_isIPAddress ($t_ipAdress))
				If (($t_ipAdress#"127.0@") & (Find in array:C230($y_arregloIPAddresses->;$t_ipAdress)<0))
					APPEND TO ARRAY:C911($y_arregloIPAddresses->;$t_ipAdress)
				End if 
			End if 
		End if 
	End for 
	
Else 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C WMIC /Output:STDOUT NICCONFIG get /all /format:LIST";$t_in;$t_out;$t_err)
	AT_Text2Array (->$at_out;$t_out;"\n")
	$l_posicion:=Find in array:C230($at_out;"IPAddress={@}\r\r";$l_posicion+1)
	While ($l_posicion>0)
		$t_ipAddress:=Substring:C12($at_out{$l_posicion};Length:C16("IPAddress={")+2)
		$t_ipAddress:=ST_GetWord ($t_ipAddress;1;",")
		$t_ipAddress:=Substring:C12($t_ipAddress;1;Length:C16($t_ipAddress)-1)
		If (UTIL_isIPAddress ($t_ipAddress)) & (Find in array:C230($y_arregloIPAddresses->;$t_ipAddress)<0)
			APPEND TO ARRAY:C911($y_arregloIPAddresses->;$t_ipAddress)
		End if 
		$l_posicion:=Find in array:C230($at_out;"IPAddress={@}\r\r";$l_posicion+1)
	End while 
End if 