If (ADTcdd_esRegistroValido )
	$oldSitFinal:=[ADT_Candidatos:49]ID_SitFinal:51
	GET LIST ITEM:C378(Self:C308->;*;$ref;$text)
	If ($oldSitFinal#$ref)
		[ADT_Candidatos:49]ID_SitFinal:51:=$ref
		[ADT_Candidatos:49]Situación_final:16:=$text
		CREATE RECORD:C68([xxADT_LogCambioEstado:162])
		[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
		[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
		[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=[ADT_Candidatos:49]ID_Estado:49
		[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=$ref
		[xxADT_LogCambioEstado:162]ID_SitFinal_Viejo:6:=$oldSitFinal
		[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
		[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
		SAVE RECORD:C53([xxADT_LogCambioEstado:162])
		UNLOAD RECORD:C212([xxADT_LogCambioEstado:162])
		SAVE RECORD:C53([ADT_Candidatos:49])
	End if 
	KRL_ResetPreviousRWMode (->[Alumnos:2];$b_ReadOnlyStateAlumno)
	$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
	$cond:=(([ADT_Candidatos:49]ID_SitFinal:51=$estadoTerm) & ($estadoTerm#0))
	OBJECT SET VISIBLE:C603(*;"acceptOTF@";$cond)
End if 