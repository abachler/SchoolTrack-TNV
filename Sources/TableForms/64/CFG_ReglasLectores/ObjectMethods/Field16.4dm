$l_posicionEnLista:=Find in array:C230(<>aPrefUsrName;[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
Case of 
	: ([xxBBL_ReglasParaUsuarios:64]Nombre Regla:2="")
		[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:=Old:C35([xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
		CD_Dlog (0;__ ("El nombre de una regla no puede ser vacío.\r\rPor favor ingrese un nombre válido"))
		GOTO OBJECT:C206([xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
	: (($l_posicionEnLista>0) & ($l_posicionEnLista#<>aPrefUsrName))
		CD_Dlog (0;__ ("Esta regla ya existe."))
		[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:=Old:C35([xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
		GOTO OBJECT:C206([xxBBL_ReglasParaUsuarios:64]Nombre Regla:2)
	Else 
		<>aPrefUsrName{<>aPrefUsrName}:=[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2
End case 