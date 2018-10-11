lb_UsuariosSTWA2{0}:=True:C214
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->lb_UsuariosSTWA2;"=";->$DA_Return)
If (Size of array:C274($DA_Return)>0)
	For ($i;1;Size of array:C274($DA_Return))
		$uuid:=atSTWA2_SessionUUID{$DA_Return{$i}}
		$rn:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$uuid)
		If ($rn#-1)
			STWA2_Session_UnsetSession ($uuid)
		End if 
	End for 
End if 
LISTBOX SELECT ROW:C912(lb_UsuariosSTWA2;0;lk remove from selection:K53:3)
OBJECT SET ENABLED:C1123(Self:C308->;False:C215)