  // [xxSTR_Constants].STR_InasistenciasSesiones.hl_cursos1()
  // Por: Alberto Bachler: 06/07/13, 15:47:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Form event:C388=On Clicked:K2:4)
	GET LIST ITEM:C378(hl_cursosAsistenciaSesiones;Selected list items:C379(hl_cursosAsistenciaSesiones);$l_refItem;$t_curso)
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_curso)
	$l_numeroNivel:=[Cursos:3]Nivel_Numero:7
	PERIODOS_LoadData ($l_numeroNivel)
	$b_nivelHabilitado:=((adSTR_Periodos_Desde{1}#!00-00-00!) & (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}#!00-00-00!))
	$b_nivelHabilitado:=$b_nivelHabilitado & (Size of array:C274(aiSTR_Horario_HoraNo)>0)
	If ($b_nivelHabilitado)
		If (DateIsValid (dFrom))
			vs_SelectedClass:=$t_curso
			AL_UpdateArrays (xALP_Inasistencias;0)
			AL_UpdateArrays (xALP_Subsectores;0)
			ALabs_Initialize 
			ALabs_LoadData (vs_SelectedClass)
			ALabs_UpdateForm 
			  //GOTO OBJECT(Self->)
		Else 
			$l_posicion:=Find in list:C952(hl_cursosAsistenciaSesiones;vs_SelectedClass;0)
			SELECT LIST ITEMS BY POSITION:C381(hl_cursosAsistenciaSesiones;$l_posicion)
			$t_tip:=String:C10(dFrom)+__ ("no es una fecha válida para registrar inasistencias a clases en las asignaturas de ")+$t_curso
			GET MOUSE:C468($l_posicionHorizontal;$l_posicionVertical;$l_boton)
			API Create Tip ($t_tip;$l_posicionHorizontal-20;$l_posicionVertical-20;$l_posicionHorizontal+20;$l_posicionVertical+20)
		End if 
	Else 
		$l_posicion:=Find in list:C952(hl_cursosAsistenciaSesiones;vs_SelectedClass;0)
		SELECT LIST ITEMS BY POSITION:C381(hl_cursosAsistenciaSesiones;$l_posicion)
		$t_tip:=__ ("No hay fechas válidas para registrar inasistencias a clases en las asignaturas ")+$t_curso
		GET MOUSE:C468($l_posicionHorizontal;$l_posicionVertical;$l_boton)
		API Create Tip ($t_tip;$l_posicionHorizontal-20;$l_posicionVertical-20;$l_posicionHorizontal+20;$l_posicionVertical+20)
	End if 
End if 





