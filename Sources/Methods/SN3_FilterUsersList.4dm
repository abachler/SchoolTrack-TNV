//%attributes = {}
  //SN3_FilterUsersList


If (g_Todos=1)
	COPY ARRAY:C226(SN3_TipoUsuarioCpy;SN3_TipoUsuario)
	COPY ARRAY:C226(SN3_TipoCodeUsuarioCpy;SN3_TipoCodeUsuario)
	COPY ARRAY:C226(SN3_AyNUsuariosCpy;SN3_AyNUsuarios)
	COPY ARRAY:C226(SN3_LoginUsuariosCpy;SN3_LoginUsuarios)
	COPY ARRAY:C226(SN3_PasswordUsuariosCpy;SN3_PasswordUsuarios)
	COPY ARRAY:C226(SN3_CodeUsuariosCpy;SN3_CodeUsuarios)
	COPY ARRAY:C226(SN3_InactivoUsuariosCpy;SN3_InactivoUsuarios)
	COPY ARRAY:C226(SN3_ColorsUsuariosCpy;SN3_ColorsUsuarios)
	COPY ARRAY:C226(SN3_StylesUsuariosCpy;SN3_StylesUsuarios)
	COPY ARRAY:C226(SN3_BacksUsuariosCpy;SN3_BacksUsuarios)
	COPY ARRAY:C226(SN3_ModificadoWebUsuariosCpy;SN3_ModificadoWebUsuarios)
	COPY ARRAY:C226(SN3_CursosUsuariosCpy;SN3_CursosUsuarios)
	COPY ARRAY:C226(SN3_eMailsUsuariosCpy;SN3_eMailsUsuarios)
