  // [xxSTR_Constants].STR_InasistenciasSesiones.listaSesiones()
  // Por: Alberto Bachler K.: 12-06-14, 12:37:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_anchoActual;$l_AnchoArea;$l_anchoMaximo;$l_anchoMinimo;$l_anchoReservado;$l_fila;$l_FilaSeleccionada;$l_idProfesor;$l_itemSeleccionado)
C_POINTER:C301($y_nivel_at;$y_curso_at;$y_emailProfesor_at;$y_fechaSesion_ad;$y_hora_al;$y_idProfesor_al;$y_listaSesiones;$y_nivelNumero_al;$y_nombreAsignatura_at;$y_profesor_at)
C_TEXT:C284($t_cuerpoCorreo;$t_emailProfesor;$t_nombreProfesor;$t_sexo)

ARRAY LONGINT:C221($al_idProfesores;0)

$y_listaSesiones:=OBJECT Get pointer:C1124(Object named:K67:5;"listaSesiones")
$y_fechaSesion_ad:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_nombreAsignatura_at:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura")
$y_nivel_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivel")
$y_curso_at:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")
$y_profesor_at:=OBJECT Get pointer:C1124(Object named:K67:5;"profesor")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroNivel")
$y_hora_al:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")
$y_emailProfesor_at:=OBJECT Get pointer:C1124(Object named:K67:5;"email")
$y_idProfesor_al:=OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If ((Contextual click:C713) | (Macintosh option down:C545 | Windows Alt down:C563))
			$l_FilaSeleccionada:=$y_profesor_at->
			$l_idProfesor:=$y_IdProfesor_al->{$l_FilaSeleccionada}
			$t_nombreProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Nombre_comun:21)
			$t_sexo:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Sexo:5)
			If ($y_emailProfesor_at->{$l_FilaSeleccionada}#"")
				$l_itemSeleccionado:=Pop up menu:C542(__ ("Generar correo recordatorio para ")+$t_nombreProfesor+";Generar correo recordatorio para todos")
			Else 
				$l_itemSeleccionado:=Pop up menu:C542("("+__ ("Generar correo recordatorio para ")+$t_nombreProfesor+";Generar correo recordatorio para todos")
			End if 
			
			If ($l_itemSeleccionado>0)
				If ($l_itemSeleccionado=1)
					APPEND TO ARRAY:C911($al_idProfesores;$l_idProfesor)
				Else 
					COPY ARRAY:C226($y_idProfesor_al->;$al_idProfesores)
					AT_DistinctsArrayValues (->$al_idProfesores)
				End if 
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Enviando Recordatorio...")
				For ($i;1;Size of array:C274($al_idProfesores))
					
					If ($i=1)
						$currentErrorHandler:=SN3_SetErrorHandler ("set")
						C_TIME:C306($refXMLDoc)
						vb_ModoEnvio:=True:C214  //requerido por SN3_BuildFileHeader
						$vt_FileName:=SN3_CreateFile2Send ("crear";"";5005;"sax";->$refXMLDoc)
						SN3_BuildFileHeader ($refXMLDoc;5005;"templeta";False:C215;True:C214)
						SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;"ST.Alerta.html")
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						SAX_CreateNode ($refXMLDoc;"correos")
					End if 
					
					ARRAY DATE:C224($ad_Fecha;0)
					ARRAY TEXT:C222($at_Texto;0)
					
					$l_idProfesor:=$al_idProfesores{$i}
					$t_emailProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]eMail_profesional:38)
					$t_nombreProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Nombre_comun:21)
					$t_sexo:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Sexo:5)
					If ($t_sexo="M")
						$t_cuerpoCorreo:="Estimado "+$t_nombreProfesor+","+"\r\r"
					Else 
						$t_cuerpoCorreo:="Estimada "+$t_nombreProfesor+","+"\r\r"
					End if 
					$t_cuerpoCorreo:=$t_cuerpoCorreo+"Te recordamos que no has registrado la asistencia en las siguientes sesiones de clases: \r"
					$l_fila:=Find in array:C230($y_IdProfesor_al->;$l_idProfesor)
					
					While ($l_fila>0)
						APPEND TO ARRAY:C911($ad_Fecha;$y_fechaSesion_ad->{$l_fila})
						APPEND TO ARRAY:C911($at_Texto;$y_nombreAsignatura_at->{$l_fila}+": "+$y_curso_at->{$l_fila}+", hora "+String:C10($y_hora_al->{$l_fila}))
						$l_fila:=Find in array:C230($y_IdProfesor_al->;$l_idProfesor;$l_fila+1)
					End while 
					SORT ARRAY:C229($ad_Fecha;$at_Texto;>)
					
					For ($n;1;Size of array:C274($at_Texto))
						$t_cuerpoCorreo:=$t_cuerpoCorreo+String:C10($ad_Fecha{$n};System date short:K1:1)+": "+$at_Texto{$n}+"\r"
					End for 
					
					$t_cuerpoCorreo:=$t_cuerpoCorreo+"\r\r"+__ ("Por favor ingresa a Schooltrack y registra las inasistencias en las sesiones indicadas.")
					$t_cuerpoCorreo:=$t_cuerpoCorreo+"\r\r"+__ ("Atentamente, ")+"\r\r"+<>tUSR_CurrentUserName
					
					  //MONO 09-04-2015 enviamos los correos a SN3 para que sean enviados desde ahi, ademas generamos una notificacion al usuario
					NTC_CreaMensaje ("SchoolTrack";"Recordatorio de registro de asistencia";$t_cuerpoCorreo;KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$l_idProfesor;->[xShell_Users:47]No:1))
					  //OPEN WEB URL("mailto:"+$t_emailProfesor+"?subject=Recordatorio de registro de asistencia&body="+$t_cuerpoCorreo)
					
					If (SMTP_VerifyEmailAddress ($t_emailProfesor;False:C215)#"")
						$from:=ST_Qte (<>tUSR_CurrentUserName)+"<Schooltrack@colegium.com>"
						$subject:="Recordatorio de registro de asistencia"
						$replyto:=<>tUSR_CurrentUserEmail  // usuario logeado
						$err:=""
						
						$t_cuerpoCorreo:=Replace string:C233($t_cuerpoCorreo;"\r";"<br />")
						SAX_CreateNode ($refXMLDoc;"correo")
						SAX_CreateNode ($refXMLDoc;"nombre_colegio";True:C214;<>gCustom;True:C214)
						SAX_CreateNode ($refXMLDoc;"de";True:C214;$from;True:C214)
						SAX_CreateNode ($refXMLDoc;"para";True:C214;$t_emailProfesor;True:C214)
						  //SAX_CreateNode ($refXMLDoc;"cc";True;$ccMail;True)
						  //SAX_CreateNode ($refXMLDoc;"cco";True;$ccO;True)
						SAX_CreateNode ($refXMLDoc;"replyto";True:C214;$replyto;True:C214)
						SAX_CreateNode ($refXMLDoc;"asunto";True:C214;$subject;True:C214)
						SAX_CreateNode ($refXMLDoc;"cuerpo";True:C214;$t_cuerpoCorreo;True:C214)
						
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idProfesores))
					End if 
					
					If ($i=Size of array:C274($al_idProfesores))
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
						$ftpDirectory:="/SchoolFiles3/"
						$ftpConnectionID:=0
						$vt_FileName:=Replace string:C233($vt_FileName;".snt";".zip")
						$filePath:=$vt_FileName
						$hostPath:=$ftpDirectory+SYS_Path2FileName ($vt_FileName)
						SN3_LoadGeneralSettings 
						$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$filePath;$hostPath;True:C214;->$ftpConnectionID;True:C214)
						If ($errorString#"")
							SN3_RegisterLogEntry (SN3_Log_Error;"El archivo "+SYS_Path2FileName ($vt_FileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
							CD_Dlog (0;"El archivo "+SYS_Path2FileName ($vt_FileName)+" no pudo ser transferido a causa de un error FTP: "+$errorString)
						Else 
							SN3_RegisterLogEntry (SN3_Log_FileSent;"El archivo "+SYS_Path2FileName ($vt_FileName)+" ha sido transferido exitósamente.")
						End if 
						SN3_SetErrorHandler ("clear";$currentErrorHandler)
					End if 
					
				End for 
				
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				
			End if 
		End if 
		
	: ((Form event:C388=On Resize:K2:27) | (Form event:C388=On Column Resize:K2:31))
		$l_AnchoArea:=IT_Objeto_Ancho ("listaSesiones")
		$l_anchoActual:=LISTBOX Get column width:C834(*;"profesor";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoMaximo
		$l_anchoActual:=$l_anchoActual+LISTBOX Get column width:C834(*;"fecha";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoReservado+$l_anchoMaximo
		$l_anchoActual:=$l_anchoActual+LISTBOX Get column width:C834(*;"hora";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoReservado+$l_anchoMaximo
		$l_anchoReservado:=$l_anchoReservado+16
		LISTBOX SET COLUMN WIDTH:C833(*;"asignatura";$l_AnchoArea-$l_anchoReservado)
		
End case 