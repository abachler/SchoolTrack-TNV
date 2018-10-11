  // [xxSTR_Niveles].Configuration.abreviacionInterna()
  // Por: Alberto Bachler K.: 09-06-14, 14:22:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_fechaInicio;$d_fechaTermino)
_O_C_INTEGER:C282($i_alumnos;$i_asignaturas;$i_Cursos)
C_LONGINT:C283($l_idTermometro;$l_recNum;$l_recNumNivel)
C_TEXT:C284($t_AbreviacionAnterior;$t_nombreAnteriorCurso;$t_nuevoNombreCurso)
C_BOOLEAN:C305($b_validarTransaccion)


ARRAY LONGINT:C221($al_RecNumAlumnos;0)
ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY LONGINT:C221($al_RecNumsCursos;0)
ARRAY TEXT:C222($at_NombreCurso;0)

$b_validarTransaccion:=True:C214

$t_AbreviacionAnterior:=Old:C35([xxSTR_Niveles:6]Abreviatura:19)

START TRANSACTION:C239
SET QUERY AND LOCK:C661(True:C214)
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
If ((OK=1) & (Records in set:C195("lockedset")=0))
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5)
End if 
If ((OK=1) & (Records in set:C195("lockedset")=0))
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gYear)
End if 
If ((OK=1) & (Records in set:C195("lockedset")=0))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215)
End if 

