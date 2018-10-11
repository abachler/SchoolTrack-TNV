$Line:=\
AL_GetLine (\
xALP_Delegados)\

If (\
(\
$line>\
0)\
 & \
(\
(\
USR_checkRights (\
"M"\
;\
->\
[Cursos:3])\
)\
 | \
(\
<>lUSR_RelatedTableUserID=\
[Cursos:3]Numero_del_profesor_jefe:2)\
)\
)\

	_O_ENABLE BUTTON:C192(\
		bDelDelegado)\
		
End if 