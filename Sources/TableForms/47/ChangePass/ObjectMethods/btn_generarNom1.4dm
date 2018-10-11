C_TEXT:C284($t_pass;$t_mensaje)
C_LONGINT:C283($l_color)
C_OBJECT:C1216($ob_temp;$ob)
$ob:=OB_Create 
$ob_temp:=OB_Create 

OB_SET_Text ($ob;"GeneraContraseña";"accion")
$ob_temp:=STR_SegAvanzada (->$ob)

OB_GET ($ob_temp;->$t_pass;"pass")
vsPW_Password1:=$t_pass
vsPW_Password2:=$t_pass

OB_SET_Text ($ob;"ValidaCaracteres";"accion")
OB_SET ($ob;->vsPW_Password1;"pass")

CLEAR VARIABLE:C89($ob_temp)
$ob_temp:=STR_SegAvanzada (->$ob)

OB_GET ($ob_temp;->$t_mensaje;"mensaje")
OB_GET ($ob_temp;->$l_color;"color")

OBJECT SET TITLE:C194(*;"texto2";$t_mensaje)
OBJECT SET RGB COLORS:C628(*;"texto2";$l_color;$l_color)
  //(([xShell_Users]Name#"") & (vsPW_Password1#"") & (vsPW_Password2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users]login#"") & ($t_mensaje="Contraseña segura"))
  //_o_ENABLE BUTTON(bOK)
OBJECT SET ENABLED:C1123(*;"btn_guardar";(([xShell_Users:47]Name:2#"") & (vsPW_Password1#"") & (vsPW_Password2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users:47]login:9#"") & ($t_mensaje="Contraseña segura")))

