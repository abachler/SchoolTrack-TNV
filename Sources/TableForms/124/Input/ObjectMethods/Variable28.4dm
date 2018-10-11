If (USR_checkRights \
(\
"D";\
->\
[ACT_Cargos:173]))
	$line:=\
		AL_GetLine \
		(\
		Self:C308\
		->\
		)\
		
	IT_SetButtonState (\
		(\
		$line\
		#\
		0\
		);->\
		bDelCargos)
Else 
	_O_DISABLE BUTTON:C193(bDelCargos\
		)
End if 