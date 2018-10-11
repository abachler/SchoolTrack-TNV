If (Form event:C388=On Data Change:K2:15)
	
	ARRAY TEXT:C222($at_childName;0)
	ARRAY OBJECT:C1221($ao_childObj;0)
	$l_nodos:=OB_GetChildNodes (o_horarioOK;->$at_childName;->$ao_childObj)
	$fia:=Find in array:C230($at_childName;at_cursos_selector{at_cursos_selector})
	TMT_AsistImport_Load ($ao_childObj{$fia})
	$t_curso:=at_cursos_selector{at_cursos_selector}
	$l_noNivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Nivel_Numero:7)
	
	$l_nodos:=OB_GetChildNodes (o_horarioNotFound;->$at_childName;->$ao_childObj)
	$fia:=Find in array:C230($at_childName;String:C10($l_noNivel))
	If ($fia>0)
		TMT_AsistImport_LBNotFound ($ao_childObj{$fia})
		TMT_AsistImport_LNAsigNivel ($l_noNivel)
	Else 
		ARRAY TEXT:C222(at_lbNFCurso;0)
		ARRAY TEXT:C222(at_lbNFLlave;0)
	End if 
End if 