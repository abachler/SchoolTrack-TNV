//%attributes = {}
  //KRL_UnloadAll

For ($I;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		UNLOAD RECORD:C212(Table:C252($i)->)
	End if 
End for 
READ ONLY:C145(*)