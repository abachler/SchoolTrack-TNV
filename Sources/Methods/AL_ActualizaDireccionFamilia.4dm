//%attributes = {}
  //Método: AL_ActualizaDireccionFamilia
  //llamada desde objetos de la página familia del formulario [Alumnos]. Input
C_POINTER:C301($1;$fieldPointer)
$fieldPointer:=$1

If (Not:C34(vb_updateAddress))
	OK:=CD_Dlog (0;__ ("¿Desea usted utilizar la nueva dirección para el padre, la madre y los alumnos?");__ ("");__ ("Si");__ ("No"))
	If (OK=1)
		vb_updateAddress:=True:C214
		If (<>vlXS_CurrentModuleRef=4)  //ADT
			SAVE RECORD:C53([Alumnos:2])
			SAVE RECORD:C53([ADT_Candidatos:49])
		End if 
		
	End if 
End if 


If (vb_updateAddress)
	$recNum:=Record number:C243([Alumnos:2])
	UNLOAD RECORD:C212([Alumnos:2])
	READ WRITE:C146([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5;*)
	QUERY:C277([Personas:7]; | [Personas:7]No:1=[Familia:78]Madre_Número:6)
	If (Records in selection:C76([Personas:7])>0)
		ARRAY TEXT:C222(aText1;0)
		ARRAY TEXT:C222(aText1;Records in selection:C76([Personas:7]))
		Case of 
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Dirección:7))
				AT_Populate (->aText1;->[Familia:78]Dirección:7)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Direccion:14)
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Telefono:10))
				AT_Populate (->aText1;->[Familia:78]Telefono:10)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Telefono_domicilio:19)
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Comuna:8))
				AT_Populate (->aText1;->[Familia:78]Comuna:8)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Comuna:16)
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Codigo_postal:19))
				AT_Populate (->aText1;->[Familia:78]Codigo_postal:19)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Codigo_postal:15)
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Region_o_estado:34))
				AT_Populate (->aText1;->[Familia:78]Region_o_estado:34)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Region_o_Estado:18)
			: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Sector_Domicilio:44))
				AT_Populate (->aText1;->[Familia:78]Sector_Domicilio:44)
				OK:=KRL_Array2Selection (->aText1;->[Personas:7]Sector_Domicilio:92)
		End case 
	End if 
	If (ok=1)
		READ WRITE:C146([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
		If (Records in selection:C76([Alumnos:2])>0)
			ARRAY TEXT:C222(aText1;0)
			ARRAY TEXT:C222(aText1;Records in selection:C76([Alumnos:2]))
			Case of 
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Dirección:7))
					AT_Populate (->aText1;->[Familia:78]Dirección:7)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Direccion:12)
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Telefono:10))
					AT_Populate (->aText1;->[Familia:78]Telefono:10)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Telefono:17)
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Comuna:8))
					AT_Populate (->aText1;->[Familia:78]Comuna:8)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Comuna:14)
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Codigo_postal:19))
					AT_Populate (->aText1;->[Familia:78]Codigo_postal:19)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Codigo_Postal:13)
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Region_o_estado:34))
					AT_Populate (->aText1;->[Familia:78]Region_o_estado:34)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Región_o_estado:16)
				: (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Sector_Domicilio:44))
					AT_Populate (->aText1;->[Familia:78]Sector_Domicilio:44)
					OK:=KRL_Array2Selection (->aText1;->[Alumnos:2]Sector_Domicilio:80)
			End case 
		End if 
		If (ok=1)
			If ((Field:C253($fieldPointer)=Field:C253(->[Familia:78]Dirección:7)) | (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Comuna:8)) | (Field:C253($fieldPointer)=Field:C253(->[Familia:78]Codigo_postal:19)))
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
	If ($recNum>-1)
		READ WRITE:C146([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];$recNum)
	End if 
End if 
vb_updateAddress:=False:C215