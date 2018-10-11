//%attributes = {}
  // 4D_CMD_Nombres_y_Ids()
  // Por: Alberto Bachler: 24/02/13, 09:26:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_IdComando;$l_ultimoID)
C_POINTER:C301($y_IdsComandos_al;$y_nombresComandos_at)
C_TEXT:C284($t_nombreComando)

If (False:C215)
	C_POINTER:C301(4D_CMD_Nombres_y_Ids ;$1)
	C_POINTER:C301(4D_CMD_Nombres_y_Ids ;$2)
End if 

$y_nombresComandos_at:=$1
$y_IdsComandos_al:=$2

$l_ultimoID:=4D_Comandos_ultimoID
For ($l_IdComando;1;$l_ultimoID)
	$t_nombreComando:=Command name:C538($l_IdComando)
	If ($t_nombreComando#"")
		APPEND TO ARRAY:C911($y_nombresComandos_at->;$t_nombreComando)
		APPEND TO ARRAY:C911($y_IdsComandos_al->;$l_IdComando)
	End if 
End for 

