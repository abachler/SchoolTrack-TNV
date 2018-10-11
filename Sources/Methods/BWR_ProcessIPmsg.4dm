//%attributes = {}
  // BWR_ProcessIPmsg()
  //
  // DESCRIPCIÓN:
  // Procesa en el explorador los mensajes recibidos desde otros proceso.
  // PARÁMETROS:
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 09:27:54
  // ---------------------------------------------
C_LONGINT:C283($l_IPmsg_objectRef;$l_Messages;$i)
C_TEXT:C284($t_IPmsgTextParameter;$t_IPmsgUUID;$t_MSG_uuid;$t_tabLabel;$t_uuid)

ARRAY LONGINT:C221($al_IP_SenderProcess;0)
ARRAY LONGINT:C221($al_recordNumbers;0)
ARRAY TEXT:C222($at_IP_Message;0)
ARRAY TEXT:C222($at_IP_UUID;0)

  // CÓDIGO

  // obtengo la cola de mensajes recibidos por el proceso actual
$l_Messages:=IP_GetMessageQueue (->$at_IP_UUID;->$at_IP_Message;->$al_IP_SenderProcess)

For ($i;1;$l_Messages)
	$t_IPmsgUUID:=$at_IP_UUID{$i}  // obtengo el UUID del mensaje recibido
	$t_IPmsgTextParameter:=IP_GetTextParameter ($t_IPmsgUUID)  // obtengo el parametro texto del mensaje
	$l_IPmsgObjectRef:=IP_GetParameterObjectRef ($t_IPmsgUUID)  // obtengo la referencia a un objeto ObjectTools con parametros de distintos a tipos
	IP_DeleteFromQueue ($t_IPmsgUUID)
	
	Case of 
		: ($at_IP_Message{$i}="CloseSesion")
			  // instalar aqui la gestión de cierre de sesión por mensaje directo
			
			
			
			
		: ($at_IP_Message{$i}="NTC_NuevoMensaje")
			BWR_NotificationMailboxStatus 
			
			
			
			
		: ($at_IP_Message{$i}="NTC_MuestraDatosEnExplorador")
			$t_notificationUUID:=$t_IPmsgTextParameter
			KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_notificationUUID)
			If (vsBWR_CurrentModule=[NTC_Notificaciones:190]Explorador_modulo:13)
				$t_tabLabel:=HL_FindInListByReference (vlXS_BrowserTab;[NTC_Notificaciones:190]Explorador_pestaña:14)
				If ($t_tabLabel#"")
					If ([NTC_Notificaciones:190]Explorador_ejecutarAntes:20#"")
						EXECUTE METHOD:C1007([NTC_Notificaciones:190]Explorador_ejecutarAntes:20)
					End if 
					yBWR_currentTable:=Table:C252([NTC_Notificaciones:190]Explorador_pestaña:14)
					If (BLOB size:C605([NTC_Notificaciones:190]Explorador_registros:15)>0)
						BLOB_Blob2Vars (->[NTC_Notificaciones:190]Explorador_registros:15;0;->$al_recordNumbers)
						REDUCE SELECTION:C351(yBWR_currentTable->;0)
						CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;$al_recordNumbers)
						CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
						SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;[NTC_Notificaciones:190]Explorador_pestaña:14)
						GET LIST ITEM:C378(vlXS_BrowserTab;Selected list items:C379(vlXS_BrowserTab);vlBWR_SelectedTableRef;vsBWR_selectedTableName)
						BWR_PanelSettings 
						BWR_SelectTableData 
						
						XS_SetInterface 
						ALP_SetInterface (xALP_Browser)
						BWR_SetWindowTitle 
					End if 
					
					If ([NTC_Notificaciones:190]Explorador_ejecutarDespues:21#"")
						EXECUTE METHOD:C1007([NTC_Notificaciones:190]Explorador_ejecutarDespues:21)
					End if 
				End if 
			End if 
	End case 
End for 

