[Profesores:4]RUT:27:=CTRY_CL_VerifRUT ([Profesores:4]RUT:27)

If ([Profesores:4]RUT:27#"")
	If (KRL_RecordExists (->[Profesores:4]RUT:27))
		CD_Dlog (0;__ ("Ya existe un profesor con este RUT."))
		[Profesores:4]RUT:27:=""
		GOTO OBJECT:C206([Profesores:4]RUT:27)
	Else 
		STR_TraeDatos_PER_PRO_ALU (Table:C252(->[Profesores:4]))
	End if 
	GOTO OBJECT:C206([Profesores:4]RUT:27)
End if 

If (Form event:C388=On Data Change:K2:15)
	ST_verificaRelacionProfPers ("funcionario";[Profesores:4]RUT:27)
End if 
