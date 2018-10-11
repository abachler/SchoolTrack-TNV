If (Form event:C388=On Data Change:K2:15)
	$name:=Self:C308->+"@"
	QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=$name;*)
	QUERY:C277([Profesores:4]; & ;[Profesores:4]Es_Entrevistador_Admisiones:35=False:C215)
	Case of 
		: (Records in selection:C76([Profesores:4])=0)
			OK:=CD_Dlog (0;__ ("");__ (" ");__ ("Sí");__ ("No"))
			If (ok=1)
				CREATE RECORD:C68([Profesores:4])
				[Profesores:4]Numero:1:=SQ_SeqNumber (->[Profesores:4]Numero:1)
				Self:C308->:=ST_Format (Self:C308;->[Profesores:4]Apellido_paterno:3)
				[Profesores:4]Apellido_paterno:3:=Self:C308->
				[Profesores:4]Es_Entrevistador_Admisiones:35:=True:C214
				SAVE RECORD:C53([Profesores:4])
				viPST_IViewerRecNum:=Record number:C243([Profesores:4])
				vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
				vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
				vsPST_NombresIViewer:=[Profesores:4]Nombres:2
				vsPST_ExtIViewer:=[Profesores:4]Anexo:23
				vsPST_PnoneIViewer:=[Profesores:4]Telefono_domicilio:24
			Else 
				If (viPST_IViewerRecNum>0)
					GOTO RECORD:C242([Profesores:4];viPST_IViewerRecNum)
				Else 
					REDUCE SELECTION:C351([Profesores:4];0)
				End if 
				vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
				vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
				vsPST_NombresIViewer:=[Profesores:4]Nombres:2
				vsPST_ExtIViewer:=[Profesores:4]Telefono_domicilio:24
				vsPST_PnoneIViewer:=[Profesores:4]Anexo:23
			End if 
		: (Records in selection:C76([Profesores:4])=1)
			viPST_IViewerRecNum:=Record number:C243([Profesores:4])
			vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
			vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
			vsPST_NombresIViewer:=[Profesores:4]Nombres:2
			[Profesores:4]Es_Entrevistador_Admisiones:35:=True:C214
			SAVE RECORD:C53([Profesores:4])
		: (Records in selection:C76([Profesores:4])>1)
			READ ONLY:C145([Familia:78])
			SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;<>aGenNme;[Profesores:4]Departamento:14;aText1;[Profesores:4]Numero:1;<>aGenId)
			ARRAY POINTER:C280(<>aChoicePtrs;3)
			<>aChoicePtrs{1}:=-><>aGenNme
			<>aChoicePtrs{2}:=->aText1
			<>aChoicePtrs{3}:=-><>aGenID
			TBL_ShowChoiceList (1)
			If ((ok=1) & (choiceIdx>0))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=<>aGenID{choiceIdx})
				viPST_IViewerRecNum:=Record number:C243([Profesores:4])
				vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
				vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
				vsPST_NombresIViewer:=[Profesores:4]Nombres:2
				vsPST_ExtIViewer:=[Profesores:4]Telefono_domicilio:24
				vsPST_PnoneIViewer:=[Profesores:4]Anexo:23
				[Profesores:4]Es_Entrevistador_Admisiones:35:=True:C214
				SAVE RECORD:C53([Profesores:4])
			Else 
				If (viPST_IViewerRecNum>0)
					GOTO RECORD:C242([Profesores:4];viPST_IViewerRecNum)
				Else 
					REDUCE SELECTION:C351([Profesores:4];0)
				End if 
				vsPST_aPaternoIViewer:=[Profesores:4]Apellido_paterno:3
				vsPST_aMaternoIViewer:=[Profesores:4]Apellido_materno:4
				vsPST_NombresIViewer:=[Profesores:4]Nombres:2
				vsPST_ExtIViewer:=[Profesores:4]Telefono_domicilio:24
				vsPST_PnoneIViewer:=[Profesores:4]Anexo:23
			End if 
	End case 
	
	If (Records in selection:C76([Profesores:4])=1)
		[Profesores:4]Entrevista_desde:36:=vdPST_StartInterviews
		[Profesores:4]Entrevista_hasta:37:=vdPST_EndInterviews
	Else 
	End if 
End if 