//%attributes = {}
  // MÉTODO:BWR_NotificationMailboxStatus
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/06/12, 15:28:43
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // BWR_NotificationMailboxStatus()
  // ----------------------------------------------------
C_LONGINT:C283($l_userID;$i)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_modules;0)




  // CODIGO PRINCIPAL
$l_userID:=USR_GetUserID 
$b_esAdministrador:=USR_IsGroupMember_by_GrpID (-15001)
READ ONLY:C145([NTC_Notificaciones:190])
If ($l_userID<0)
	QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Fecha_creacion:2;>=;Current date:C33-60)
Else 
	  // leo en el registro del usuario las referencias de los módulos para los que recibe notificaciones
	KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_userID)
	For ($i;1;Size of array:C274(<>alXS_ModuleRef))
		If ([xShell_Users:47]ReceiveNotifications_Modules:22 ?? <>alXS_ModuleRef{$i})  //si el bit correspondiente a la referencia del módulo está encendido
			APPEND TO ARRAY:C911($at_modules;<>atXS_ModuleNames{$i})  // agrego el nombre del módulo a un arreglo
		End if 
	End for 
	
	  // busco las notificaciones creadas en los últimos 60 días para los modulos que están habilitados en la cuenta del usuario
	QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Fecha_creacion:2;>=;Current date:C33-60)
	QUERY SELECTION WITH ARRAY:C1050([NTC_Notificaciones:190]Explorador_modulo:13;$at_modules)
	CREATE SET:C116([NTC_Notificaciones:190];"forAllAuthorized")
	
	QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Fecha_creacion:2;>=;Current date:C33-60;*)
	QUERY:C277([NTC_Notificaciones:190]; & ;[NTC_Notificaciones:190]Destinatario_ID:4=$l_userID)
	CREATE SET:C116([NTC_Notificaciones:190];"ForCurrentUser")
	
	UNION:C120("forAllAuthorized";"ForCurrentUser";"Notifications")
	USE SET:C118("Notifications")
	
End if 


If ((Size of array:C274($at_modules)>0) | (Records in set:C195("ForCurrentUser")>0) | ($l_userID<0) | ($b_esAdministrador))
	OBJECT SET VISIBLE:C603(*;"P1_Notificationmailbox@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"P1_Notificationmailbox@";False:C215)
End if 

vl_numMensajes:=0
ARRAY LONGINT:C221($al_recNums;0)
LONGINT ARRAY FROM SELECTION:C647([NTC_Notificaciones:190];$al_recNums;"")
For ($i;1;Size of array:C274($al_recNums))
	GOTO RECORD:C242([NTC_Notificaciones:190];$al_recNums{$i})
	If (Position:C15("."+String:C10($l_userID)+".";[NTC_Notificaciones:190]Lectores:11)=0)
		vl_numMensajes:=vl_numMensajes+1
	End if 
End for 

SET_ClearSets ("forAllAuthorized";"ForCurrentUser";"Notifications")
OBJECT SET VISIBLE:C603(*;"P1_newNotifications@";(vl_numMensajes>0))

