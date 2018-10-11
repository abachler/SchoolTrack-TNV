[Personas:7]RUT:6:=CTRY_CL_VerifRUT ([Personas:7]RUT:6)
If ([Personas:7]RUT:6#"")
	If (KRL_RecordExists (->[Personas:7]RUT:6))
		CD_Dlog (0;__ ("Ya existe una persona con este RUT."))
		[Personas:7]RUT:6:=""
		GOTO OBJECT:C206([Personas:7]RUT:6)
	Else 
		STR_TraeDatos_PER_PRO_ALU (Table:C252(->[Personas:7]))
		  //ticket 154576 JVP
		[Personas:7]RUT:6:=CTRY_CO_ValidaID_NAC (->[Personas:7]RUT:6)
	End if 
Else 
	GOTO OBJECT:C206([Personas:7]RUT:6)
End if 
If (Form event:C388=On Data Change:K2:15)
	ST_verificaRelacionProfPers ("relacion_familiar";[Personas:7]RUT:6)
End if 

