//%attributes = {}
  // ERR_EventoError()
  // Por: Alberto Bachler K.: 11-09-14, 20:40:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283(Error)
If (Error#0)
	Case of 
		: (Error=2000)
			Error:=0  //  Intrerrupcion usando ABORT
		: (Error=1006)
			Error:=0  // Interrupcion con ALT u OPTION Click 
	End case 
End if 