If ((OK=1) & (Records in set:C195("lockedset")=0))
	SAVE RECORD:C53([xxSTR_Niveles:6])
	$l_recNumNivel:=Record number:C243([xxSTR_Niveles:6])
	$d_fechaInicio:=PERIODOS_InicioAñoSTrack 
	$d_fechaTermino:=PERIODOS_FinAñoPeriodosSTrack 
	KRL_GotoRecord (->[xxSTR_Niveles:6];$l_recNumNivel;True:C214)
	
	LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_RecNumsCursos;"")
	$l_idTermometro:=IT_Progress (1;0;0;"Actualizando nombre del curso")
	For ($i_Cursos;1;Size of array:C274($al_RecNumsCursos))
		READ WRITE:C146([Cursos:3])
		GOTO RECORD:C242([Cursos:3];$al_RecNumsCursos{$i_Cursos})
		$t_nombreAnteriorCurso:=[Cursos:3]Curso:1
		$t_nuevoNombreCurso:=[xxSTR_Niveles:6]Abreviatura:19+"-"+[Cursos:3]Letra_del_curso:9
		
		If ((Find in field:C653([Cursos:3]Curso:1;$t_nuevoNombreCurso)=-1) | ($t_nombreAnteriorCurso=$t_nuevoNombreCurso))
			[Cursos:3]Curso:1:=$t_nuevoNombreCurso
			SAVE RECORD:C53([Cursos:3])
			KRL_FindAndLoadRecordByIndex (->[Cursos_SintesisAnual:63]ID_Curso:52;->[Cursos:3]Numero_del_curso:6;True:C214)
			If (OK=1)
				[Cursos_SintesisAnual:63]Curso:5:=$t_nuevoNombreCurso
				SAVE RECORD:C53([Cursos_SintesisAnual:63])
			End if 
			
			If (OK=1)
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_nombreAnteriorCurso)
				LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_RecNumAlumnos;"")
				For ($i_alumnos;1;Size of array:C274($al_RecNumAlumnos))
					READ WRITE:C146([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];$al_RecNumAlumnos{$i_alumnos})
					[Alumnos:2]curso:20:=$t_nuevoNombreCurso
					SAVE RECORD:C53([Alumnos:2])
					$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
					If (OK=1)
						[Alumnos_SintesisAnual:210]Curso:7:=$t_nuevoNombreCurso
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					Else 
						$i_alumnos:=Size of array:C274($al_RecNumAlumnos)+1
					End if 
					$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_Cursos/Size of array:C274($al_RecNumsCursos);"Actualizando nombre del curso"+$t_nuevoNombreCurso;$i_alumnos/Size of array:C274($al_RecNumAlumnos);[Alumnos:2]apellidos_y_nombres:40)
				End for 
			Else 
				$i_Cursos:=Size of array:C274($al_RecNumsCursos)+1
			End if 
			
			If (OK=1)
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_Cursos/Size of array:C274($al_RecNumsCursos);"Actualizando nombre del curso"+$t_nuevoNombreCurso;1;"")
				READ WRITE:C146([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_nombreAnteriorCurso;*)
				QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Seleccion:17=False:C215)
				If ((OK=1) & (Records in set:C195("lockedset")=0))
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumsAsignaturas;"")
					For ($i_asignaturas;1;Size of array:C274($al_RecNumsAsignaturas))
						READ WRITE:C146([Asignaturas:18])
						GOTO RECORD:C242([Asignaturas:18];$al_RecNumsAsignaturas{$i_asignaturas})
						[Asignaturas:18]Curso:5:=$t_nuevoNombreCurso
						SAVE RECORD:C53([Asignaturas:18])
						$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_Cursos/Size of array:C274($al_RecNumsCursos);"Actualizando nombre del curso"+$t_nuevoNombreCurso;$i_asignaturas/Size of array:C274($al_RecNumsAsignaturas);[Asignaturas:18]denominacion_interna:16)
					End for 
				End if 
				
				If (OK=1)
					QUERY:C277([Cursos_Delegados:110];[Cursos_Delegados:110]curso:1=$t_nombreAnteriorCurso)
					If ((OK=1) & (Records in set:C195("lockedset")=0))
						AT_Populate (->$at_NombreCurso;->$t_nuevoNombreCurso;Records in selection:C76([Cursos_Delegados:110]))
						READ WRITE:C146([Cursos_Delegados:110])
						ARRAY TO SELECTION:C261($at_NombreCurso;[Cursos_Delegados:110]curso:1)
					Else 
						$i_Cursos:=Size of array:C274($al_RecNumsCursos)+1
					End if 
				End if 
				
				If (OK=1)
					QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Curso:3=$t_nombreAnteriorCurso)
					If ((OK=1) & (Records in set:C195("lockedset")=0))
						AT_Populate (->$at_NombreCurso;->$t_nuevoNombreCurso;Records in selection:C76([Alumnos_ControlesMedicos:99]))
						READ WRITE:C146([Alumnos_ControlesMedicos:99])
						ARRAY TO SELECTION:C261($at_NombreCurso;[Alumnos_ControlesMedicos:99]Curso:3)
					Else 
						$i_Cursos:=Size of array:C274($al_RecNumsCursos)+1
					End if 
				End if 
				
			Else 
				$i_Cursos:=Size of array:C274($al_RecNumsCursos)
			End if 
		Else 
			$i_Cursos:=Size of array:C274($al_RecNumsCursos)+1
			$b_validarTransaccion:=False:C215
			CD_Dlog (0;__ ("No es posible actualizar la abreviación del nivel.\rNo pueden existir dos niveles con la misma Abreviación. "))
			[xxSTR_Niveles:6]Abreviatura:19:=$t_AbreviacionAnterior
		End if 
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_Cursos/Size of array:C274($al_RecNumsCursos);"Actualizando nombre del curso")
	End for 
	$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
	
	SET QUERY AND LOCK:C661(False:C215)
	If ($b_validarTransaccion)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
Else 
	SET QUERY AND LOCK:C661(False:C215)
	CD_Dlog (0;__ ("No es posible actualizar la abreviación del nivel en este momento.\rPor favor inténtelo nuevamente mas tarde."))
	CANCEL TRANSACTION:C241
	[xxSTR_Niveles:6]Abreviatura:19:=$t_AbreviacionAnterior
	GOTO OBJECT:C206([xxSTR_Niveles:6]Abreviatura:19)
End if 

KRL_UnloadReadOnly (->[Cursos:3])
KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
KRL_UnloadReadOnly (->[Cursos_Delegados:110])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
KRL_UnloadReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[Alumnos_ControlesMedicos:99])

