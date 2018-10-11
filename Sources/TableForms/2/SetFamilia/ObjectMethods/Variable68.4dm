$familyName:=vt_FamilyName
If (vsBWR_CurrentModule="AdmissionTrack")
	If ($familyName#"")
		If (Is new record:C668([ADT_Candidatos:49])=True:C214)
			  //  `guarde las relaciones familiares, debo borrarlas si cancelo
			  //vbSiGuardeRelacionesFamiliares:=True
		Else 
			  //vbSiGuardeRelacionesFamiliares:=False
		End if 
		PST_CreateFamily ([Alumnos:2]Apellido_paterno:3;[Alumnos:2]Apellido_materno:4)
		ACCEPT:C269
	End if 
Else 
	If ($familyName#"")
		CREATE RECORD:C68([Familia:78])
		[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
		[Familia:78]Nombre_de_la_familia:3:=$familyName
		[Familia:78]Grupo_Familia:4:=[Alumnos:2]Grupo:11
		[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
		[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
		[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
		[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
		SAVE RECORD:C53([Familia:78])
		vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
		ACCEPT:C269
	End if 
End if 

