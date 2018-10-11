If (aNombreContacto>0)
	AT_Delete (aNombreContacto;1;->aNombreContacto;->aRelacionContacto;->aTelContacto)
	LISTBOX SELECT ROW:C912(*;"contactos";0;lk remove from selection:K53:3)
	_O_DISABLE BUTTON:C193(Self:C308->)
End if 