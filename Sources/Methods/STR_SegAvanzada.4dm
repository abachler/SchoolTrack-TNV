//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 06/09/17, 09:12:27
  // ----------------------------------------------------
  // Método: STR_SegAvanzanda
  // Descripción

  // Los parámetros varian del caso. 
  // ----------------------------------------------------
C_TEXT:C284($t_accion;$t_nomUser;$t_password;$t_texto1;$t_texto)
C_TEXT:C284($t_cuerpo;$t_asunto;$t_correo;$t_pass)
C_OBJECT:C1216($ob_temp;$ob)
C_LONGINT:C283($l_MaxC;$l_Min1;$l_Min2;$l_resultado;$l_creaAutomatico;$l_enviocorreo;$l_MaxG)
C_LONGINT:C283($l_color;$l_cont;$l_CaracNoP)
C_LONGINT:C283($vi_user1;$vi_user2;$vi_user3;$vi_user4)
C_POINTER:C301($y_opcion1;$y_opcion2;$y_opcion3;$y_opcion4;$y_ProximoInicio;$y_CreaUsuario)
C_LONGINT:C283($l_contCarac;$l_contCaracM;$l_contCaracN;$cod)
C_BOOLEAN:C305($b_mostrar;$b_noautoriza)
C_POINTER:C301($y_ob;$y_ob_Parametros)

