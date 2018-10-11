//%attributes = {}
  // MÉTODO: UD_v20120614_UserNotifications
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 14/06/12, 10:09:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Autoriza la recepción de notificaciones de la aplicacion paraa los miembros del 
  // del grupo Administración en los modulos que ese grupo tiene autorizados.
  // Los usuarios de este grupo veran aparecer en el explorador el icono del buzón de notificaciones.
  // Los usuarios que hayan recibido una notificación destinada explícitamente a ellos también la verán aunque no tengan autorización.
  // Quienes tengan privilegios para modificar los privilegios de los usuarios podrán activar o desactivar la recepción de notificaciones
  //
  // PARÁMETROS
  // UD_v20120614_UserNotifications()
  // ----------------------------------------------------
C_LONGINT:C283($i;$l_bitsModules;$l_element;$l_groupID;$l_userId)

ARRAY TEXT:C222($atUSR_AuthModules;0)




  // CODIGO PRINCIPAL
$l_groupID:=-15001
KRL_FindAndLoadRecordByIndex (->[xShell_UserGroups:17]IDGroup:1;->$l_groupID)
LIST TO ARRAY:C288("XS_Modules";<>atXS_ModuleNames;<>alXS_ModuleRef)
ARRAY TEXT:C222($atUSR_AuthModules;0)
BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->$atUSR_AuthModules)  //leo los módulos autorizados para el grupo

$l_bitsModules:=0  // inicializo el longint en el que encederemos los bits correspondientes a los módulos autorizados
For ($i;1;Size of array:C274($atUSR_AuthModules))
	$l_element:=Find in array:C230(<>atXS_ModuleNames;$atUSR_AuthModules{$i})
	If ($l_element>0)
		$l_bitsModules:=$l_bitsModules ?+ <>alXS_ModuleRef{$l_element}  // si el módulo está autorizado enciendo el bit correspondiente
	End if 
End for 


USR_GetGroupMemberList (-15001)
For ($i;1;Size of array:C274(<>aMembersID))
	$l_userId:=<>aMembersID{$i}
	KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_userId;True:C214)
	If ([xShell_Users:47]ReceiveNotifications_Modules:22=0)  //20130822 RCH se agrega validacion para no intervenir posible configuracion ya realizada.
		[xShell_Users:47]ReceiveNotifications_Modules:22:=$l_bitsModules  // actualizo el longint con los módulos autorizados/no autorizados
		If ([xShell_Users:47]Receive_email:21)
			[xShell_Users:47]ReceiveNotifications_Modules:22:=[xShell_Users:47]ReceiveNotifications_Modules:22 ?+ 0
		End if 
		SAVE RECORD:C53([xShell_Users:47])
	End if 
	UNLOAD RECORD:C212([xShell_Users:47])
End for 
READ ONLY:C145([xShell_Users:47])



