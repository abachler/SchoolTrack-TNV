//%attributes = {}
  //UD_v20170804_FixCursosADT
  //MONO TICKET 186373. 

READ ONLY:C145([Cursos:3])
C_LONGINT:C283($i;$l_noNivel;$l_recnum;$l_id_cursos)
C_TEXT:C284($t_curso)
$l_idTermometro:=IT_Progress (1;0;0;"Revisando cursos ADT ...")
For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
	
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274(<>al_NumeroNivelesActivos);"Revisando cursos ADT ...")
	
	$l_noNivel:=<>al_NumeroNivelesActivos{$i}
	$t_curso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_noNivel;->[xxSTR_Niveles:6]Abreviatura:19)+"-ADT"
	$l_recnum:=Find in field:C653([Cursos:3]Curso:1;$t_curso)
	READ WRITE:C146([Cursos:3])
	If ($l_recnum=-1)
		CREATE RECORD:C68([Cursos:3])
		[Cursos:3]Curso:1:=$t_curso
		[Cursos:3]Ciclo:5:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_noNivel;->[xxSTR_Niveles:6]Sección:9)
		[Cursos:3]Letra_del_curso:9:="ADT"
		[Cursos:3]Nivel_Nombre:10:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_noNivel;->[xxSTR_Niveles:6]Nivel:1)
		[Cursos:3]Nivel_Numero:7:=$l_noNivel
		$l_id_cursos:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
		[Cursos:3]Numero_del_curso:6:=Abs:C99($l_id_cursos)*-1
	Else 
		GOTO RECORD:C242([Cursos:3];$l_recnum)
		If ([Cursos:3]Numero_del_curso:6>0)
			[Cursos:3]Numero_del_curso:6:=Abs:C99([Cursos:3]Numero_del_curso:6)*-1
			If (Find in field:C653([Cursos:3]Numero_del_curso:6;[Cursos:3]Numero_del_curso:6)>=0)
				$l_id_cursos:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
				[Cursos:3]Numero_del_curso:6:=Abs:C99($l_id_cursos)*-1
			End if 
		End if 
	End if 
	SAVE RECORD:C53([Cursos:3])
	KRL_UnloadReadOnly (->[Cursos:3])
	
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)