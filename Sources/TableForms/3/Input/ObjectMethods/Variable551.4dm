  // Método: [Cursos].Input.Variable551

ARRAY LONGINT:C221($al_idAsignatura;0)  //MONO 206900
ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY TEXT:C222(aSubjectName;0)

AL_UpdateArrays (xALP_Asignaturas;0)
AL_UpdateArrays (xALP_Delegados;0)

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3;=;<>gYear)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
Else 
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
End if 

QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7=0)

SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_idAsignatura;[Asignaturas:18]denominacion_interna:16;aSubjectName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas)  //MONO 206900
SORT ARRAY:C229(aSubjectName;at_OrdenAsignaturas;>)
For ($k;Size of array:C274(aSubjectName);2;-1)
	If ((aSubjectName{$k-1}=aSubjectName{$k}))
		DELETE FROM ARRAY:C228(aSubjectName;$k)
		DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$k)
	End if 
End for 
SORT ARRAY:C229(at_OrdenAsignaturas;aSubjectName;>)

vb_OrderModified:=False:C215
WDW_OpenFormWindow (->[xxSTR_Niveles:6];"OrdenSubsectores";-1;Palette form window:K39:9;__ ("Orden de subsectores en informes"))
DIALOG:C40([xxSTR_Niveles:6];"OrdenSubsectores")
CLOSE WINDOW:C154

If (vb_OrderModified)
	BLOB_Variables2Blob (->[Cursos:3]Orden_Subsectores:17;0;->at_OrdenAsignaturas;->aSubjectName)
	COMPRESS BLOB:C534([Cursos:3]Orden_Subsectores:17)
	SAVE RECORD:C53([Cursos:3])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando orden a las asignaturas del curso..."))
	  //MONO 206900
	QUERY WITH ARRAY:C644([Asignaturas:18]Numero:1;$al_idAsignatura)
	CREATE SET:C116([Asignaturas:18];"AsigCurso")
	For ($i;1;Size of array:C274(aSubjectName))
		  //MONO 206900
		USE SET:C118("AsigCurso")
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]denominacion_interna:16=aSubjectName{$i})
		  //QUERY([Asignaturas];[Asignaturas]Curso=[Cursos]Curso;*)
		  //QUERY([Asignaturas]; & [Asignaturas]Denominación_interna=aSubjectName{$i})
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
		For ($iRecNums;1;Size of array:C274($aRecNums))
			READ WRITE:C146([Asignaturas:18])
			GOTO RECORD:C242([Asignaturas:18];$aRecNums{$iRecNums})
			[Asignaturas:18]posicion_en_informes_de_notas:36:=Num:C11(at_OrdenAsignaturas{$i})
			[Asignaturas:18]ordenGeneral:105:=at_OrdenAsignaturas{$i}
			SAVE RECORD:C53([Asignaturas:18])
			AS_FijaNivelJeraquicoHijas (Record number:C243([Asignaturas:18]))
		End for 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aSubjectName))
	End for 
	CLEAR SET:C117("AsigCurso")  //MONO 206900
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
End if 

UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])
CU_LoadSubjectsAndStudents 
  //20111013 AS. se agrega el setEnterable porque en el metodo 
  //CU_LoadSubjectsAndStudents  se vuelve a cargar el arreglo at_CUApoderados y al agregar un delegado la aplicación se caía. 
AL_SetEnterable (xALP_Delegados;2;2;at_CUApoderados)
AL_UpdateArrays (xALP_Delegados;-2)
