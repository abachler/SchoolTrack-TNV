//%attributes = {}
  // CU_SituacionFinal_Evaluar()
  //
  //
  // creado por: Alberto Bachler Klein: 16-11-16, 11:43:14
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($i_alumno;$l_NumeroAlumnos;$l_progreso;$l_recNum)
C_PICTURE:C286($p_icono)
C_TEXT:C284($t_curso)

ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_LONGINT:C283(CU_SituacionFinal_Evaluar ;$1)
	C_TEXT:C284(CU_SituacionFinal_Evaluar ;$2)
End if 

$l_recNum:=$1
If (Count parameters:C259=2)
	$t_curso:=$2
End if 


Case of 
	: ($l_recNum>=0)
		KRL_GotoRecord (->[Alumnos:2];$l_recNum;False:C215)
		If (OK=1)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
			[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
			[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=""
			[Alumnos_SintesisAnual:210]SituacionFinal:8:=""
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			dbu_fEvalStudentSit2 ([Alumnos:2]numero:1)
			SAVE RECORD:C53([Alumnos:2])
			UNLOAD RECORD:C212([Alumnos:2])
		End if 
		
	: ($t_curso#"")
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNums;"")
		$l_NumeroAlumnos:=Size of array:C274($al_recNums)
		$l_progreso:=Progress New 
		Progress SET TITLE ($l_progreso;"Calculando situación final…";0;"";True:C214)
		Progress SET ICON ($l_progreso;<>p_iconoColegium)
		For ($i_alumno;1;$l_NumeroAlumnos)
			KRL_GotoRecord (->[Alumnos:2];$al_recNums{$i_alumno};False:C215)
			If (OK=1)
				Progress SET TITLE ($l_progreso;"Calculando situación final…";$i_alumno/$l_NumeroAlumnos;[Alumnos:2]apellidos_y_nombres:40;True:C214)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
				[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=False:C215
				[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=""
				[Alumnos_SintesisAnual:210]SituacionFinal:8:=""
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				dbu_fEvalStudentSit2 ([Alumnos:2]numero:1)
				SAVE RECORD:C53([Alumnos:2])
				UNLOAD RECORD:C212([Alumnos:2])
			End if 
		End for 
		Progress QUIT ($l_progreso)
End case 


