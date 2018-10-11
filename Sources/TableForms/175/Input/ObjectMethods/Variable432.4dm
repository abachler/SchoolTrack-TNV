Case of 
	: ((alProEvt=1) | (alProEvt=2))
		PUSH RECORD:C176([ACT_CuentasCorrientes:175])
		$line:=AL_GetLine (xALP_Documentos)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTac_CargaCargosAviso (aYearsACT{aYearsACT};aACT_CtasDCNoComprobante{$line};"avisosDesdeCtas";[ACT_CuentasCorrientes:175]ID:1)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
		POP RECORD:C177([ACT_CuentasCorrientes:175])
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
End case 