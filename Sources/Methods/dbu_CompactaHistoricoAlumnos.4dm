//%attributes = {}
  // Método: dbu_CompactaHistoricoAlumnos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 27/10/09, 19:44:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($i;$id)
ARRAY LONGINT:C221($aRecNums;0)


  // Código principal
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4<0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Compactaje de registros históricos de alumno..."))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
	$id:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
	
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
	QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=[Alumnos_SintesisAnual:210]Año:2)
	If ((Records in selection:C76([Alumnos_Calificaciones:208])=0) & ([Alumnos_SintesisAnual:210]SituacionFinal:8="") & ([Alumnos_SintesisAnual:210]NumeroNivel:6=0))
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1;=;Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_SintesisAnual:210]Año:2)
		KRL_DeleteRecord (->[Alumnos_Historico:25])
		KRL_DeleteRecord (->[Alumnos_SintesisAnual:210])
		
	Else 
		QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1;=;Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);*)
		QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_SintesisAnual:210]Año:2)
		If (Records in selection:C76([Alumnos_Historico:25])=0)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id)
			CREATE RECORD:C68([Alumnos_Historico:25])
			[Alumnos_Historico:25]Alumno_Numero:1:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
			[Alumnos_Historico:25]Año:2:=[Alumnos_SintesisAnual:210]Año:2
			[Alumnos_Historico:25]Curso:3:=[Alumnos_SintesisAnual:210]Curso:7
			[Alumnos_Historico:25]ID:23:=SQ_SeqNumber (->[Alumnos_Historico:25]ID:23)
			[Alumnos_Historico:25]ID_Curso:34:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Alumnos_Historico:25]Curso:3;->[Cursos:3]Numero_del_curso:6)
			[Alumnos_Historico:25]Nivel:11:=[Alumnos_SintesisAnual:210]NumeroNivel:6
			[Alumnos_Historico:25]Nivel_Nombre:38:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]Nivel:1)
			[Alumnos_Historico:25]NombreAgnoEscolar:37:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Alumnos_Historico:25]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			[Alumnos_Historico:25]Situacion_final:19:=[Alumnos_SintesisAnual:210]SituacionFinal:8
			SAVE RECORD:C53([Alumnos_Historico:25])
			
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
KRL_UnloadAll 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


