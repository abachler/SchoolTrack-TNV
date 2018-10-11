If (Self:C308->>0)
	[Familia:78]Comuna:8:=Self:C308->{Self:C308->}
End if 

If (Modified:C32([Familia:78]Comuna:8))
	If (Not:C34(vb_updateAddress))
		OK:=CD_Dlog (0;__ ("¿Desea usted utilizar la nueva dirección para el padre, la madre y los alumnos?");__ ("");__ ("Si");__ ("No"))
		If (OK=1)
			vb_updateAddress:=True:C214
		End if 
	End if 
	
	
	If (vb_updateAddress)
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5;*)
		QUERY:C277([Personas:7]; | [Personas:7]No:1=[Familia:78]Madre_Número:6)
		If (Records in selection:C76([Personas:7])>0)
			ARRAY TEXT:C222(aText1;0)
			ARRAY TEXT:C222(aText1;Records in selection:C76([Personas:7]))
			AT_Populate (->aText1;->[Familia:78]Comuna:8)
			OK:=KRL_Array2Selection (->aText1;->[Personas:7]Comuna:16)
		End if 
		If (ok=1)
			READ WRITE:C146([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			If (Records in selection:C76([Alumnos:2])>0)
				ARRAY TEXT:C222(aText1;0)
				ARRAY TEXT:C222(aText1;Records in selection:C76([Alumnos:2]))
				AT_Populate (->aText1;->[Familia:78]Comuna:8)
				OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Comuna:14)
			End if 
			If (ok=1)
				OK:=CD_Dlog (0;__ ("¿Desea usted utilizar la nueva dirección como dirección postal?");__ ("");__ ("Si");__ ("No"))
				If (ok=1)
					If ([Familia:78]Dirección:7#"")
						[Familia:78]Direccion_Postal:29:=[Familia:78]Dirección:7
						If ([Familia:78]Comuna:8#"")
							If ([Familia:78]Codigo_postal:19#"")
								[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Codigo_postal:19+" "+[Familia:78]Comuna:8
							Else 
								[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Comuna:8
							End if 
						End if 
					End if 
				End if 
				FM_fSave 
			End if 
		End if 
	End if 
End if 