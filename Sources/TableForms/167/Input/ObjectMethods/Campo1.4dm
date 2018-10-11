If (KRL_RecordExists (Self:C308))
	CD_Dlog (0;__ ("Ya existe una sala con el mimo nombre\r\rPor favor ingrese un nombre de sala diferente."))
	Self:C308->:=""
End if 