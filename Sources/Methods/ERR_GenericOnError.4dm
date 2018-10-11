//%attributes = {}
  //ERR_GenericOnError

C_LONGINT:C283(Error)
If (Error#0)
	Case of 
		: (Error=-10503)
			Error:=0  //  We get this error when going to record number that doesn't exist  
		: (Error=2000)
			Error:=0  //  We get this error if ABORT is used in a script.  Ignore it.
		: (Error=1006)
			Error:=0  // The user interupted us with option-click.  Ignore it.
	End case 
End if 
