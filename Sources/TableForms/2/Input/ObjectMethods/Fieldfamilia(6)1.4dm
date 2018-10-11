Self:C308->:=ST_Format (Self:C308)

If (Form event:C388=On Data Change:K2:15)
	If (Not:C34(vb_updateAddress))
		OK:=CD_Dlog (0;__ ("¿Desea usted utilizar la nueva dirección para el padre, la madre y los alumnos?");__ ("");__ ("Si");__ ("No"))
		If (OK=1)
			vb_updateAddress:=True:C214
		End if 
	End if 
End if 

If (vb_updateAddress)
	$l_recNumAlumno:=Record number:C243([Alumnos:2])
	READ WRITE:C146([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5;*)
	QUERY:C277([Personas:7]; | [Personas:7]No:1=[Familia:78]Madre_Número:6)
	If (Records in selection:C76([Personas:7])>0)
		ARRAY TEXT:C222(aText1;0)
		ARRAY TEXT:C222(aText1;Records in selection:C76([Personas:7]))
		AT_Populate (->aText1;->[Familia:78]Dirección:7)
		OK:=KRL_Array2Selection (->aText1;->[Personas:7]Direccion:14)
	End if 
	If (ok=1)
		READ WRITE:C146([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
		If (Records in selection:C76([Alumnos:2])>0)
			ARRAY TEXT:C222(aText1;0)
			ARRAY TEXT:C222(aText1;Records in selection:C76([Alumnos:2]))
			AT_Populate (->aText1;->[Familia:78]Dirección:7)
			OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Direccion:12)
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
	KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
End if 
vb_updateAddress:=False:C215