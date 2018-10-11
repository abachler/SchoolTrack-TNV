
C_TEXT:C284($t_mensaje;$t_color;$t_may;$t_num;$t_cant;$t_mensaje;$t_texto)
C_LONGINT:C283($l_color)
C_OBJECT:C1216($ob)
C_BOOLEAN:C305($b_mostrar;$b_autoriza)


Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		
		$y_texto:=OBJECT Get pointer:C1124(Object named:K67:5;"texto2")
		$y_numerico:=OBJECT Get pointer:C1124(Object named:K67:5;"numerico")
		$y_cant:=OBJECT Get pointer:C1124(Object named:K67:5;"cant")
		
		Self:C308->:=Get edited text:C655
		$t_texto:=Get edited text:C655
		
		C_OBJECT:C1216($ob_temp)
		$ob_temp:=OB_Create 
		OB_SET_Text ($ob_temp;"ValidaCaracteres";"accion")
		OB_SET ($ob_temp;->$t_texto;"pass")
		$ob:=STR_SegAvanzada (->$ob_temp)
		OB_GET ($ob;->$t_mensaje;"mensaje")
		OB_GET ($ob;->$l_color;"color")
		OB_GET ($ob;->$b_autoriza;"Autoriza")
		OB_GET ($ob;->$t_texto;"Pass")
		If ($b_autoriza)
			CD_Dlog (0;$t_mensaje)
			vsPW_Password1:=$t_texto
		End if 
		OBJECT SET TITLE:C194(*;"texto2";$t_mensaje)
		OBJECT SET RGB COLORS:C628(*;"texto2";$l_color;$l_color)
		OBJECT SET ENABLED:C1123(*;"btn_guardar";(([xShell_Users:47]Name:2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users:47]login:9#"") & ($t_mensaje="Contraseña Segura")))
		  //"groupmanager"
		  //If (<>viSTR_UtilizaSeguridad=1)
		  //Else 
		  //If (Length(vsPW_Password1)>15)
		  //GOTO OBJECT(vsPW_Password2)
		  //vsPW_Password1:=Substring(vsPW_Password1;1;15)
		  //CD_Dlog (0;__ ("La contraseña no puede tener más de 15 caracteres.\rSe conservaron los primeros 15 caracteres ingresados."))
		  //End if 
		  //End if 
	: (Form event:C388=On Data Change:K2:15)
		
		C_OBJECT:C1216($ob_temp)
		$ob_temp:=OB_Create 
		OB_SET_Text ($ob_temp;"ValidaCaracteres";"accion")
		OB_SET ($ob_temp;->vsPW_Password1;"pass")
		$ob:=STR_SegAvanzada (->$ob_temp)
		OB_GET ($ob;->$t_mensaje;"mensaje")
		OB_GET ($ob;->$b_mostrar;"mostrar")
		OB_GET ($ob;->$b_autoriza;"Autoriza")
		OB_GET ($ob;->$t_texto;"Pass")
		
		If (($b_mostrar) | ($b_autoriza))
			CD_Dlog (0;$t_mensaje)
			If ($b_autoriza)
				vsPW_Password1:=$t_texto
			End if 
		End if 
		OBJECT SET ENABLED:C1123(*;"btn_guardar";(([xShell_Users:47]Name:2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users:47]login:9#"") & ($t_mensaje="Contraseña Segura")))
		
End case 


