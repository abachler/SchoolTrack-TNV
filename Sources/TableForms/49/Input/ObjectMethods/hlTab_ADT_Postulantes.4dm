ARRAY TEXT:C222(aTemporal;0)
ARRAY TEXT:C222(aEstadosLibres;0)
_O_C_INTEGER:C282($i)
C_BLOB:C604(blob)
C_BOOLEAN:C305(vb_opPrivada)
C_BOOLEAN:C305(vb_opPrivadaEx)
_O_C_INTEGER:C282(cb_SaltarEstados)

If (ADTcdd_esRegistroValido )
	If ((viPST_PostCurrentPage=1) | (viPST_PostCurrentPage=2))
		
		If (viPST_PostCurrentPage=2)
			ADTcdd_SaveEducacionAnterior 
		Else 
			ADTcdd_LoadEducacionAnterior ([ADT_Candidatos:49]Candidato_numero:1;"al")
		End if 
		
		cb_SaltarEstados:=Num:C11(PREF_fGet (0;"SaltarEstadosADT";"0"))
		
		Case of 
			: ([Alumnos:2]Familia_Número:24=0)
				CD_Dlog (0;__ ("No se ha definido ninguna relación entre este postulante y una familia.\rEs necesario hacerlo antes de pasar a la sección inscripción."))
				SELECT LIST ITEMS BY POSITION:C381(hlTab_ADT_Postulantes;1)
				FORM GOTO PAGE:C247(Selected list items:C379(hlTab_ADT_Postulantes))
			Else 
				If (Selected list items:C379(hlTab_ADT_Postulantes)=3)
					COPY NAMED SELECTION:C331([Alumnos:2];"currentSelection")
					viPST_PostCurrentPage:=3
					SAVE RECORD:C53([Alumnos:2])
					$recNum:=Selected record number:C246([Alumnos:2])
					PST_AutoAsignIViewAndPresent 
					PST_AsignExamsDate 
					PST_AsignarJornadaVisita 
					  //ASM 20140410 Se perdia las conexiones, y el AreaList botaba la aplicación
					PST_GetFamilyRelations 
					USE NAMED SELECTION:C332("currentSelection")
					FORM GOTO PAGE:C247(Selected list items:C379(hlTab_ADT_Postulantes))
				Else 
					viPST_PostCurrentPage:=Selected list items:C379(hlTab_ADT_Postulantes)
					FORM GOTO PAGE:C247(Selected list items:C379(hlTab_ADT_Postulantes))
				End if 
		End case 
	Else 
		viPST_PostCurrentPage:=Selected list items:C379(hlTab_ADT_Postulantes)
		FORM GOTO PAGE:C247(Selected list items:C379(hlTab_ADT_Postulantes))
	End if 
	If (Is new record:C668([ADT_Candidatos:49]))
		SET WINDOW TITLE:C213(__ ("Nuevo Registro: Candidatos"))
	Else 
		SET WINDOW TITLE:C213(__ ("Candidato: ")+[Alumnos:2]apellidos_y_nombres:40)
		ADT_HermanosEnColegio (1)
	End if 
	  //para actualizar las vista del examen y las entrevistas del formulario
	ADT_VistasIViewExam 
	op1:=1
	op2:=0
Else 
	SELECT LIST ITEMS BY POSITION:C381(hlTab_ADT_Postulantes;1)
	FORM GOTO PAGE:C247(Selected list items:C379(hlTab_ADT_Postulantes))
End if 
