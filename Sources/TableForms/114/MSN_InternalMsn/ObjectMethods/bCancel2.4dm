$prevSel:=at_UsuariosConectados{at_UsuariosConectados}
ARRAY TEXT:C222(at_UsuariosConectados;0)
ARRAY TEXT:C222(at_Nombres;0)
ARRAY LONGINT:C221($methods;0)
GET REGISTERED CLIENTS:C650(at_UsuariosConectados;$methods)
ARRAY BOOLEAN:C223(ab_MiConexion;Size of array:C274(at_UsuariosConectados))
dummyBoolean:=False:C215
AT_Populate (->ab_MiConexion;->dummyBoolean)
$miPos:=Find in array:C230(at_UsuariosConectados;<>RegisteredName)
If ($miPos#-1)
	ab_MiConexion{$miPos}:=True:C214
End if 
at_UsuariosConectados:=0
at_Nombres:=0
For ($i;1;Size of array:C274(at_UsuariosConectados))
	$UserId:=Num:C11(ST_GetWord (at_UsuariosConectados{$i};2))
	If ($UserId#0)
		INSERT IN ARRAY:C227(at_Nombres;Size of array:C274(at_Nombres)+1;1)
		at_Nombres{$i}:=USR_GetUserName ($UserId)
	End if 
End for 
$StillConected:=Find in array:C230(at_UsuariosConectados;$prevSel)
If ($StillConected#-1)
	at_UsuariosConectados:=$StillConected
	at_Nombres:=$StillConected
	ab_MiConexion:=$StillConected
Else 
	at_UsuariosConectados:=0
	at_Nombres:=0
	ab_MiConexion:=0
End if 
If (at_UsuariosConectados>0)
	If (ab_MiConexion{at_UsuariosConectados}=False:C215)
		GOTO OBJECT:C206(vMsg)
	End if 
	IT_SetButtonState ((Not:C34(ab_MiConexion{at_UsuariosConectados}));->bSend)
	IT_SetEnterable ((Not:C34(ab_MiConexion{at_UsuariosConectados}));0;->vMsg)
Else 
	_O_DISABLE BUTTON:C193(bSend)
	OBJECT SET ENTERABLE:C238(vMsg;False:C215)
End if 
IT_SetButtonState (Not:C34((Size of array:C274(at_UsuariosConectados)=1));->bSendAll)