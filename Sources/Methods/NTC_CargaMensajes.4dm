//%attributes = {}
  // NTC_CargaMensajes()
  // Busca, carga los encabezados de mensajes en arreglos y configura el area de despliegue de las notificaciones
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 11:30:17
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_displayOptions;$l_userID)
C_TIME:C306($h_time)
C_TEXT:C284($t_userIdSegment)

ARRAY DATE:C224($ad_fechaMensajes;0)
ARRAY LONGINT:C221($al_HoraCreacion;0)
ARRAY TEXT:C222($at_Encabezados;0)
ARRAY TEXT:C222($at_modules;0)
If (False:C215)
	C_LONGINT:C283(NTC_CargaMensajes ;$1)
End if 



  // CÓDIGO
If (Count parameters:C259=1)
	$l_displayOptions:=$1  //(0: ultimos sesenta dias no resueltos; 1 todos los mios no resueltos; 2 resueltos; 3, todos)
End if 
vl_displayOptions:=$l_displayOptions

$l_userID:=USR_GetUserID 
READ ONLY:C145([NTC_Notificaciones:190])

  // leo en el registro del usuario las referencias de los módulos para los que recibe notificaciones
KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_userID)
For ($i;1;Size of array:C274(<>alXS_ModuleRef))
	If ([xShell_Users:47]ReceiveNotifications_Modules:22 ?? <>alXS_ModuleRef{$i})  //si el bit correspondiente a la referencia del módulo está encendido
		APPEND TO ARRAY:C911($at_modules;<>atXS_ModuleNames{$i})  // agrego el nombre del módulo a un arreglo
	End if 
End for 

  // busco las notificaciones creadas en los últimos 60 días para los modulos que están habilitados en la cuenta del usuario
Case of 
	: ($l_displayOptions=0)
		QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Fecha_creacion:2;>=;Current date:C33-60)
	: ($l_displayOptions=3)
		ALL RECORDS:C47([NTC_Notificaciones:190])
	: ($l_displayOptions=2)
		QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Resuelto:22=True:C214)
	: ($l_displayOptions=1)
		REDUCE SELECTION:C351([NTC_Notificaciones:190];0)
End case 
CREATE SET:C116([NTC_Notificaciones:190];"Notificaciones")

If ($l_userID>0)
	QUERY SELECTION WITH ARRAY:C1050([NTC_Notificaciones:190]Explorador_modulo:13;$at_modules)
	CREATE SET:C116([NTC_Notificaciones:190];"NotificacionesModulos")
	
	USE SET:C118("Notificaciones")
	QUERY SELECTION:C341([NTC_Notificaciones:190];[NTC_Notificaciones:190]Explorador_modulo:13="")
	CREATE SET:C116([NTC_Notificaciones:190];"NotificacionesGenericas")
	
	UNION:C120("NotificacionesModulos";"NotificacionesGenericas";"Notificaciones")
	USE SET:C118("Notificaciones")
End if 
CREATE SET:C116([NTC_Notificaciones:190];"forAllAuthorized")

If (($l_userID>0) | ($l_displayOptions=1))
	QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Fecha_creacion:2;>=;Current date:C33-60;*)
	QUERY:C277([NTC_Notificaciones:190]; & ;[NTC_Notificaciones:190]Destinatario_ID:4=$l_userID)
	CREATE SET:C116([NTC_Notificaciones:190];"ForCurrentUser")
Else 
	CREATE EMPTY SET:C140([NTC_Notificaciones:190];"ForCurrentUser")
End if 

UNION:C120("forAllAuthorized";"ForCurrentUser";"Notifications")
USE SET:C118("Notifications")


If ($l_displayOptions<2)
	QUERY SELECTION:C341([NTC_Notificaciones:190];[NTC_Notificaciones:190]Resuelto:22=False:C215)
End if 

