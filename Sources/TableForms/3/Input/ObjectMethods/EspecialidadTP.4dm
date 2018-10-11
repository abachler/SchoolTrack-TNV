$hl_Especialidades:=Load list:C383("cl_CodigosEspecialidadTP")
$ref:=HL_ShowHListPopWindow ($hl_Especialidades)
If ($ref#0)
	[Cursos:3]cl_CodigoEspecialidadTP:29:=$ref
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
	
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1)
	QUERY SELECTION:C341([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=<>gyear)
	
	If (Records in selection:C76([Cursos_SintesisAnual:63])>0)
		READ WRITE:C146([Cursos_SintesisAnual:63])
		[Cursos_SintesisAnual:63]cl_CodigoEspecialidadTP:54:=[Cursos:3]cl_CodigoEspecialidadTP:29
		[Cursos_SintesisAnual:63]cl_EspecialidadTP:55:=[Cursos:3]cl_EspecialidadTP:28
		[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56:=[Cursos:3]cl_SectorEconomicoTP:27
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
		UNLOAD RECORD:C212([Cursos_SintesisAnual:63])
	End if 
	
End if 
CLEAR LIST:C377($hl_Especialidades;*)

