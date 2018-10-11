
Case of 
	: (Form event:C388=On Data Change:K2:15)
		[Alumnos:2]RUT:5:=ST_Uppercase ([Alumnos:2]RUT:5)
		If (Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1))>0)
			[Alumnos:2]RUT:5:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5)
			If ([Alumnos:2]RUT:5#"")
				If (KRL_RecordExists (->[Alumnos:2]RUT:5))
					
					PUSH RECORD:C176([Alumnos:2])
					C_LONGINT:C283($cantidad)
					  //verificar si el alumno ya esta postulando, en dicho caso no es posible cargar sus datos
					SET QUERY DESTINATION:C396(Into variable:K19:4;$cantidad)
					QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]RUT:46=[Alumnos:2]RUT:5)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					If ($cantidad=0)
						SET QUERY DESTINATION:C396(Into set:K19:2;"alumnoBD")
						  //SET QUERY DESTINATION(Into variable ;$var)
						QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Alumnos:2]RUT:5)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						USE SET:C118("alumnoBD")
						
						If (Records in selection:C76([Alumnos:2])>0)
							If ([Alumnos:2]Status:50#"Activo")
								
								$r:=CD_Dlog (0;__ ("Ya existe un alumno con el identificador ingresado. Desea cargar los datos del candidato desde el registro almacenado?");__ ("");__ ("Si");__ ("No"))
								
								Case of 
									: ($r=1)  //si
										  //se cambia el nivel del alumno, para que quede en admisiones como candidato
										  //cambiar el estado del registro de accountrack si es que existe, de lo contrario crearlo
										
										USE SET:C118("alumnoBD")
										KRL_ReloadInReadWriteMode (->[Alumnos:2])
										[Alumnos:2]nivel_numero:29:=-1003
										[Alumnos:2]Nivel_Nombre:34:="AdmissionTrack"
										[Alumnos:2]curso:20:="POST"
										[Alumnos:2]Status:50:="Candidato"
										[Alumnos:2]Curso_alRetirarse:83:=""
										[Alumnos:2]Motivo_de_retiro:43:=""
										[ADT_Candidatos:49]Candidato_numero:1:=[Alumnos:2]numero:1
										
										
										QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
										vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
										  //cargar los datos de la familia
										PST_GetFamilyRelations 
										
										  //situacion en ACT
										READ WRITE:C146([ACT_CuentasCorrientes:175])
										QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
										
										If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
											  //activar la cuenta corriente
											[ACT_CuentasCorrientes:175]Estado:4:=True:C214
											SAVE RECORD:C53([ACT_CuentasCorrientes:175])
											UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
										Else 
											ACTcc_CreaCuentaCorriente 
										End if 
										
									: ($r=2)  //no
										  //se vuelve al registro anterior y permite ingresar de nuevo el RUT del postulante
										POP RECORD:C177([Alumnos:2])
										[Alumnos:2]RUT:5:=""
										GOTO OBJECT:C206([Alumnos:2]RUT:5)
								End case 
							Else 
								CD_Dlog (0;__ ("El identiificador ingresado pertenece a un alumno activo actualmente en la base de datos del sistema."))
								POP RECORD:C177([Alumnos:2])
								[Alumnos:2]RUT:5:=""
								GOTO OBJECT:C206([Alumnos:2]RUT:5)
							End if 
						End if 
						
					Else   //`cierre if de $cantidad=0
						CD_Dlog (0;__ ("El rut ingresado pertenece a un candidato ya ingresado al sistema."))
						POP RECORD:C177([Alumnos:2])
						[Alumnos:2]RUT:5:=""
						GOTO OBJECT:C206([Alumnos:2]RUT:5)
					End if 
				Else 
					PST_LoadPostHist (Self:C308->)
					If (Records in selection:C76([xxADT_PostulacionesHistoricas:112])>0)
						WDW_OpenFormWindow (->[xxADT_PostulacionesHistoricas:112];"Manager";0;4;__ ("Postulaciones Históricas"))
						DIALOG:C40([xxADT_PostulacionesHistoricas:112];"Manager")
						CLOSE WINDOW:C154
					End if 
				End if 
			Else 
				GOTO OBJECT:C206([Alumnos:2]RUT:5)
			End if 
		Else 
			OBJECT SET FORMAT:C236([Alumnos:2]RUT:5;"")
		End if 
		AL_SetIdentificadorPrincipal 
End case 