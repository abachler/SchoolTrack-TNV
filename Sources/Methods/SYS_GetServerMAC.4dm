//%attributes = {"executedOnServer":true}
  // SYS_GetServerMAC()
  // Por: Alberto Bachler K.: 10-03-14, 16:55:37
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_encontrado)
C_LONGINT:C283($l_inicio)
C_POINTER:C301($y_MacAddress)
C_TEXT:C284($t_LEPentrada;$t_LEPretorno;$t_macAddress;$t_patronRegex)

ARRAY LONGINT:C221($al_largoCadena;0)
ARRAY LONGINT:C221($al_posicionInicio;0)
ARRAY TEXT:C222($at_macAddress;0)


If (False:C215)
	C_TEXT:C284(SYS_MACaddressList ;$0)
	C_POINTER:C301(SYS_MACaddressList ;$1)
End if 


$y_MacAddress:=$1

If (SYS_IsMacintosh )
	$t_LEPentrada:=" "
	LAUNCH EXTERNAL PROCESS:C811("/sbin/ifconfig -a";$t_LEPentrada;$t_LEPretorno)
	$t_patronRegex:="([0-9a-f]{1,2}:){5,13}[0-9a-f]{1,2}"
	$l_inicio:=1
Else 
	$t_LEPentrada:=""
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C ipconfig /ALL";$t_LEPentrada;$t_LEPretorno)
	$t_patronRegex:="([0-9A-F]{2}-){5,13}[0-9A-F]{2}"
	$l_inicio:=1
End if 

Repeat 
	$b_encontrado:=Match regex:C1019($t_patronRegex;$t_LEPretorno;$l_inicio;$al_posicionInicio;$al_largoCadena)
	If ($b_encontrado)
		$l_inicio:=$al_posicionInicio{0}+$al_largoCadena{0}
		$t_macAddress:=Substring:C12($t_LEPretorno;$al_posicionInicio{0};$al_largoCadena{0})
		$t_macAddress:=Replace string:C233($t_macAddress;"-";":")
		Case of 
			: ($t_macAddress="00:00:00:00:00:00@")
				  // mac inválida
			: (Length:C16($t_macAddress)>17)
				  // mac inválida
			: (Length:C16($t_macAddress)<17)
				  // mac inválida
			Else 
				APPEND TO ARRAY:C911($at_macAddress;$t_macAddress)
		End case 
	End if 
Until (Not:C34($b_encontrado))

If (Size of array:C274($at_macAddress)>0)
	COPY ARRAY:C226($at_macAddress;$y_MacAddress->)
	$0:=$y_MacAddress->{1}
End if 