Else 
	Case of 
		: (g_Alumnos=1)
			SN3_TipoCodeUsuarioCpy{0}:="2"
		: (g_Relaciones=1)
			SN3_TipoCodeUsuarioCpy{0}:="1"
	End case 
	AT_Initialize (->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->SN3_TipoCodeUsuarioCpy;"=";->$DA_Return)
	AT_RedimArrays (Size of array:C274($DA_Return);->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	For ($i;1;Size of array:C274($DA_Return))
		SN3_TipoUsuario{$i}:=SN3_TipoUsuarioCpy{$DA_Return{$i}}
		SN3_TipoCodeUsuario{$i}:=SN3_TipoCodeUsuarioCpy{$DA_Return{$i}}
		SN3_AyNUsuarios{$i}:=SN3_AyNUsuariosCpy{$DA_Return{$i}}
		SN3_LoginUsuarios{$i}:=SN3_LoginUsuariosCpy{$DA_Return{$i}}
		SN3_PasswordUsuarios{$i}:=SN3_PasswordUsuariosCpy{$DA_Return{$i}}
		SN3_CodeUsuarios{$i}:=SN3_CodeUsuariosCpy{$DA_Return{$i}}
		SN3_InactivoUsuarios{$i}:=SN3_InactivoUsuariosCpy{$DA_Return{$i}}
		SN3_ColorsUsuarios{$i}:=SN3_ColorsUsuariosCpy{$DA_Return{$i}}
		SN3_StylesUsuarios{$i}:=SN3_StylesUsuariosCpy{$DA_Return{$i}}
		SN3_BacksUsuarios{$i}:=SN3_BacksUsuariosCpy{$DA_Return{$i}}
		SN3_ModificadoWebUsuarios{$i}:=SN3_ModificadoWebUsuariosCpy{$DA_Return{$i}}
		SN3_CursosUsuarios{$i}:=SN3_CursosUsuariosCpy{$DA_Return{$i}}
		SN3_eMailsUsuarios{$i}:=SN3_eMailsUsuariosCpy{$DA_Return{$i}}
	End for 
End if 
If ((r_Activos=1) | (r_Inactivos=1))
	COPY ARRAY:C226(SN3_TipoUsuario;$SN3_TipoUsuario)
	COPY ARRAY:C226(SN3_TipoCodeUsuario;$SN3_TipoCodeUsuario)
	COPY ARRAY:C226(SN3_AyNUsuarios;$SN3_AyNUsuarios)
	COPY ARRAY:C226(SN3_LoginUsuarios;$SN3_LoginUsuarios)
	COPY ARRAY:C226(SN3_PasswordUsuarios;$SN3_PasswordUsuarios)
	COPY ARRAY:C226(SN3_CodeUsuarios;$SN3_CodeUsuarios)
	COPY ARRAY:C226(SN3_InactivoUsuarios;$SN3_InactivoUsuarios)
	COPY ARRAY:C226(SN3_ColorsUsuarios;$SN3_ColorsUsuarios)
	COPY ARRAY:C226(SN3_StylesUsuarios;$SN3_StylesUsuarios)
	COPY ARRAY:C226(SN3_BacksUsuarios;$SN3_BacksUsuarios)
	COPY ARRAY:C226(SN3_ModificadoWebUsuarios;$SN3_ModificadoWebUsuarios)
	COPY ARRAY:C226(SN3_CursosUsuarios;$SN3_CursosUsuarios)
	COPY ARRAY:C226(SN3_eMailsUsuarios;$SN3_eMailsUsuarios)
	AT_Initialize (->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	$SN3_InactivoUsuarios{0}:=Num:C11((r_Inactivos=1))
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$SN3_InactivoUsuarios;"=";->$DA_Return)
	AT_RedimArrays (Size of array:C274($DA_Return);->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	For ($i;1;Size of array:C274($DA_Return))
		SN3_TipoUsuario{$i}:=$SN3_TipoUsuario{$DA_Return{$i}}
		SN3_TipoCodeUsuario{$i}:=$SN3_TipoCodeUsuario{$DA_Return{$i}}
		SN3_AyNUsuarios{$i}:=$SN3_AyNUsuarios{$DA_Return{$i}}
		SN3_LoginUsuarios{$i}:=$SN3_LoginUsuarios{$DA_Return{$i}}
		SN3_PasswordUsuarios{$i}:=$SN3_PasswordUsuarios{$DA_Return{$i}}
		SN3_CodeUsuarios{$i}:=$SN3_CodeUsuarios{$DA_Return{$i}}
		SN3_InactivoUsuarios{$i}:=$SN3_InactivoUsuarios{$DA_Return{$i}}
		SN3_ColorsUsuarios{$i}:=$SN3_ColorsUsuarios{$DA_Return{$i}}
		SN3_StylesUsuarios{$i}:=$SN3_StylesUsuarios{$DA_Return{$i}}
		SN3_BacksUsuarios{$i}:=$SN3_BacksUsuarios{$DA_Return{$i}}
		SN3_ModificadoWebUsuarios{$i}:=$SN3_ModificadoWebUsuarios{$DA_Return{$i}}
		SN3_CursosUsuarios{$i}:=$SN3_CursosUsuarios{$DA_Return{$i}}
		SN3_eMailsUsuarios{$i}:=$SN3_eMailsUsuarios{$DA_Return{$i}}
	End for 
End if 
If ((h_NoModificados=1) | (h_Modificados=1))
	COPY ARRAY:C226(SN3_TipoUsuario;$SN3_TipoUsuario)
	COPY ARRAY:C226(SN3_TipoCodeUsuario;$SN3_TipoCodeUsuario)
	COPY ARRAY:C226(SN3_AyNUsuarios;$SN3_AyNUsuarios)
	COPY ARRAY:C226(SN3_LoginUsuarios;$SN3_LoginUsuarios)
	COPY ARRAY:C226(SN3_PasswordUsuarios;$SN3_PasswordUsuarios)
	COPY ARRAY:C226(SN3_CodeUsuarios;$SN3_CodeUsuarios)
	COPY ARRAY:C226(SN3_InactivoUsuarios;$SN3_InactivoUsuarios)
	COPY ARRAY:C226(SN3_ColorsUsuarios;$SN3_ColorsUsuarios)
	COPY ARRAY:C226(SN3_StylesUsuarios;$SN3_StylesUsuarios)
	COPY ARRAY:C226(SN3_BacksUsuarios;$SN3_BacksUsuarios)
	COPY ARRAY:C226(SN3_ModificadoWebUsuarios;$SN3_ModificadoWebUsuarios)
	COPY ARRAY:C226(SN3_CursosUsuarios;$SN3_CursosUsuarios)
	COPY ARRAY:C226(SN3_eMailsUsuarios;$SN3_eMailsUsuarios)
	AT_Initialize (->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	$SN3_ModificadoWebUsuarios{0}:=Num:C11((h_Modificados=1))
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$SN3_ModificadoWebUsuarios;"=";->$DA_Return)
	AT_RedimArrays (Size of array:C274($DA_Return);->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_AyNUsuarios;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_eMailsUsuarios)
	For ($i;1;Size of array:C274($DA_Return))
		SN3_TipoUsuario{$i}:=$SN3_TipoUsuario{$DA_Return{$i}}
		SN3_TipoCodeUsuario{$i}:=$SN3_TipoCodeUsuario{$DA_Return{$i}}
		SN3_AyNUsuarios{$i}:=$SN3_AyNUsuarios{$DA_Return{$i}}
		SN3_LoginUsuarios{$i}:=$SN3_LoginUsuarios{$DA_Return{$i}}
		SN3_PasswordUsuarios{$i}:=$SN3_PasswordUsuarios{$DA_Return{$i}}
		SN3_CodeUsuarios{$i}:=$SN3_CodeUsuarios{$DA_Return{$i}}
		SN3_InactivoUsuarios{$i}:=$SN3_InactivoUsuarios{$DA_Return{$i}}
		SN3_ColorsUsuarios{$i}:=$SN3_ColorsUsuarios{$DA_Return{$i}}
		SN3_StylesUsuarios{$i}:=$SN3_StylesUsuarios{$DA_Return{$i}}
		SN3_BacksUsuarios{$i}:=$SN3_BacksUsuarios{$DA_Return{$i}}
		SN3_ModificadoWebUsuarios{$i}:=$SN3_ModificadoWebUsuarios{$DA_Return{$i}}
		SN3_CursosUsuarios{$i}:=$SN3_CursosUsuarios{$DA_Return{$i}}
		SN3_eMailsUsuarios{$i}:=$SN3_eMailsUsuarios{$DA_Return{$i}}
	End for 
End if 
SN3_ListMessage:="Mostrando "+String:C10(Size of array:C274(SN3_TipoUsuario))+" de "+String:C10(Size of array:C274(SN3_TipoUsuarioCpy))+" recibidos."