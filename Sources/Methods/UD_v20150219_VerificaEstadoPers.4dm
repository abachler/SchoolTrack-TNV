//%attributes = {}
  //UD_v20150219_VerificaEstadoPers

C_LONGINT:C283($l_therm)

READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
$l_therm:=IT_UThermometer (1;0;"verificando estado de personas...")
QUERY:C277([Personas:7];[Personas:7]Inactivo:46=True:C214)
SELECTION TO ARRAY:C260([Personas:7];aQR_Longint1)

For (vQR_Long1;1;Size of array:C274(aQR_longint1))
	GOTO RECORD:C242([Personas:7];aQR_Longint1{vQR_Long1})
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
	KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
	QUERY SELECTION:C341([Familia:78];[Familia:78]Inactiva:31=False:C215)
	If (Records in selection:C76([Familia:78])=0)
		KRL_ReloadInReadWriteMode (->[Personas:7])
		[Personas:7]Inactivo:46:=False:C215
		SAVE RECORD:C53([Personas:7])
		KRL_UnloadReadOnly (->[Personas:7])
	End if 
End for 

IT_UThermometer (-2;$l_therm)
KRL_UnloadReadOnly (->[Personas:7])

dbu_CountFamilyStudents 

$l_therm:=IT_UThermometer (1;0;"Verificando familias...")
READ WRITE:C146([Familia:78])
ALL RECORDS:C47([Familia:78])
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Numero:1:=[Familia:78]Numero:1)
IT_UThermometer (-2;$l_therm)
