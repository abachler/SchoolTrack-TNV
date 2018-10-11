
If ([xShell_Users:47]email:20#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1)
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	OB_SET_Text ($ob;"EnviaCorreo";"accion")
	OB_SET ($ob;->vsPW_Password1;"pass")
	OB_SET ($ob;->[xShell_Users:47]email:20;"mail")
	OB_SET ($ob;->[xShell_Users:47]login:9;"login")
	STR_SegAvanzada (->$ob)
Else 
	CD_Dlog (0;"No es posible enviar correo, verifique que  las contraseñas sean iguales y que el correo electrónico este correctamente escrito.")
End if 
