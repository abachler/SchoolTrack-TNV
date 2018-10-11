C_TEXT:C284($text;$motivo;$mail;$ultimoAcceso)
C_POINTER:C301($fieldPtr1;$fieldPtr2;$fieldPtr3;$fieldPtr4;$fieldPtr5;$fieldPtr6)
If (vt_g1#"")
	If (cb_SendMailInactivar=1)
		$motivo:=CD_Request (__ ("Por favor ingrese un motivo para la inactivación (Puede dejar este texto vacío para enviar sólo una notificación):");__ ("Inactivar");__ ("Cancelar"))
	Else 
		OK:=1
	End if 
	If (ok=1)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Personas:7])
		$delimiter:=ACTabc_DetectDelimiter (vt_g1)
		$ref:=Open document:C264(vt_g1;"";Read mode:K24:5)
		ARRAY TEXT:C222($atipo;0)
		ARRAY TEXT:C222($aIds;0)
		ARRAY TEXT:C222($estados;0)
		ARRAY TEXT:C222($anombres;0)
		ARRAY TEXT:C222($Identificadores;0)
		ARRAY TEXT:C222($aMotivos;0)
		If (ok=1)
			Case of 
				: (C_op1=1)
					$fieldPtr1:=->[Alumnos:2]RUT:5
					$fieldPtr2:=->[Personas:7]RUT:6
				: (C_op2=1)
					$fieldPtr1:=->[Alumnos:2]IDNacional_2:71
					$fieldPtr2:=->[Personas:7]IDNacional_2:37
				: (C_op3=1)
					$fieldPtr1:=->[Alumnos:2]IDNacional_3:70
					$fieldPtr2:=->[Personas:7]IDNacional_3:38
				: (C_op4=1)
					$fieldPtr1:=->[Alumnos:2]NoPasaporte:87
					$fieldPtr2:=->[Personas:7]Pasaporte:59
				: (C_op5=1)
					$fieldPtr1:=->[Alumnos:2]Codigo_interno:6
					$fieldPtr2:=->[Personas:7]Codigo_interno:22
			End case 
			$fieldPtr3:=->[Alumnos:2]numero:1
			$fieldPtr4:=->[Personas:7]No:1
			$fieldPtr5:=->[Alumnos:2]apellidos_y_nombres:40
			$fieldPtr6:=->[Personas:7]Apellidos_y_nombres:30
			If (cb_TieneEncabezado=1)
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End if 
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			While ($text#"")
				$id:=ST_GetWord ($text;1;"\t")
				$estado:=ST_GetWord ($text;2;"\t")
				If (($estado="Activo") | ($estado="false") | ($estado="falso") | ($estado="0") | ($estado="no"))
					$estado:="0"
				Else 
					$estado:="1"
				End if 
				QUERY:C277([Alumnos:2];$fieldPtr1->=$id)
				If (Records in selection:C76([Alumnos:2])=1)
					APPEND TO ARRAY:C911($aIds;String:C10($fieldPtr3->))
					APPEND TO ARRAY:C911($estados;$estado)
					APPEND TO ARRAY:C911($atipo;"2")
					APPEND TO ARRAY:C911($anombres;$fieldPtr5->)
				Else 
					QUERY:C277([Personas:7];$fieldPtr2->=$id)
					If (Records in selection:C76([Personas:7])=1)
						APPEND TO ARRAY:C911($aIds;String:C10($fieldPtr4->))
						APPEND TO ARRAY:C911($estados;$estado)
						APPEND TO ARRAY:C911($atipo;"1")
						APPEND TO ARRAY:C911($anombres;$fieldPtr6->)
					Else 
						  //APPEND TO ARRAY($aIdentificadores;$id)
						  //APPEND TO ARRAY($aMotivos;"Usuario no encontrado.")
					End if 
				End if 
				RECEIVE PACKET:C104($ref;$text;$delimiter)
			End while 
			CLOSE DOCUMENT:C267($ref)
			If (Size of array:C274($estados)>0)
				SN3_CreaRegistroLog (Self:C308)
				$mail:=String:C10(cb_SendMailInactivar)
				WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
				WEB SERVICE SET PARAMETER:C777("rolbasedatos";<>gRolBD)
				WEB SERVICE SET PARAMETER:C777("enviarxmail";$mail)
				WEB SERVICE SET PARAMETER:C777("motivoinactivacion";$motivo)
				WEB SERVICE SET PARAMETER:C777("tipo";$atipo)
				WEB SERVICE SET PARAMETER:C777("idusuarios";$aIds)
				WEB SERVICE SET PARAMETER:C777("estados";$estados)
				$p:=IT_UThermometer (1;0;__ ("Enviando datos a SchoolNet..."))
				$err:=SN3_CallWebService ("sn3ws_activacion_proceso.masiva")
				IT_UThermometer (-2;$p)
				If ($err="")
					ARRAY TEXT:C222($resultados;0)
					WEB SERVICE GET RESULT:C779($resultados;"resultados";*)
					$noCambiados:=""
					For ($i;1;Size of array:C274($resultados))
						$elem:=$resultados{$i}
						$res:=ST_GetWord ($elem;1;Char:C90(10))
						If ($res="-1")
							$nombres:=$anombres{$i}
							$noCambiados:=$noCambiados+$nombres+"\r"
						End if 
					End for 
					If (cb_Listar=1)
						SN3_InitConsultaUsuarios 
						AT_RedimArrays (Size of array:C274($resultados);->SN3_AyNUsuarios;->SN3_TipoUsuario;->SN3_TipoCodeUsuario;->SN3_LoginUsuarios;->SN3_PasswordUsuarios;->SN3_CodeUsuarios;->SN3_InactivoUsuarios;->SN3_ColorsUsuarios;->SN3_StylesUsuarios;->SN3_BacksUsuarios;->SN3_ModificadoWebUsuarios;->SN3_CursosUsuarios;->SN3_ultimo_ingreso)  //mono ticket 201247
						For ($i;1;Size of array:C274($resultados))
							$elem:=$resultados{$i}
							$res:=ST_GetWord ($elem;1;Char:C90(10))
							$tipo:=$atipo{$i}
							$nombres:=$anombres{$i}
							$login:=ST_GetWord ($elem;2;Char:C90(10))
							$pass:=ST_GetWord ($elem;3;Char:C90(10))
							$code:=ST_GetWord ($elem;4;Char:C90(10))
							$modificadoWeb:=ST_GetWord ($elem;5;Char:C90(10))
							$ultimoAcceso:=ST_GetWord ($elem;6;Char:C90(10))  //mono ticket 201247
							SN3_TipoCodeUsuario{$i}:=$tipo
							SN3_AyNUsuarios{$i}:=$nombres
							SN3_LoginUsuarios{$i}:=$login
							SN3_PasswordUsuarios{$i}:=$pass
							SN3_CodeUsuarios{$i}:=$code
							If (($res="0") | ($res="1"))
								SN3_InactivoUsuarios{$i}:=Num:C11($estados{$i})
							Else 
								If ($estados{$i}="1")
									SN3_InactivoUsuarios{$i}:=0
								Else 
									SN3_InactivoUsuarios{$i}:=1
								End if 
							End if 
							SN3_ModificadoWebUsuarios{$i}:=Num:C11($modificadoWeb)
							If (SN3_InactivoUsuarios{$i}=1)
								SN3_ColorsUsuarios{$i}:=0x007F7F7F
							Else 
								  //SN3_ColorsUsuarios{$i}:=0x0000
								SN3_ColorsUsuarios{$i}:=-255
							End if 
							If (SN3_ModificadoWebUsuarios{$i}=1)
								SN3_StylesUsuarios{$i}:=Italic:K14:3
							End if 
							Case of 
								: (SN3_TipoCodeUsuario{$i}="2")
									SN3_TipoUsuario{$i}:="Alumno"
								: (SN3_TipoCodeUsuario{$i}="1")
									SN3_TipoUsuario{$i}:="Familiar"
							End case 
							SN3_BacksUsuarios{$i}:=0x00FFFFFF
							SN3_ultimo_ingreso{$i}:=$ultimoAcceso  //mono ticket 201247
						End for 
						SORT ARRAY:C229(SN3_AyNUsuarios;SN3_TipoUsuario;SN3_TipoCodeUsuario;SN3_LoginUsuarios;SN3_PasswordUsuarios;SN3_CodeUsuarios;SN3_InactivoUsuarios;SN3_ColorsUsuarios;SN3_StylesUsuarios;SN3_BacksUsuarios;SN3_ModificadoWebUsuarios;SN3_CursosUsuarios;SN3_ultimo_ingreso;>)  //mono ticket 201247
						COPY ARRAY:C226(SN3_TipoUsuario;SN3_TipoUsuarioCpy)
						COPY ARRAY:C226(SN3_TipoUsuario;SN3_TipoUsuarioCpy)
						COPY ARRAY:C226(SN3_TipoCodeUsuario;SN3_TipoCodeUsuarioCpy)
						COPY ARRAY:C226(SN3_AyNUsuarios;SN3_AyNUsuariosCpy)
						COPY ARRAY:C226(SN3_LoginUsuarios;SN3_LoginUsuariosCpy)
						COPY ARRAY:C226(SN3_PasswordUsuarios;SN3_PasswordUsuariosCpy)
						COPY ARRAY:C226(SN3_CodeUsuarios;SN3_CodeUsuariosCpy)
						COPY ARRAY:C226(SN3_InactivoUsuarios;SN3_InactivoUsuariosCpy)
						COPY ARRAY:C226(SN3_ColorsUsuarios;SN3_ColorsUsuariosCpy)
						COPY ARRAY:C226(SN3_StylesUsuarios;SN3_StylesUsuariosCpy)
						COPY ARRAY:C226(SN3_BacksUsuarios;SN3_BacksUsuariosCpy)
						COPY ARRAY:C226(SN3_ModificadoWebUsuarios;SN3_ModificadoWebUsuariosCpy)
						COPY ARRAY:C226(SN3_ultimo_ingreso;SN3_ultimo_ingresoCpy)  //mono ticket 201247
						
						If (Size of array:C274(SN3_AyNUsuarios)>0)
							SN3_ListMessage:="Mostrando "+String:C10(Size of array:C274(SN3_AyNUsuarios))+" de "+String:C10(Size of array:C274(SN3_AyNUsuarios))+" recibidos."
							_O_ENABLE BUTTON:C192(*;"opcionesLista@")
						End if 
					End if 
					If ($noCambiados#"")
						IT_ShowScrollableText ($noCambiados;"Los siguientes usuarios no pudieron ser cambiados de estado:")
					End if 
				Else 
					CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Error en la lectura del archivo."))
			CLOSE DOCUMENT:C267($ref)
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Por favor seleccione un archivo."))
End if 
CANCEL:C270