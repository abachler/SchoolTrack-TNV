C_LONGINT:C283($noNivel)


GET LIST ITEM:C378(hl_MenuNiveles;*;$NumeroNivel;$nombreNivel)
If ($numeroNivel#0)
	If ((Size of array:C274(<>aStdWhNme)>0) | (Size of array:C274(aPAName)>0))
		If ($NumeroNivel=[Cursos:3]Nivel_Numero:7)
			[Cursos:3]Nivel_Nombre:10:=$nombreNivel
			[Cursos:3]Nombre_Oficial_Nivel:14:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$NumeroNivel;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
			[Cursos:3]Ciclo:5:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$NumeroNivel;->[xxSTR_Niveles:6]Sección:9)
			CU_fSave 
		Else 
			BEEP:C151
			CD_Dlog (0;__ ("Ya hay alumnos en este curso o asignaturas definidas. No es posible modificarlo."))
		End if 
	Else 
		
		$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;$NumeroNivel)
		KRL_GotoRecord (->[xxSTR_Niveles:6];$recNum)
		[Cursos:3]Nivel_Numero:7:=$NumeroNivel
		[Cursos:3]Nivel_Nombre:10:=$nombreNivel
		[Cursos:3]Nombre_Oficial_Nivel:14:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
		[Cursos:3]Ciclo:5:=[xxSTR_Niveles:6]Sección:9
		If ([Cursos:3]Letra_del_curso:9#"")
			If (([Cursos:3]Nivel_Numero:7>Nivel_AdmisionDirecta) & ([Cursos:3]Nivel_Numero:7<Nivel_Egresados))
				$abrev:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura:19)
				[Cursos:3]Curso:1:=$abrev+"-"+[Cursos:3]Letra_del_curso:9
			Else 
				BEEP:C151
				[Cursos:3]Curso:1:=""
				[Cursos:3]Letra_del_curso:9:=""
				[Cursos:3]Nivel_Nombre:10:=""
				[Cursos:3]Nivel_Numero:7:=0
			End if 
			If (Find in array:C230(<>aCursos;[Cursos:3]Curso:1)>0)
				CD_Dlog (0;__ ("Este curso ya existe."))
				[Cursos:3]Curso:1:=""
				[Cursos:3]Letra_del_curso:9:=""
				[Cursos:3]Nivel_Nombre:10:=""
				[Cursos:3]Nivel_Numero:7:=0
			End if 
			RELATE MANY:C262([Cursos:3]Curso:1)
		End if 
		If ([Cursos:3]Nivel_Numero:7>Nivel_AdmisionDirecta)
			[Cursos:3]cl_CodigoDecretoEvaluacion:24:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
			[Cursos:3]cl_CodigoDecretoPlanEstudios:22:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
			[Cursos:3]cl_CodigoEspecialidadTP:29:=0
			[Cursos:3]cl_CodigoPlanEstudios:23:=[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40
			[Cursos:3]cl_CodigoTipoEnseñanza:21:=[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41
			If ([Cursos:3]cl_CodigoTipoEnseñanza:21>0)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEstablecimiento;[Cursos:3]cl_CodigoTipoEnseñanza:21)
				GET LIST ITEM:C378(hl_TipoEstablecimiento;Selected list items:C379(hl_TipoEstablecimiento);$ref;$text)
				[Cursos:3]cl_TipoEnseñanza:25:=$text
			Else 
				[Cursos:3]cl_TipoEnseñanza:25:=""
			End if 
			If ([Cursos:3]cl_CodigoEspecialidadTP:29>0)
				SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;[Cursos:3]cl_CodigoEspecialidadTP:29)
				GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
				[Cursos:3]cl_EspecialidadTP:28:=$text
				$parent:=List item parent:C633($hl_Especialidades;$ref)
				SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;$parent)
				GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
				[Cursos:3]cl_SectorEconomicoTP:27:=$text
				$parent:=List item parent:C633($hl_Especialidades;$ref)
				SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;$parent)
				GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
				[Cursos:3]cl_RamaTP:26:=$text
			End if 
		End if 
	End if 
	GOTO OBJECT:C206([Cursos:3]Letra_del_curso:9)
	CU_SetInputFormObjects 
End if 

