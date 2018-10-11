//%attributes = {}
  //UD_v20130903_FechaMatricula

C_LONGINT:C283($p;$i)
$p:=IT_UThermometer (1;0;"Fecha de Matricula Actual")
READ WRITE:C146([Alumnos:2])
NIV_LoadArrays 
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
QUERY SELECTION BY FORMULA:C207([Alumnos:2];Year of:C25(Date:C102([Alumnos:2]Fecha_PrimeraMatricula:86))=<>gyear)

If (Records in selection:C76([Alumnos:2])>0)
	ARRAY LONGINT:C221($al_rn_alu;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_rn_alu;"")
	For ($i;1;Size of array:C274($al_rn_alu))
		GOTO RECORD:C242([Alumnos:2];$al_rn_alu{$i})
		[Alumnos:2]Fecha_Matricula:108:=Date:C102([Alumnos:2]Fecha_PrimeraMatricula:86)
		SAVE RECORD:C53([Alumnos:2])
	End for 
End if 
KRL_UnloadReadOnly (->[Alumnos:2])
IT_UThermometer (-2;$p)