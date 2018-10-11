//%attributes = {}
  //ZZmx_Notas_a_Competencias

  //READ ONLY([MPA_DefinicionCompetencias])
  //READ ONLY([Asignaturas])
  //READ ONLY([MPA_ObjetosMatriz])
  //READ ONLY([zzAlumnos_EvaluacionesPeriodica])
  //READ ONLY([MPA_AsignaturasMatrices])
  //READ WRITE([Alumnos_EvaluacionAprendizajes])
  //ALL RECORDS([MPA_DefinicionCompetencias])
  //SELECTION TO ARRAY([MPA_DefinicionCompetencias]Competencia;$aCompetencia;[MPA_DefinicionCompetencias]ID;$aIdCompetencia;[MPA_DefinicionCompetencias]ID_Eje;$aIdEje;[MPA_DefinicionCompetencias]ID_Dimension;$aIdDim)
  //
  //
  //QUERY([Asignaturas];[Asignaturas]Numero_del_Nivel<0;*)
  //QUERY([Asignaturas]; & ;[Asignaturas]OcultaEnExplorador=True)
  //ARRAY LONGINT($aRecNumAsignaturas;0)
  //LONGINT ARRAY FROM SELECTION([Asignaturas];$aRecNumAsignaturas;"")
  //CD_THERMOMETREXSEC (1;0;"Convirtiendo notas a Competencias...")
  //For ($iAsignaturas;1;Size of array($aRecNumAsignaturas))
  //CD_THERMOMETREXSEC (0;$iAsignaturas/Size of array($aRecNumAsignaturas)*100)
  //GOTO RECORD([Asignaturas];$aRecNumAsignaturas{$iAsignaturas})
  //$idAsignaturaOrigen:=[Asignaturas]Numero
  //$cursoOrigen:=[Asignaturas]Curso
  //$numeroNivel:=[Asignaturas]Numero_del_Nivel
  //$el:=Find in array($aCompetencia;[Asignaturas]Asignatura)
  //If ($el<0)
  //TRACE
  //Else 
  //$idCompetencia:=$aIDCompetencia{$el}
  //$idDimension:=$aIdDim{$el}
  //$idEje:=$aIdEje{$el}
  //QUERY([MPA_ObjetosMatriz];[MPA_ObjetosMatriz]ID_Eje=$idEje;*)
  //QUERY([MPA_ObjetosMatriz]; & [MPA_ObjetosMatriz]ID_Dimension=$idDimension;*)
  //QUERY([MPA_ObjetosMatriz]; & [MPA_ObjetosMatriz]ID_Competencia=$idCompetencia)
  //SET AUTOMATIC RELATIONS(True;False)
  //QUERY SELECTION([MPA_ObjetosMatriz];[MPA_AsignaturasMatrices]NumeroNivel=$numeroNivel)
  //SET AUTOMATIC RELATIONS(False;False)
  //If (Records in selection([MPA_ObjetosMatriz])#1)
  //TRACE
  //SELECTION TO ARRAY([MPA_ObjetosMatriz]ID_Matriz;$aIdMatrices)
  //End if 
  //QUERY([Asignaturas];[Asignaturas]EVAPR_IdMatriz=[MPA_ObjetosMatriz]ID_Matriz;*)
  //QUERY([Asignaturas]; & [Asignaturas]Curso=$cursoOrigen)
  //$idAsignatura:=[Asignaturas]Numero
  //$idCompetencia:=$aIDCompetencia{$el}
  //$idDimension:=$aIdDim{$el}
  //$idEje:=$aIdEje{$el}
  //$idMatriz:=[Asignaturas]EVAPR_IdMatriz
  //End if 
  //
  //QUERY([zzAlumnos_EvaluacionesPeriodica];[zzAlumnos_EvaluacionesPeriodica]ID_Asignatura=$idAsignaturaOrigen;*)
  //QUERY([zzAlumnos_EvaluacionesPeriodica]; & [zzAlumnos_EvaluacionesPeriodica]Periodo=1)
  //ARRAY LONGINT($aRecNumNotas;0)
  //LONGINT ARRAY FROM SELECTION([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas;"")
  //For ($iNotas;1;Size of array($aRecNumNotas))
  //GOTO RECORD([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas{$iNotas})
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String($idDimension)+"."+String($idCompetencia)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=$idDimension
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=$idCompetencia
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Logro_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //Else 
  //GOTO RECORD([Alumnos_EvaluacionAprendizajes];$recNum)
  //End if 
  //[Alumnos_EvaluacionAprendizajes]Periodo1_NativoLiteral:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralInterno
  //[Alumnos_EvaluacionAprendizajes]Periodo1_NativoNumerico:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Nota
  //[Alumnos_EvaluacionAprendizajes]Periodo1_Real:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Real
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End for 
  //
  //QUERY([zzAlumnos_EvaluacionesPeriodica];[zzAlumnos_EvaluacionesPeriodica]ID_Asignatura=$idAsignaturaOrigen;*)
  //QUERY([zzAlumnos_EvaluacionesPeriodica]; & [zzAlumnos_EvaluacionesPeriodica]Periodo=2)
  //ARRAY LONGINT($aRecNumNotas;0)
  //LONGINT ARRAY FROM SELECTION([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas;"")
  //For ($iNotas;1;Size of array($aRecNumNotas))
  //GOTO RECORD([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas{$iNotas})
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String(0)+"."+String(0)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=0
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=0
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Eje_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End if 
  //
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String($idDimension)+"."+String(0)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=$idDimension
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=0
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Dimension_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End if 
  //
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String($idDimension)+"."+String($idCompetencia)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=$idDimension
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=$idCompetencia
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Logro_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //Else 
  //GOTO RECORD([Alumnos_EvaluacionAprendizajes];$recNum)
  //End if 
  //[Alumnos_EvaluacionAprendizajes]Periodo2_NativoLiteral:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralInterno
  //[Alumnos_EvaluacionAprendizajes]Periodo2_NativoNumerico:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Nota
  //[Alumnos_EvaluacionAprendizajes]Periodo2_Real:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Real
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End for 
  //
  //
  //QUERY([zzAlumnos_EvaluacionesPeriodica];[zzAlumnos_EvaluacionesPeriodica]ID_Asignatura=$idAsignaturaOrigen;*)
  //QUERY([zzAlumnos_EvaluacionesPeriodica]; & [zzAlumnos_EvaluacionesPeriodica]Periodo=3)
  //ARRAY LONGINT($aRecNumNotas;0)
  //LONGINT ARRAY FROM SELECTION([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas;"")
  //For ($iNotas;1;Size of array($aRecNumNotas))
  //GOTO RECORD([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas{$iNotas})
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String($idDimension)+"."+String($idCompetencia)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=$idDimension
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=$idCompetencia
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Logro_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //Else 
  //GOTO RECORD([Alumnos_EvaluacionAprendizajes];$recNum)
  //End if 
  //[Alumnos_EvaluacionAprendizajes]Periodo3_NativoLiteral:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralInterno
  //[Alumnos_EvaluacionAprendizajes]Periodo3_NativoNumerico:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Nota
  //[Alumnos_EvaluacionAprendizajes]Periodo3_Real:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Real
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End for 
  //
  //
  //QUERY([zzAlumnos_EvaluacionesPeriodica];[zzAlumnos_EvaluacionesPeriodica]ID_Asignatura=[Asignaturas]Numero;*)
  //QUERY([zzAlumnos_EvaluacionesPeriodica]; & [zzAlumnos_EvaluacionesPeriodica]Periodo=4)
  //ARRAY LONGINT($aRecNumNotas;0)
  //LONGINT ARRAY FROM SELECTION([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas;"")
  //For ($iNotas;1;Size of array($aRecNumNotas))
  //GOTO RECORD([zzAlumnos_EvaluacionesPeriodica];$aRecNumNotas{$iNotas})
  //$key:=String($idAsignatura)+"."+String([zzAlumnos_EvaluacionesPeriodica]ID_Alumno)+"."+String($idEje)+"."+String($idDimension)+"."+String($idCompetencia)
  //$recNum:=Find in field([Alumnos_EvaluacionAprendizajes]Key;$key)
  //If ($recNum<0)
  //CREATE RECORD([Alumnos_EvaluacionAprendizajes])
  //[Alumnos_EvaluacionAprendizajes]ID_Alumno:=[zzAlumnos_EvaluacionesPeriodica]ID_Alumno
  //[Alumnos_EvaluacionAprendizajes]ID_Asignatura:=$idAsignatura
  //[Alumnos_EvaluacionAprendizajes]ID_Eje:=$idEje
  //[Alumnos_EvaluacionAprendizajes]ID_Dimension:=$idDimension
  //[Alumnos_EvaluacionAprendizajes]ID_Competencia:=$idCompetencia
  //[Alumnos_EvaluacionAprendizajes]ID_Matriz:=$idMatriz
  //[Alumnos_EvaluacionAprendizajes]Tipo_Objeto:=Logro_Aprendizaje 
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //Else 
  //GOTO RECORD([Alumnos_EvaluacionAprendizajes];$recNum)
  //End if 
  //[Alumnos_EvaluacionAprendizajes]Periodo4_NativoLiteral:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_LiteralInterno
  //[Alumnos_EvaluacionAprendizajes]Periodo4_NativoNumerico:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Nota
  //[Alumnos_EvaluacionAprendizajes]Periodo4_Real:=[zzAlumnos_EvaluacionesPeriodica]FinalPeriodo_Real
  //SAVE RECORD([Alumnos_EvaluacionAprendizajes])
  //End for 
  //
  //End for 
  //CD_THERMOMETREXSEC (-1)
