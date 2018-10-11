$existe:=KRL_RecordExists (Self:C308)
If ($existe)
	CD_Dlog (0;__ ("Ya existe un campo propio con este nombre. Por favor use otro."))
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
End if 