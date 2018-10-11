
If (Form event:C388=On Clicked:K2:4)
	ARRAY LONGINT:C221($al_bloquesSinAsig;0)
	ARRAY LONGINT:C221($al_Asignaturas;0)
	ARRAY LONGINT:C221($al_horas;0)
	ARRAY TEXT:C222($at_childName;0)
	ARRAY OBJECT:C1221($ao_childObj;0)
	C_OBJECT:C1216($o_blockNotFound;$o_HorarioFound;$o_dias;$o_bloque)
	C_TEXT:C284($refObj)
	C_LONGINT:C283($i;$d)
	
	LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"LB_BloquesSinAsignatura");->$al_bloquesSinAsig)
	LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"LB_AsignaturasNivel");->$al_Asignaturas)
	
	If ((Size of array:C274($al_bloquesSinAsig)>0) & (Size of array:C274($al_Asignaturas)>0))
		
		$msj:="Se dispone a identificar el o los bloques:\n"
		For ($i;1;Size of array:C274($al_bloquesSinAsig))
			$msj:=$msj+at_lbNFLlave{$al_bloquesSinAsig{$i}}+"\n"
		End for 
		$msj:=$msj+"Con la asignatura "+at_lbGradeAsig{$al_Asignaturas{1}}+" "+at_lbGradeCurso{$al_Asignaturas{1}}+" "+at_lbGradeAsigProfe{$al_Asignaturas{1}}+".\n"
		$msj:=$msj+"¿Está seguro de continuar?"
		$l_resp:=CD_Dlog (0;$msj;"";"Si";"No")
		
		If ($l_resp=1)
			
			$t_curso:=at_cursos_selector{at_cursos_selector}
			$l_noNivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Nivel_Numero:7)
			
			$l_idTermometro:=IT_Progress (1;0;0;"Actualizando Bloque...")
			
			For ($i;1;Size of array:C274($al_bloquesSinAsig))
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_bloquesSinAsig);"Actualizando Bloque "+at_lbNFLlave{$al_bloquesSinAsig{$i}})
				$refObj:=String:C10($l_noNivel)+"."+at_lbNFCurso{$al_bloquesSinAsig{$i}}+"."+at_lbNFLlave{$al_bloquesSinAsig{$i}}
				OB_GET (o_horarioNotFound;->$o_blockNotFound;$refObj)
				
				$t_prof:=String:C10(OB Get:C1224($o_blockNotFound;"idProfesor"))
				$o_dias:=OB Get:C1224($o_blockNotFound;"dias")
				$l_nodes:=OB_GetChildNodes ($o_dias;->$at_childName;->$ao_childObj)
				
				For ($d;1;Size of array:C274($ao_childObj))
					OB GET ARRAY:C1229($ao_childObj{$d};"horas";$al_horas)
					For ($h;1;Size of array:C274($al_horas))
						$o_bloque:=OB_Create 
						OB SET:C1220($o_bloque;"curso";at_lbNFCurso{$al_bloquesSinAsig{$i}})
						OB SET:C1220($o_bloque;"dia";Num:C11($at_childName{$d}))
						OB SET:C1220($o_bloque;"hora";$al_horas{$h})
						OB SET:C1220($o_bloque;"asigFound";True:C214)
						OB SET:C1220($o_bloque;"asignatura";String:C10(al_lbGradeIdAsig{$al_Asignaturas{1}}))
						OB SET:C1220($o_bloque;"profesor";$t_prof)
						TMT_AsistImportAddBlock2Obj (->o_horarioOK;$o_bloque)
					End for 
					
				End for 
				
				OB_Remove (o_horarioNotFound;$refObj)
				
			End for 
			$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
			
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
			$b_sel:=False:C215
			AT_Populate (OBJECT Get pointer:C1124(Object named:K67:5;"LB_BloquesSinAsignatura");->$b_sel)
			
		End if 
		
	End if 
	
End if 

