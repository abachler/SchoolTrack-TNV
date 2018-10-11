//%attributes = {}
  //UFLD_Delete

C_LONGINT:C283($f)
vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
EXECUTE FORMULA:C63("vPointer:=»"+vField)
QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$1)
$f:=Records in selection:C76(Table:C252([xShell_Userfields:76]FileNo:6)->)

If ($f#0)
	ok:=CD_Dlog (0;__ ("Este campo es utilizado en la base de datos.\r¿Desea Ud. eliminarlo?");__ ("");__ ("No");__ ("Eliminar"))
	If (OK=2)
		If (Not:C34(KRL_IsRecordLocked (->[xShell_Userfields:76])))
			DELETE RECORD:C58([xShell_Userfields:76])
		End if 
	Else 
		UNLOAD RECORD:C212([xShell_Userfields:76])
	End if 
Else 
	ok:=CD_Dlog (0;__ ("¿Desea Ud. eliminar este campo?");__ ("");__ ("No");__ ("Eliminar"))
	If (OK=2)
		If (Not:C34(KRL_IsRecordLocked (->[xShell_Userfields:76])))
			DELETE RECORD:C58([xShell_Userfields:76])
		End if 
	Else 
		UNLOAD RECORD:C212([xShell_Userfields:76])
	End if 
End if 