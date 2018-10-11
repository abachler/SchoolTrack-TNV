//%attributes = {}
  // WSexe_EnviaScript_out()
  // Por: Alberto Bachler: 02/05/13, 09:31:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284(${3})

C_BLOB:C604($x_Blob)
C_LONGINT:C283($i_dia;$i_elemento;$i_mes;$l_IdScript;$l_mes;$l_numeroDia;$l_numeroMes;$l_ultimoDia)
C_TEXT:C284($t_NombreScript;$t_Parametro;$t_TextoError;$t_textoScript)

ARRAY TEXT:C222($at_DiasEjecucion;0)
If (False:C215)
	C_LONGINT:C283(WSexe_EnviaScript_out ;$0)
	C_TEXT:C284(WSexe_EnviaScript_out ;$1)
	C_TEXT:C284(WSexe_EnviaScript_out ;$2)
	C_TEXT:C284(WSexe_EnviaScript_out ;${3})
End if 

$t_NombreScript:=$1
$t_textoScript:=$2

If (($t_nombreScript#"") & ($t_textoScript#""))
	
	If (Count parameters:C259>2)
		For ($i_elemento;3;Count parameters:C259)
			$t_Parametro:=${$i_elemento}
			$l_numeroMes:=Num:C11(ST_GetWord ($t_parametro;1;"/"))
			$l_numeroDia:=Num:C11(ST_GetWord ($t_parametro;2;"/"))
			Case of 
				: (($l_numeroMes=0) & ($l_numeroDia=0))
					For ($i_mes;1;12)
						$l_ultimoDia:=DT_GetLastDay ($l_mes;Year of:C25(Current date:C33(*)))
						For ($i_dia;1;$l_ultimoDia)
							APPEND TO ARRAY:C911($at_DiasEjecucion;String:C10($i_mes)+"/"+String:C10($i_dia))
						End for 
					End for 
				: (($l_numeroMes#0) & ($l_numeroDia=0))
					$l_ultimoDia:=DT_GetLastDay ($l_mes;Year of:C25(Current date:C33(*)))
					For ($i_dia;1;$l_ultimoDia)
						APPEND TO ARRAY:C911($at_DiasEjecucion;String:C10($i_mes)+"/"+String:C10($i_dia))
					End for 
				: (($l_numeroMes=0) & ($l_numeroDia#0))
					For ($i_mes;1;12)
						$l_ultimoDia:=DT_GetLastDay ($l_mes;Year of:C25(Current date:C33(*)))
						If ($l_numeroDia<=$l_ultimoDia)
							APPEND TO ARRAY:C911($at_DiasEjecucion;String:C10($i_mes)+"/"+String:C10($l_numeroDia))
						End if 
					End for 
				: (($l_numeroMes#0) & ($l_numeroDia#0))
					APPEND TO ARRAY:C911($at_DiasEjecucion;$t_Parametro)
			End case 
		End for 
	End if 
	
	BLOB_Variables2Blob (->$x_Blob;0;->$at_DiasEjecucion)
	
	
	WS_InitWebServicesVariables 
	WEB SERVICE SET PARAMETER:C777("nombre";$t_nombreScript)
	WEB SERVICE SET PARAMETER:C777("script";$t_textoScript)
	WEB SERVICE SET PARAMETER:C777("xDays";$x_Blob)
	WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;300)
	$t_TextoError:=WS_CallIntranetWebService ("WSexe_RecibeScript_in")
	
	If ($t_TextoError="")
		WEB SERVICE GET RESULT:C779($l_IdScript;"id_script";*)
	Else 
		ALERT:C41("El script no pudo ser enviado a causa de un error:\r"+$t_TextoError)
	End if 
	
	$0:=$l_IdScript
	
End if 
