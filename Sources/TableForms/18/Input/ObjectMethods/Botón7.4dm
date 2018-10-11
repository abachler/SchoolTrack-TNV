AL_ExitCell (xALP_Aprendizajes)
AL_ExitCell (xALP_Evaluaciones)
If (vtEVLG_VistaActual="Alumnos")
	If ((vbMPA_ConfiguracionesPropias) | (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )))
		$result:=Pop up menu:C542(__ ("Editar Matrices...;-;(Ver por: ;")+"!"+Char:C90(18)+__ (" Alumnos; Aprendizajes");0)
	Else 
		$result:=Pop up menu:C542(__ ("(Editar Matrices...;-;(Ver por: ;")+"!"+Char:C90(18)+__ (" Alumnos; Aprendizajes");0)
	End if 
Else 
	If (vbMPA_ConfiguracionesPropias)
		$result:=Pop up menu:C542(__ ("Editar Matrices...;-;(Ver por: ; Alumnos;")+"!"+Char:C90(18)+__ (" Aprendizajes");0)
	Else 
		$result:=Pop up menu:C542(__ ("(Editar Matrices...;-;(Ver por: ; Alumnos;")+"!"+Char:C90(18)+__ (" Aprendizajes");0)
	End if 
End if 
Case of 
	: ($result=1)
		$recNumAsignatura:=Record number:C243([Asignaturas:18])
		COPY ARRAY:C226(atEVLG_EjesLogros;$atEVLG_EjesLogros)
		COPY ARRAY:C226(alEVLG_Ids;$alEVLG_Ids)
		COPY ARRAY:C226(alEVLG_TipoObjeto;$aiEVLG_TipoObjeto)
		COPY ARRAY:C226(atEVLG_Icons;$atEVLG_Icons)
		AL_UpdateArrays (xALP_Ejes;0)
		AL_UpdateArrays (xALP_Evaluaciones;0)
		EVLG_ConfiguracionAvanzada 
		COPY ARRAY:C226($atEVLG_EjesLogros;atEVLG_EjesLogros)
		COPY ARRAY:C226($alEVLG_Ids;alEVLG_Ids)
		COPY ARRAY:C226($aiEVLG_TipoObjeto;alEVLG_TipoObjeto)
		COPY ARRAY:C226($atEVLG_Icons;atEVLG_Icons)
		
		AS_PageEVLG 
		
	: ($result=4)
		AS_PageEVLG ("Alumnos")
	: ($result=5)
		AS_PageEVLG ("Aprendizajes")
End case 
