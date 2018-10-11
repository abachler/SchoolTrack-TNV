$codigo:=ST_GetCleanString (Self:C308->)
Self:C308->:=ACTcc_DVCodigoCta ($codigo)
If (Self:C308->#"")
	If (KRL_RecordExists (Self:C308))
		$ignore:=CD_Dlog (0;__ ("Ya existe una cuenta corriente con el mismo código."))
		Self:C308->:=Old:C35(Self:C308->)
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 