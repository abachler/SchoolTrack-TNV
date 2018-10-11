//%attributes = {"executedOnServer":true}
  // UD_v20140106_AsignaAutoUUID()
  // Por: Alberto Bachler K.: 06-01-14, 12:49:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  // UD_v20140106_AsignaAutoUUID()
  // Por: Alberto Bachler K.: 06-01-14, 12:49:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($b_Guardar)
_O_C_INTEGER:C282($i_campos;$i_registros;$i_tablas)
C_LONGINT:C283($l_idTermometro;$l_registros;$l_ultimaTabla)
C_POINTER:C301($y_campo;$y_tabla)
C_TEXT:C284($t_nombreCampo;$t_nombreTabla;$t_uuid)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_UUID;0)

<>vb_ImportHistoricos_STX:=True:C214
$sn3_NoMarcar:=<>SN3_NoMarcar
<>SN3_NoMarcar:=True:C214


$l_ultimaTabla:=Get last table number:C254
$l_totalRegistros:=0
For ($i_tablas;1;$l_ultimaTabla)
	If (Is table number valid:C999($i_tablas))
		$l_totalRegistros:=$l_totalRegistros+Records in table:C83(Table:C252($i_tablas)->)
	End if 
End for 
$l_registrosProcesados:=0

$l_ultimaTabla:=Get last table number:C254
  //$l_idTermometro:=IT_Progress (1;0;0;0;0;"Estableciendo llaves primarias en la tabla ...")
$l_idTermometro:=IT_Progress (1;0;0;"";0;"Estableciendo llaves primarias en la tabla ...")
For ($i_tablas;1;$l_ultimaTabla)
	
	If (Is table number valid:C999($i_tablas))
		$t_nombreTabla:=Table name:C256($i_tablas)
		For ($i_campos;1;Get last field number:C255($i_tablas))
			If (Is field number valid:C1000($i_tablas;$i_campos))
				$t_nombreCampo:=Field name:C257($i_tablas;$i_campos)
				
				If ($t_nombreCampo="Auto_UUID")
					$y_tabla:=Table:C252($i_tablas)
					$y_campo:=Field:C253($i_tablas;$i_Campos)
					ALL RECORDS:C47($y_tabla->)
					LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_RecNums;"")
					$l_registros:=Size of array:C274($al_RecNums)
					For ($i_registros;1;$l_registros)
						READ WRITE:C146($y_tabla->)
						GOTO RECORD:C242($y_tabla->;$al_RecNums{$i_registros})
						$b_Guardar:=False:C215
						$t_uuid:=$y_campo->
						$t_uuidInvalido:=$t_uuid
						Case of 
							: ($t_uuid="")
								$t_uuid:=Generate UUID:C1066
								$b_Guardar:=True:C214
							: ($t_uuid="0000000@")
								$t_uuid:=Generate UUID:C1066
								$b_Guardar:=True:C214
							: ($t_uuid="20202020@")
								$t_uuid:=Generate UUID:C1066
								$b_Guardar:=True:C214
							: ($t_uuid="@-@")
								$t_uuid:=Replace string:C233($t_uuid;"-";"")
								$b_Guardar:=True:C214
							: (KRL_RecordExists ($y_campo))
								$t_uuid:=Generate UUID:C1066
								$b_Guardar:=True:C214
						End case 
						If ($b_guardar)
							$y_campo->:=$t_uuid
							SAVE RECORD:C53($y_tabla->)
						End if 
						If (Dec:C9($i_Registros/1000)=0)
							$l_registrosProcesados:=$l_registrosProcesados+1000
							$t_mensajeBarra1:="Estableciendo llaves primarias..."+"...\r"+String:C10($l_registrosProcesados;"### ### ###")+" sobre "+String:C10($l_totalRegistros;"### ### ###")+" registros en la base de datos."
							$t_mensajeBarra2:=$t_nombreTabla+"\r"+String:C10($i_registros;"### ### ###")+" sobre "+String:C10($l_registros;"### ### ###")+" registros en la tabla "
							$l_idTermometro:=IT_Progress (0;$l_idTermometro;$l_registrosProcesados/$l_totalRegistros;$t_mensajeBarra1;$i_registros/$l_registros;$t_mensajeBarra2)
						End if 
					End for 
					KRL_UnloadReadOnly ($y_tabla)
					$i_campos:=Get last field number:C255($i_tablas)
				End if 
			End if 
		End for 
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

<>vb_ImportHistoricos_STX:=False:C215
<>SN3_NoMarcar:=$sn3_NoMarcar



