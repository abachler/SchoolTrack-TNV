If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaUsuarios:64]))
	If ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1#"")
		SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
	End if 
End if 
CREATE RECORD:C68([xxBBL_ReglasParaUsuarios:64])
[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:="R"+String:C10(Sequence number:C244([xxBBL_ReglasParaUsuarios:64]))
[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:="Regla Nº"+String:C10(Sequence number:C244([xxBBL_ReglasParaUsuarios:64]))
SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
APPEND TO ARRAY:C911(<>aPrefUsr;[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
APPEND TO ARRAY:C911(<>aPrefUsrName;[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
<>aPrefUsr:=Size of array:C274(<>aPrefUsr)
<>aPrefUsrName:=Size of array:C274(<>aPrefUsr)
GOTO OBJECT:C206([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)