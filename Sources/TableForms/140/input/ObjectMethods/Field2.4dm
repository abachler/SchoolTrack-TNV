
Case of 
	: (_O_During:C30)
		If ([Familia_RegistroEventos:140]Registrado_por:5#"")
			QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=([Familia_RegistroEventos:140]Registrado_por:5+"@"))
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
							[Familia_RegistroEventos:140]Registrado_por:5:=[Profesores:4]Apellidos_y_nombres:28
							[Familia_RegistroEventos:140]ID_Autor:9:=[Profesores:4]Numero:1
							UNLOAD RECORD:C212([Profesores:4])
						Else 
							[Familia_RegistroEventos:140]Registrado_por:5:=""
							[Familia_RegistroEventos:140]ID_Autor:9:=0
							GOTO OBJECT:C206([Familia_RegistroEventos:140]Registrado_por:5)
						End if 
						READ ONLY:C145([Profesores:4])
						RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
						vb_inBrowsingMode:=True:C214
						yBWR_currentTable:=->[Cursos:3]
						vbXS_inBrowser:=$inBwr
					Else 
						[Familia_RegistroEventos:140]Registrado_por:5:=""
						[Familia_RegistroEventos:140]ID_Autor:9:=0
						GOTO OBJECT:C206([Familia_RegistroEventos:140]Registrado_por:5)
					End if 
				: (Records in selection:C76([Profesores:4])=1)
					[Familia_RegistroEventos:140]Registrado_por:5:=[Profesores:4]Apellidos_y_nombres:28
					[Familia_RegistroEventos:140]ID_Autor:9:=[Profesores:4]Numero:1
				: (Records in selection:C76([Profesores:4])>1)
					READ ONLY:C145([Profesores:4])
					SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;<>aGenNme;[Profesores:4]Numero:1;<>aGenId)
					ARRAY POINTER:C280(<>aChoicePtrs;2)
					<>aChoicePtrs{1}:=-><>aGenNme
					TBL_ShowChoiceList (1)
					If ((ok=1) & (choiceIdx>0))
						[Familia_RegistroEventos:140]Registrado_por:5:=<>aChoicePtrs{1}->{choiceIdx}
						[Familia_RegistroEventos:140]ID_Autor:9:=[Profesores:4]Numero:1
					Else 
						[Familia_RegistroEventos:140]Registrado_por:5:=""
						[Familia_RegistroEventos:140]ID_Autor:9:=0
						GOTO OBJECT:C206([Familia_RegistroEventos:140]Registrado_por:5)
					End if 
			End case 
		End if 
End case 