$y_ob_Parametros:=$1
OB_GET ($y_ob_Parametros->;->$t_accion;"accion")
Case of 
	: ($t_accion="CreaObjeto")
		
		$vi_user1:=1
		$vi_user2:=0
		$vi_user3:=0
		$vi_user4:=0
		$vi_creaAutomatico:=0
		$vi_enviocorreo:=0
		
		$l_MaxG:=15
		$l_MaxC:=4
		$l_Min1:=0
		$l_Min2:=0
		
		$ob_temp:=OB_Create 
		OB_SET ($ob_temp;->$vi_user1;"vi_user1")
		OB_SET ($ob_temp;->$vi_user2;"vi_user2")
		OB_SET ($ob_temp;->$vi_user3;"vi_user3")
		OB_SET ($ob_temp;->$vi_user4;"vi_user4")
		OB_SET ($ob_temp;->$l_MaxG;"MaxCaracteresG")
		OB_SET ($ob_temp;->$l_MaxC;"MaxCaracteres")
		OB_SET ($ob_temp;->$l_Min1;"MinMayusculas")
		OB_SET ($ob_temp;->$l_Min2;"MinNumerico")
		OB_SET ($ob_temp;->$vi_creaAutomatico;"vi_creaAutomatico")
		OB_SET ($ob_temp;->$vi_enviocorreo;"vi_enviocorreo")
		$0:=$ob_temp
		
	: ($t_accion="CargaVariables")
		
		$ob_temp:=$y_ob_Parametros->
		
		$y_opcion1:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion1")
		$y_opcion2:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion2")
		$y_opcion3:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion3")
		$y_opcion4:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion4")
		
		$y_ProximoInicio:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_ProximoInicio")
		$y_ProximoInicio->:=0
		$y_CreaUsuario:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_Creauser1")
		$y_CreaUsuario->:=0
		$y_enviaCorreo:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_enviacorreo")
		$y_enviaCorreo->:=0
		
		OB_GET ($ob_temp;$y_opcion1;"vi_user1")
		OB_GET ($ob_temp;$y_opcion2;"vi_user2")
		OB_GET ($ob_temp;$y_opcion3;"vi_user3")
		OB_GET ($ob_temp;$y_opcion4;"vi_user4")
		
		OB_GET ($ob_temp;->$l_MaxG;"MaxCaracteresG")
		OB_GET ($ob_temp;->$l_MaxC;"MaxCaracteres")
		OB_GET ($ob_temp;->$l_Min1;"MinMayusculas")
		OB_GET ($ob_temp;->$l_Min2;"MinNumerico")
		OB_GET ($ob_temp;->$l_creaAutomatico;"vi_creaAutomatico")
		OB_GET ($ob_temp;->$l_enviocorreo;"vi_enviocorreo")
		
		$y_enviaCorreo->:=$l_enviocorreo
		$y_CreaUsuario->:=$l_creaAutomatico
		
		OBJECT SET ENABLED:C1123(*;"Casilla_enviacorreo";$y_CreaUsuario->=1)
		
		ARRAY LONGINT:C221(al_ListaMaxC;12)
		al_ListaMaxC{0}:=$l_MaxC
		al_ListaMaxC{1}:=4
		al_ListaMaxC{2}:=5
		al_ListaMaxC{3}:=6
		al_ListaMaxC{4}:=7
		al_ListaMaxC{5}:=8
		al_ListaMaxC{6}:=9
		al_ListaMaxC{7}:=10
		al_ListaMaxC{8}:=11
		al_ListaMaxC{9}:=12
		al_ListaMaxC{10}:=13
		al_ListaMaxC{11}:=14
		al_ListaMaxC{12}:=15
		
		ARRAY LONGINT:C221(al_ListaMinMAY;0)
		APPEND TO ARRAY:C911(al_ListaMinMAY;0)
		For ($i;1;$l_MaxC)
			APPEND TO ARRAY:C911(al_ListaMinMAY;$i)
		End for 
		al_ListaMinMAY{0}:=$l_Min1
		
		ARRAY LONGINT:C221(al_ListaMinNum;0)
		APPEND TO ARRAY:C911(al_ListaMinNum;0)
		For ($i;1;$l_MaxC)
			APPEND TO ARRAY:C911(al_ListaMinNum;$i)
		End for 
		al_ListaMinNum{0}:=$l_Min2
		
	: ($t_accion="GuardaObjeto")
		
		$y_opcion1:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion1")
		$y_opcion2:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion2")
		$y_opcion3:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion3")
		$y_opcion4:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_opcion4")
		
		$y_ProximoInicio:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_ProximoInicio")
		$y_CreaUsuario:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_Creauser1")
		$y_enviaCorreo:=OBJECT Get pointer:C1124(Object named:K67:5;"Casilla_enviacorreo")
		
		$ob_temp:=OB_Create 
		OB_SET ($ob_temp;$y_opcion1;"vi_user1")
		OB_SET ($ob_temp;$y_opcion2;"vi_user2")
		OB_SET ($ob_temp;$y_opcion3;"vi_user3")
		OB_SET ($ob_temp;$y_opcion4;"vi_user4")
		
		$l_MaxG:=15
		$l_MaxC:=al_ListaMaxC{0}
		$l_Min1:=al_ListaMinMAY{0}
		$l_Min2:=al_ListaMinNum{0}
		
		OB_SET ($ob_temp;->$l_MaxG;"MaxCaracteresG")
		OB_SET ($ob_temp;->$l_MaxC;"MaxCaracteres")
		OB_SET ($ob_temp;->$l_Min1;"MinMayusculas")
		OB_SET ($ob_temp;->$l_Min2;"MinNumerico")
		
		OB_SET ($ob_temp;$y_CreaUsuario;"vi_creaAutomatico")
		OB_SET ($ob_temp;$y_enviaCorreo;"vi_enviocorreo")
		
		LOG_RegisterEvt ("Configuración  de contraseñas Almacenada.")
		$0:=$ob_temp
		
	: ($t_accion="GeneraNombreUsuario")
		
		C_OBJECT:C1216($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET_Text ($ob_crea;"CreaObjeto";"accion")
		$ob_temp:=STR_SegAvanzada (->$ob_crea)
		
		$ob:=PREF_fGetObject (0;"PreferenciaContraseñas";$ob_temp)
		OB_GET ($ob;->$vi_user1;"vi_user1")
		OB_GET ($ob;->$vi_user2;"vi_user2")
		OB_GET ($ob;->$vi_user3;"vi_user3")
		OB_GET ($ob;->$vi_user4;"vi_user4")
		
		Case of 
				  //cambir objetos
			: ($vi_user1=1)
				$t_nomUser:=[Profesores:4]Nombre_comun:21
				
			: ($vi_user2=1)
				$t_nomUser:=Substring:C12([Profesores:4]Nombres:2;1;1)+[Profesores:4]Apellido_paterno:3
				
			: ($vi_user3=1)
				$t_nomUser:=Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+ST_GetWord ([Profesores:4]Nombres:2;1)
				
			: ($vi_user4=1)
				$t_nomUser:=ST_GetWord ([Profesores:4]Nombres:2;1)+ST_GetWord ([Profesores:4]Apellido_paterno:3;1)
				
		End case 
		
		  //Para no repetir nombres de usuarios.
		$l_contCarac:=1
		$t_nomUser:=$t_nomUser
		While (Find in field:C653([xShell_Users:47]login:9;$t_nomUser)#-1)
			$t_nomUser:=$t_nomUser+String:C10($l_contCarac)
			$l_contCarac:=$l_contCarac+1
		End while 
		
		CLEAR VARIABLE:C89($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET ($ob_crea;->$t_nomUser;"login")
		$0:=$ob_crea
		
	: ($t_accion="GeneraContraseña")
		
		C_OBJECT:C1216($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET_Text ($ob_crea;"CreaObjeto";"accion")
		$ob_temp:=STR_SegAvanzada (->$ob_crea)
		
		$ob:=PREF_fGetObject (0;"PreferenciaContraseñas";$ob_temp)
		
		OB_GET ($ob;->$l_MaxC;"MaxCaracteres")
		OB_GET ($ob;->$l_Min1;"MinMayusculas")
		OB_GET ($ob;->$l_Min2;"MinNumerico")
		
		$l_contCarac:=1
		$l_contCaracM:=0
		$l_contCaracN:=0
		$t_Password:=""
		While ($l_contCarac<=$l_MaxC)
			Case of 
				: (($l_Min1>0) & ($l_contCaracM<$l_Min1))
					  //cantidad digitos mayusculas
					$l_contCaracM:=$l_contCaracM+1
					$l_contCarac:=$l_contCarac+1
					$t_Password:=$t_Password+Char:C90((Random:C100%(90-65+1))+65)
					
				: ($l_Min2>=0) & ($l_contCaracN<$l_Min2)
					  //cantidad de digitos numericos
					$l_contCaracN:=$l_contCaracN+1
					$l_contCarac:=$l_contCarac+1
					$t_Password:=$t_Password+Char:C90((Random:C100%(57-48+1))+48)
					
				Else 
					
					If ($l_Min1=0)
						  //si en la configracion tienen 0 mayusculas siempre escribe 1
						$l_contCaracM:=$l_contCaracM+1
						$l_contCarac:=$l_contCarac+1
						$t_Password:=$t_Password+Char:C90((Random:C100%(90-65+1))+65)
						$l_Min1:=-1
					End if 
					If ($l_Min2=0)
						  //si en la configracion tienen 0 numerico siempre escribe 2 numeros
						$l_contCaracN:=$l_contCaracN+2
						$l_contCarac:=$l_contCarac+2
						$t_Password:=$t_Password+Char:C90((Random:C100%(57-48+1))+48)+Char:C90((Random:C100%(57-48+1))+48)
						$l_Min2:=-1
					End if 
					
					$l_contCarac:=$l_contCarac+1
					$t_Password:=$t_Password+Char:C90((Random:C100%(122-97+1))+97)
			End case 
		End while 
		  //$0:=$t_Passwor
		
		CLEAR VARIABLE:C89($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET ($ob_crea;->$t_Password;"pass")
		$0:=$ob_crea
		
	: ($t_accion="ValidaCaracteres")
		
		OB_GET ($y_ob_Parametros->;->$t_texto;"pass")
		
		C_OBJECT:C1216($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET_Text ($ob_crea;"CreaObjeto";"accion")
		$ob_temp:=STR_SegAvanzada (->$ob_crea)
		$ob:=PREF_fGetObject (0;"PreferenciaContraseñas";$ob_temp)
		
		OB_GET ($ob;->$l_MaxG;"MaxCaracteresG")
		OB_GET ($ob;->$l_MaxC;"MaxCaracteres")
		OB_GET ($ob;->$l_Min1;"MinMayusculas")
		OB_GET ($ob;->$l_Min2;"MinNumerico")
		
		$l_resultado:=0
		$t_texto1:=""
		  //creo mensajes en blanco
		$l_contCarac:=0
		$l_contCaracM:=0
		$l_contCaracN:=0
		$l_cont:=0
		$l_CaracNoP:=0
		
		$l_cont:=$l_MaxC
		$l_contM:=$l_Min1
		$l_contN:=$l_Min2
		$l_contCG:=$l_MaxG
		
		  ///si se excede
		If ((Length:C16($t_texto)<=$l_MaxG))
			
			If ($t_texto#"")
				  //analizar cadenas 
				For ($i;1;Length:C16($t_texto))
					$letra:=$t_texto[[$i]]
					$cod:=Character code:C91($letra)
					If ((($cod>=65) & ($cod<=90)) | (($cod>=48) & ($cod<=57)) | (($cod>=97) & ($cod<=122)))
						
						Case of 
							: (($cod>=65) & ($cod<=90))  //MAY
								  //MAY
								$l_cont:=$l_cont-1
								$l_contCaracM:=$l_contCaracM+1
								$l_contM:=$l_contM-1
								$l_contCG:=$l_contCG-1
								
							: (($cod>=48) & ($cod<=57))  //NUM
								  //NUM
								$l_contCaracN:=$l_contCaracN+1
								$l_cont:=$l_cont-1
								$l_contN:=$l_contN-1
								$l_contCG:=$l_contCG-1
								
							: (($cod>=97) & ($cod<=122))  //minus
								$l_contCarac:=$l_contCarac+1
								$l_cont:=$l_cont-1
								$l_contCG:=$l_contCG-1
								
						End case 
					Else 
						$l_CaracNoP:=$l_CaracNoP+1
						  //es un caracter diferente
					End if 
				End for 
				
				If ($l_CaracNoP=0)
					If ((($l_cont<=0) & ($l_contM<=0) & ($l_contN<=0) & ($l_contCG>=0)))
						$t_texto1:="Contraseña Segura"
						$l_color:=0xFF00
						$b_mostrar:=False:C215
						$b_noautoriza:=False:C215
					Else 
						
						If ($l_cont<0)
							$l_cont:=0
						End if 
						
						$t_texto1:="La contraseña  debe  tener entre "+String:C10($l_MaxC)+" a "+String:C10($l_contCG)+" caracteres"
						If ($l_Min1>0)
							$l_resultado:=$l_Min1-$l_contCaracM
							If ($l_resultado<0)
								$l_resultado:=0
							End if 
							$t_texto1:=$t_texto1+", le falta "+String:C10($l_resultado)+" mayúscula(s)"
						End if 
						
						If ($l_Min2>0)
							$l_resultado:=$l_Min2-$l_contCaracN
							If ($l_resultado<0)
								$l_resultado:=0
							End if 
							$t_texto1:=$t_texto1+","+String:C10($l_resultado)+" número(s) ."
						End if 
						
						$l_color:=0x00FF0000
					End if 
				Else 
					  //caracteres no permitidos.
					$t_texto1:="No se pueden utilizar caracteres diferentes a minúsculas, mayúsculas o números."
					$l_color:=0x00FF0000
					$b_mostrar:=True:C214
					$b_noautoriza:=True:C214
					$t_pass:=Substring:C12($t_texto;1;Length:C16($t_texto)-1)
				End if 
			Else 
				  //cadena vacía
				
				$t_texto1:="La contraseña  debe  tener entre "+String:C10($l_MaxC)+" a "+String:C10($l_MaxG)+" caracteres"
				If ($l_Min1>0)
					$t_texto1:=$t_texto1+",le falta "+String:C10($l_Min1)+" mayúscula(s)"
				End if 
				If ($l_Min2>0)
					$t_texto1:=$t_texto1+","+String:C10($l_Min2)+" numero(s) "
				End if 
				$t_texto1:=$t_texto1+"."
				$l_color:=0x00FF0000
				$b_mostrar:=True:C214
			End if 
		Else 
			$t_texto1:="La contraseña no puede tener más de 15 caracteres.\rSe conservaron los primeros 15 caracteres ingresados."
			$t_pass:=Substring:C12($t_texto;1;15)
			$l_color:=0x00FF0000
			$b_mostrar:=True:C214
			$b_noautoriza:=True:C214
		End if 
		C_OBJECT:C1216($ob_texto)
		$ob_texto:=OB_Create 
		OB_SET ($ob_texto;->$t_texto1;"mensaje")
		OB_SET ($ob_texto;->$l_color;"color")
		OB_SET ($ob_texto;->$b_mostrar;"mostrar")
		OB_SET ($ob_texto;->$b_noautoriza;"Autoriza")
		OB_SET ($ob_texto;->$t_pass;"Pass")
		$0:=$ob_texto
		
	: ($t_accion="EnviaCorreo")
		C_TEXT:C284($t_pass;$t_login;$t_mail)
		
		$ob_temp:=$y_ob_Parametros->
		OB_GET ($ob_temp;->$t_pass;"pass")
		OB_GET ($ob_temp;->$t_login;"login")
		OB_GET ($ob_temp;->$t_mail;"mail")
		
		$t_asunto:="Contraseña de ingreso a Schooltrack"
		$t_cuerpo:="Estimado(a) "+ST_GetWord ([Profesores:4]Nombres:2;1)+":"+"\r"+"\r"
		$t_cuerpo:=$t_cuerpo+"La contraseña de ingreso al sistema es la siguiente. "+"\r"
		$t_cuerpo:=$t_cuerpo+"Usuario: "+$t_login+"\r"
		$t_cuerpo:=$t_cuerpo+"Contraseña: "+$t_pass+"\r"
		Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_mail)
		
		$0:=$ob_temp
		
	: ($t_accion="CreaUsuario")
		
		C_TEXT:C284($t_mail;$t_pass;$t_nomUser)
		
		C_OBJECT:C1216($ob_crea)
		$ob_crea:=OB_Create 
		OB_SET_Text ($ob_crea;"CreaObjeto";"accion")
		$ob_temp:=STR_SegAvanzada (->$ob_crea)
		$ob_preferencias:=PREF_fGetObject (0;"PreferenciaContraseñas";$ob_temp)
		
		
		OB_GET ($ob_preferencias;->$l_creaAutomatico;"vi_creaAutomatico")
		OB_GET ($ob_preferencias;->$l_enviocorreo;"vi_enviocorreo")
		
		If ($l_creaAutomatico=1)
			
			C_OBJECT:C1216($ob_tempParametros;$ob_r)
			$ob_tempParametros:=OB_Create 
			OB_SET_Text ($ob_tempParametros;"GeneraContraseña";"accion")
			OB_SET ($ob_tempParametros;->$t_pass;"pass")
			$ob_r:=STR_SegAvanzada (->$ob_tempParametros)
			OB_GET ($ob_r;->$t_pass;"pass")
			CLEAR VARIABLE:C89($ob_r)
			
			
			OB_SET_Text ($ob_tempParametros;"GeneraNombreUsuario";"accion")
			OB_SET ($ob_tempParametros;->$t_nomUser;"login")
			$ob_r:=STR_SegAvanzada (->$ob_tempParametros)
			OB_GET ($ob_r;->$t_nomUser;"login")
			CLEAR VARIABLE:C89($ob_r)
			
			  //valido que correo utilizar
			Case of 
				: ([Profesores:4]eMail_profesional:38#"")  //20180412 RCH Se cambia orden y se deja primero el profesional
					$t_correo:=[Profesores:4]eMail_profesional:38
					
				: ([Profesores:4]eMail_Personal:61#"")
					$t_correo:=[Profesores:4]eMail_Personal:61
					
					  //: ([Profesores]eMail_profesional#"")
					  //$t_correo:=[Profesores]eMail_profesional
					
				Else 
					$t_correo:=""
			End case 
			
			CREATE RECORD:C68([xShell_Users:47])
			[xShell_Users:47]No:1:=SQ_SeqNumber (->[xShell_Users:47]No:1)
			[xShell_Users:47]NoEmployee:7:=[Profesores:4]Numero:1
			[xShell_Users:47]Name:2:=[Profesores:4]Apellidos_y_nombres:28
			[xShell_Users:47]login:9:=$t_nomUser
			[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($t_pass)
			[xShell_Users:47]CambiarPassw_PrimeraSesion:25:=True:C214  //Opcion para detemrinar si cambiar contrase;a en inicio de sesion.
			[xShell_Users:47]PasswordVersion:10:=3
			[xShell_Users:47]email:20:=$t_correo
			SAVE RECORD:C53([xShell_Users:47])
			
			LOG_RegisterEvt (__ ("Creación de usuario: ")+[xShell_Users:47]Name:2+" ("+[xShell_Users:47]login:9+")"+", id: "+String:C10([xShell_Users:47]No:1)+".")
			  //envio correos i esta marcada kla opcion y solo si el usuario tiene un correo.
			If ($l_enviocorreo=1) & ($t_correo#"")
				OB_SET_Text ($ob_tempParametros;"EnviaCorreo";"accion")
				OB_SET ($ob_tempParametros;->$t_correo;"mail")
				OB_SET ($ob_tempParametros;->$t_pass;"pass")
				OB_SET ($ob_tempParametros;->$t_nomUser;"login")
				$ob_r:=STR_SegAvanzada (->$ob_tempParametros)
				OB_GET ($ob_r;->$t_correo;"mail")
				CLEAR VARIABLE:C89($ob_r)
			Else 
				LOG_RegisterEvt (__ ("No fue posible enviar  datos de acceso al profesor "+[Profesores:4]Apellidos_y_nombres:28+", ya que no tiene registrado correo personal o profesional."))
			End if 
		End if 
End case 