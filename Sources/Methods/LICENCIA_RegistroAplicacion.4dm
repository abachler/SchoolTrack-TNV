//%attributes = {}
  // LICENCIA_RegistroAplicacion()
  // Por: Alberto Bachler K.: 28-09-14, 16:01:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_recNum)


If (False:C215)
	C_LONGINT:C283(LICENCIA_RegistroAplicacion ;$0)
End if 

READ WRITE:C146([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])

Case of 
	: (Records in selection:C76([xShell_ApplicationData:45])=0)
		CREATE RECORD:C68([xShell_ApplicationData:45])
		[xShell_ApplicationData:45]ProductName:16:="Main"
		SAVE RECORD:C53([xShell_ApplicationData:45])
		LICENCIA_ObtieneUUIDinstitucion 
		$l_recNum:=Record number:C243([xShell_ApplicationData:45])
		
	: (Records in selection:C76([xShell_ApplicationData:45])>1)
		KRL_DeleteSelection (->[xShell_ApplicationData:45])
		CREATE RECORD:C68([xShell_ApplicationData:45])
		[xShell_ApplicationData:45]ProductName:16:="Main"
		SAVE RECORD:C53([xShell_ApplicationData:45])
		LICENCIA_ObtieneUUIDinstitucion 
		$l_recNum:=Record number:C243([xShell_ApplicationData:45])
		
	: ([xShell_ApplicationData:45]ProductName:16#"Main")
		[xShell_ApplicationData:45]ProductName:16:="Main"
		SAVE RECORD:C53([xShell_ApplicationData:45])
		$l_recNum:=Record number:C243([xShell_ApplicationData:45])
		
	: (Not:C34(Util_isValidUUID ([xShell_ApplicationData:45]UUID:31)))
		LICENCIA_ObtieneUUIDinstitucion 
		$l_recNum:=Record number:C243([xShell_ApplicationData:45])
		
	Else 
		$l_recNum:=Record number:C243([xShell_ApplicationData:45])
		
End case 
KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])

$0:=$l_recNum
