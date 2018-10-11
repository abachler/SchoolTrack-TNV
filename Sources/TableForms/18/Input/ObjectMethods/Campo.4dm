If (Form event:C388=On Clicked:K2:4)
	If ([Asignaturas:18]ObjetivosxAlumno:112)
		ARRAY TEXT:C222($at_nom_pes;0)
		ARRAY LONGINT:C221($al_id_pes;0)
		C_LONGINT:C283(hl_list_objetivos)
		APPEND TO ARRAY:C911($at_nom_pes;__ ("Objetivos comunes de la asignatura"))
		APPEND TO ARRAY:C911($al_id_pes;1)
		APPEND TO ARRAY:C911($at_nom_pes;__ ("Objetivos específicos por alumno"))
		APPEND TO ARRAY:C911($al_id_pes;2)
		vl_refPestañaObjetivosActiva:=2
		hl_list_objetivos:=AT_Array2ReferencedList (->$at_nom_pes;->$al_id_pes;0;False:C215;True:C214)
		SELECT LIST ITEMS BY POSITION:C381(hl_list_objetivos;2)
		OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
		OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";True:C214)
		OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";True:C214)
		SAVE RECORD:C53([Asignaturas:18])
		AS_Load_ObjxAlu 
	Else 
		
		OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
		OBJECT SET VISIBLE:C603(*;"vObj_P"+String:C10(vlSTR_PeriodoSeleccionado);True:C214)
		OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";False:C215)
		OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";False:C215)
		SAVE RECORD:C53([Asignaturas:18])
		HL_ClearList (hl_list_objetivos)
		
	End if 
End if 