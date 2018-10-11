Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		If ([Alumnos_EventosOrientacion:21]Registrada_por:8#"")
			$vt_Autor:=[Alumnos_EventosOrientacion:21]Registrada_por:8
			IT_Clairvoyance (Self:C308;->at_Profesores_Nombres;"")
			$el:=Find in array:C230(at_Profesores_Nombres;[Alumnos_EventosOrientacion:21]Registrada_por:8)
			If ($el>0)
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{$el})
			Else 
				[Alumnos_EventosOrientacion:21]Registrada_por:8:=$vt_Autor
				QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=([Alumnos_EventosOrientacion:21]Registrada_por:8+"@"))
			End if 
			
			Case of 
				: (Records in selection:C76([Profesores:4])=0)
					$r:=CD_Dlog (2;__ ("Profesor inexistente.\r¿Desea Ud. crearlo?");__ ("");__ ("Si");__ ("No"))
					If ($r=1)
						vb_inBrowsingMode:=False:C215
						$inBwr:=vbXS_inBrowser
						vbXS_inBrowser:=False:C215
						yBWR_currentTable:=->[Profesores:4]
						WDW_Open (565;425;2;4;XSvs_nombreTablaLocal_puntero (yBWR_currentTable);"mnCloseIpt")
						FORM SET INPUT:C55([Profesores:4];"Input")
						READ WRITE:C146([Profesores:4])
						ADD RECORD:C56([Profesores:4];*)
						If (viBWR_RecordWasSaved=1)
							[Alumnos_EventosOrientacion:21]Registrada_por:8:=[Profesores:4]Nombre_comun:21
							UNLOAD RECORD:C212([Profesores:4])
						Else 
							[Alumnos_EventosOrientacion:21]Registrada_por:8:=""
							GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Registrada_por:8)
						End if 
						READ ONLY:C145([Profesores:4])
						RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
						vb_inBrowsingMode:=True:C214
						yBWR_currentTable:=->[Cursos:3]
						vbXS_inBrowser:=$inBwr
					Else 
						[Alumnos_EventosOrientacion:21]Registrada_por:8:=""
						GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Registrada_por:8)
					End if 
				: (Records in selection:C76([Profesores:4])=1)
					[Alumnos_EventosOrientacion:21]Registrada_por:8:=[Profesores:4]Nombre_comun:21
				: (Records in selection:C76([Profesores:4])>1)
					[Alumnos_EventosOrientacion:21]Registrada_por:8:=""
					GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Registrada_por:8)
					  //READ ONLY([Profesores])
					  //SELECTION TO ARRAY([Profesores]Nombre_común;<>aGenNme;[Profesores]Número;<>aGenId)
					  //ARRAY POINTER(<>aChoicePtrs;2)
					  //<>aChoicePtrs{1}:=-><>aGenNme
					  //TBL_ShowChoiceList (1)
					  //If ((ok=1) & (choiceIdx>0))
					  //[Alumnos_EventosOrientación]Registrada_por:=<>aChoicePtrs{1}->{choiceIdx}
					  //Else 
					  //[Alumnos_EventosOrientación]Registrada_por:=""
					  //GOTO OBJECT([Alumnos_EventosOrientación]Registrada_por)
					  //End if 
			End case 
		End if 
End case 