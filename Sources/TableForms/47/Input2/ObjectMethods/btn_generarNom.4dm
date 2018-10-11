C_OBJECT:C1216($ob_temp;$ob)
$ob:=OB_Create 
$ob_temp:=OB_Create 
OB_SET_Text ($ob;"GeneraNombreUsuario";"accion")
$ob_temp:=STR_SegAvanzada (->$ob)
OB_GET ($ob_temp;->[xShell_Users:47]login:9;"login")