
Case of 
	: (Form event:C388=On Data Change:K2:15)
		[Alumnos:2]RUT:5:=ST_Uppercase ([Alumnos:2]RUT:5)
		If (Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1))>0)
			[Alumnos:2]RUT:5:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5)
			If ([Alumnos:2]RUT:5#"")
				If (KRL_RecordExists (->[Alumnos:2]RUT:5))
					CD_Dlog (0;__ ("Ya existe un alumno con este RUT."))
					[Alumnos:2]RUT:5:=""
					GOTO OBJECT:C206([Alumnos:2]RUT:5)
				Else 
					STR_TraeDatos_PER_PRO_ALU (Table:C252(->[Alumnos:2]))
				End if 
			Else 
				GOTO OBJECT:C206([Alumnos:2]RUT:5)
			End if 
		Else 
			[Alumnos:2]RUT:5:=""
			  //OBJECT SET FORMAT([Alumnos]RUT;"")
		End if 
		
		AL_SetIdentificadorPrincipal 
End case 