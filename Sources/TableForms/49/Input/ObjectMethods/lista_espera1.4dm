Case of 
	: (Self:C308->="M@")
	: (Self:C308->="F@")
	Else 
		Case of 
			: ([Alumnos:2]Sexo:49="M")
				Self:C308->:="H"+String:C10(Num:C11(Self:C308->);"00")
			: ([Alumnos:2]Sexo:49="F")
				Self:C308->:="M"+String:C10(Num:C11(Self:C308->);"00")
		End case 
End case 

If (KRL_RecordExists (->[ADT_Candidatos:49]No_en_lista_espera:35))
	CD_Dlog (0;__ ("Ya existe un postulante con este número en la lista de espera."))
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
End if 