ALP_RemoveAllArrays (xALP_Mensajes)
ORDER BY:C49([NTC_Notificaciones:190];[NTC_Notificaciones:190]OrdenCreacion:16;<)
SELECTION TO ARRAY:C260([NTC_Notificaciones:190]Auto_UUID:1;at_UUID_mensaje;[NTC_Notificaciones:190]Lectores:11;at_Lectores;[NTC_Notificaciones:190]Encabezado:12;$at_Encabezados;[NTC_Notificaciones:190]Fecha_creacion:2;$ad_fechaMensajes;[NTC_Notificaciones:190]Hora_creacion:3;$al_HoraCreacion)
ARRAY TEXT:C222(at_titulosMensajes;Size of array:C274($at_Encabezados))
ARRAY TEXT:C222(at_fechaHora;Size of array:C274($at_Encabezados))
For ($i;1;Size of array:C274($at_Encabezados))
	  //at_titulosMensajes{$i}:=String($ad_fechaMensajes{$i};System date short)+", "+Time string($al_HoraCreacion{$i})+"\r"+$at_Encabezados{$i}
	at_titulosMensajes{$i}:=$at_Encabezados{$i}
	Case of 
		: ($ad_fechaMensajes{$i}=Current date:C33(*))
			$h_time:=$al_HoraCreacion{$i}
			at_fechaHora{$i}:=String:C10($h_time;HH MM:K7:2)
		: ($ad_fechaMensajes{$i}=(Current date:C33(*)-1))
			at_fechaHora{$i}:=__ ("ayer")
		: ($ad_fechaMensajes{$i}=(Current date:C33(*)-2))
			at_fechaHora{$i}:=__ ("antes de ayer")
		Else 
			at_fechaHora{$i}:=String:C10($ad_fechaMensajes{$i};System date short:K1:1)
	End case 
End for 

ALP_DefaultColSettings (xALP_Mensajes;1;"at_titulosMensajes";"";240)
ALP_DefaultColSettings (xALP_Mensajes;2;"at_fechaHora";"";60)
ALP_DefaultColSettings (xALP_Mensajes;3;"at_UUID_mensaje";"")
ALP_DefaultColSettings (xALP_Mensajes;5;"at_lectores";"")

ALP_SetDefaultAppareance (xALP_Mensajes;11;3)
AL_SetBackRGBColor (xALP_Mensajes;0;0;0;0;255;255;255;255;255;255)
AL_SetAltRowColor (xALP_Mensajes;255;255;255;1)
AL_SetBackColor (xALP_Mensajes;0;"White";0;"White";0;"White";0)
AL_SetMiscOpts (xALP_Mensajes;1;0;"\\";0;1)

AL_SetSortOpts (xALP_Mensajes;0;0;0;"";0)
AL_SetColOpts (xALP_Mensajes;0;0;0;2;0;0;0)
AL_SetScroll (xALP_Mensajes;-2;-3)
AL_SetStyle (xALP_Mensajes;1;"Tahoma";11;Bold:K14:2)
AL_SetForeColor (xALP_Mensajes;2;"";0;"Blue")
AL_SetFormat (xALP_Mensajes;2;"";3)
AL_SetDividers (xALP_Mensajes;"";"White";0;"Black";"Light Gray";0)
AL_SetInterface (xALP_Mensajes;0;0;0;0;0;1;0;0)
AL_SetRowOpts (xALP_Mensajes;0;1;0;0;0)

$t_userIdSegment:="."+String:C10(USR_GetUserID )+"."
For ($i;1;Size of array:C274(at_titulosMensajes))
	Case of 
		: (Position:C15($t_userIdSegment;at_lectores{$i})=0)
			AL_SetRowStyle (xALP_Mensajes;$i;Bold:K14:2)
		Else 
			AL_SetRowStyle (xALP_Mensajes;$i;Plain:K14:1)
	End case 
End for 

AL_SetLine (xALP_Mensajes;0)
vt_UUIDmensaje:=""
NTC_ConfiguraAreaMensaje 

