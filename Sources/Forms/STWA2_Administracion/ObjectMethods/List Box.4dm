If (Count in array:C907(lb_UsuariosSTWA2;True:C214)>0)
	lb_UsuariosSTWA2{0}:=True:C214
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->lb_UsuariosSTWA2;"=";->$DA_Return)
	$enable:=False:C215
	For ($i;1;Size of array:C274($DA_Return))
		If (alSTWA2_DeleteGhostSession{$DA_Return{$i}}=0)
			$enable:=True:C214
			$i:=Size of array:C274($DA_Return)+1
		End if 
	End for 
	OBJECT SET ENABLED:C1123(bDesconectar;$enable)
Else 
	OBJECT SET ENABLED:C1123(bDesconectar;False:C215)
End if 