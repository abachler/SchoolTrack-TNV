  //Método de Objeto: [Alumnos_Conducta].LateExpress.sName

C_LONGINT:C283($id)
Case of 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Self:C308->#"")
			$num:=Num:C11(Self:C308->)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=sCurso)
			If ($num>0)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53=$num)
			Else 
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apellido_paterno:3=(Self:C308->+"@"))
			End if 
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
			QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Status:50="En trámite")
			
			Case of 
				: (Records in selection:C76([Alumnos:2])=0)
					CD_Dlog (0;__ ("Alumno inexistente."))
					Self:C308->:=""
					LId:=0
					GOTO OBJECT:C206(Self:C308->)
					
				: (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido ant@") | ([Alumnos:2]Status:50="Egresado"))
					CD_Dlog (0;__ ("El alumno tiene asignado el estado ")+[Alumnos:2]Status:50+__ (".\r\rNo es posible registrar el atraso."))
					Self:C308->:=""
					LId:=0
					GOTO OBJECT:C206(Self:C308->)
					
				: (Records in selection:C76([Alumnos:2])=1)
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
					QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=dDate)
					If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
						QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1)
						QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=dDate;*)
						QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
						If (Records in selection:C76([Alumnos_Atrasos:55])=0)
							Self:C308->:=[Alumnos:2]apellidos_y_nombres:40
							LId:=[Alumnos:2]numero:1
							GOTO OBJECT:C206(dDate)
							HIGHLIGHT TEXT:C210(dDate;80;80)
						Else 
							If (<>gAllowMultipleLates=1)
								Self:C308->:=[Alumnos:2]apellidos_y_nombres:40
								LId:=[Alumnos:2]numero:1
								GOTO OBJECT:C206(dDate)
								HIGHLIGHT TEXT:C210(dDate;80;80)
							Else 
								CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya tiene registrado un atraso al inicio de jornada en esta fecha."))
								Self:C308->:=""
								LId:=0
								GOTO OBJECT:C206(sName)
							End if 
						End if 
					Else 
						CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya está registrado como inasistente en esta fecha."))
						Self:C308->:=""
						LId:=0
					End if 
					
				: (Records in selection:C76([Alumnos:2])>1)
					READ ONLY:C145([Alumnos:2])
					SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aGenNme;[Alumnos:2]numero:1;<>aGenId)
					ARRAY POINTER:C280(<>aChoicePtrs;2)
					<>aChoicePtrs{1}:=-><>aGenNme
					<>aChoicePtrs{2}:=-><>aGenID
					TBL_ShowChoiceList (1)
					If ((ok=1) & (choiceIdx>0))
						$id:=<>aChoicePtrs{2}->{choiceIdx}
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id)
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
						QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=dDate)
						If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
							QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1)
							QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=dDate;*)
							QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
							If (Records in selection:C76([Alumnos_Atrasos:55])=0)
								Self:C308->:=[Alumnos:2]apellidos_y_nombres:40
								LId:=[Alumnos:2]numero:1
								GOTO OBJECT:C206(dDate)
								HIGHLIGHT TEXT:C210(dDate;80;80)
							Else 
								If (<>gAllowMultipleLates=1)
									Self:C308->:=[Alumnos:2]apellidos_y_nombres:40
									LId:=[Alumnos:2]numero:1
									GOTO OBJECT:C206(dDate)
									HIGHLIGHT TEXT:C210(dDate;80;80)
								Else 
									CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya tiene registrado un atraso al inicio de jornada en esta fecha."))
									Self:C308->:=""
									LId:=0
									GOTO OBJECT:C206(sName)
								End if 
							End if 
						Else 
							CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya está registrado como inasistente en esta fecha."))
							Self:C308->:=""
							LId:=0
						End if 
					Else 
						Self:C308->:=""
						LId:=0
						GOTO OBJECT:C206(Self:C308->)
					End if 
			End case 
		End if 
End case 


