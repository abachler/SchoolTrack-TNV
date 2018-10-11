//%attributes = {}
  //InterruptPrint

IT_MODIFIERS 

If (((<>Command) & ((keyCode=Character code:C91(".")) | (keyCode=Character code:C91(";"))) | (keyCode=27)))
	<>stopExec:=True:C214
End if 