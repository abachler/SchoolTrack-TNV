//%attributes = {}
  // VC4D_OnError()
  // 
  //
  // creado por: Alberto Bachler Klein: 10-02-16, 08:50:38
  // -----------------------------------------------------------


C_LONGINT:C283(Error;ERR_CodeSQL;ERR_NativeSQL)
C_TEXT:C284(ERR_TextSQL;ERR_ODBC)
If (Error#0)
	Case of 
		: (Error=2000)
			Error:=0  //  Intrerrupcion usando ABORT
		: (Error=1006)
			Error:=0  // Interrupcion con ALT u OPTION Click 
	End case 
End if 


SQL GET LAST ERROR:C825(ERR_CodeSQL;ERR_TextSQL;ERR_ODBC;ERR_NativeSQL)

