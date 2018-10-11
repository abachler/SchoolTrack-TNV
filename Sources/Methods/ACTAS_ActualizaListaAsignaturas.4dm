//%attributes = {}
  // ACTAS_ActualizaAsignaturas()
  // Por: Alberto Bachler K.: 25-02-14, 12:37:45
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_actaEspecificaAlCurso)
C_LONGINT:C283($i;$i_asignatura;$l_año;$l_filaUltimaAsignatura;$l_idxEnActas;$l_nivel;$l_recNum)
C_POINTER:C301($y_blob)
C_TEXT:C284($t_curso)
C_OBJECT:C1216($oo_ObjetoActa)

ARRAY LONGINT:C221($al_recNumCursos;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_asignaturasEnActas;0)
ARRAY TEXT:C222($at_Cursos;0)


If (False:C215)
	C_LONGINT:C283(ACTAS_ActualizaListaAsignaturas ;$1)
	C_TEXT:C284(ACTAS_ActualizaListaAsignaturas ;$2)
End if 

$l_nivel:=$1
$t_curso:=""
$l_año:=<>gYear
Case of 
	: (Count parameters:C259=3)
		$t_curso:=$2
		$l_año:=$3
	: (Count parameters:C259=2)
		$t_curso:=$2
End case 

If ($t_curso#"")
	$b_actaEspecificaAlCurso:=KRL_GetBooleanFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]ActaEspecificaAlCurso:35)
	If (Not:C34($b_actaEspecificaAlCurso))
		$t_curso:=""
	End if 
End if 

If ($l_año=0)
	$l_año:=<>gYear
End if 


READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos_Calificaciones:208])




  // determino cual es el blob en el que está almacenado el objeto Actas y lo cargo
Case of 
	: ((($t_curso="") | ($b_actaEspecificaAlCurso=False:C215)) & ($l_año=<>gYear))
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel)
		$y_blob:=->[xxSTR_Niveles:6]Actas_y_Certificados:43
		$l_recNum:=Record number:C243([xxSTR_Niveles:6])
	: (($t_curso="") & ($l_año<<>gYear))
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;$l_nivel;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2;=;$l_año)
		$y_blob:=->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
		$l_recNum:=Record number:C243([xxSTR_HistoricoNiveles:191])
		
	: (($t_curso#"") & ($l_año=<>gYear) & ($b_actaEspecificaAlCurso))
		KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->$t_curso)
		$y_blob:=->[Cursos:3]Acta:34
		$l_recNum:=Record number:C243([Cursos:3])
	: (($t_curso#"") & ($l_año<<>gYear))
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=$t_curso;*)
		QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=$l_año)
		$y_blob:=->[Cursos_SintesisAnual:63]Actas_y_Certificados:11
		$l_recNum:=Record number:C243([Cursos_SintesisAnual:63])
End case 



  //**** LECTURA DEL OBJETO ****
  //ACTAS_LeeConfiguracion ($l_nivel;$t_curso;$l_año)
  //ACTAS_LeeObjeto ($y_blob;$l_recNum)

  // elimino las lineas que no corresponden a asignaturas (se agregan nuevamente en ACTAS_Ajustes_y_Orden)
For ($i;Size of array:C274(atActas_Subsectores);1;-1)
	If ((atActas_Subsectores{$i}="Promedio final") | (atActas_Subsectores{$i}="Porcentaje de asistencia") | (atActas_Subsectores{$i}="Situación final") | (atActas_Subsectores{$i}=" "))
		DELETE FROM ARRAY:C228(atActas_Subsectores;$i)
		DELETE FROM ARRAY:C228(alActas_ColumnNumber;$i)
	End if 
End for 


  //**** VERIFICACION DE LA INTEGRIDAD DEL MODELO ****
If ($l_año=<>gYear)
	  // Para el año actual,
	  // verifico si todas las asignaturas están incluidas en el modelo de actas, agrego las faltantes
	If (($t_curso#"") & ([Cursos:3]ActaEspecificaAlCurso:35))
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_curso)
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$l_nivel)
	End if 
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;$at_asignaturasEnActas)
Else 
	If ($t_curso#"")
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7=$t_curso;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=$l_año)
	Else 
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=$l_nivel;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=$l_año)
	End if 
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
	KRL_RelateSelection (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493)
	QUERY SELECTION:C341([Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214)
	DISTINCT VALUES:C339([Asignaturas_Historico:84]Asignatura:2;$at_asignaturasEnActas)
End if 


For ($i_asignatura;1;Size of array:C274($at_asignaturasEnActas))
	$l_idxEnActas:=Find in array:C230(atActas_Subsectores;$at_asignaturasEnActas{$i_asignatura})
	If ($l_idxEnActas=-1)
		APPEND TO ARRAY:C911(atActas_Subsectores;$at_asignaturasEnActas{$i_asignatura})
		APPEND TO ARRAY:C911(alActas_ColumnNumber;0)
	End if 
End for 

  // si hay asignaturas que estaban en el modelo pero no van en actas las elimino del modelo del nivel
For ($i_asignatura;Size of array:C274(atActas_Subsectores);1;-1)
	If (Find in array:C230($at_asignaturasEnActas;atActas_Subsectores{$i_asignatura})<0)
		AT_Delete ($i_asignatura;1;->atActas_Subsectores;->alActas_ColumnNumber)
	End if 
End for 

  // reasigno los numero de columna
For ($i;1;Size of array:C274(alActas_ColumnNumber))
	alActas_ColumnNumber{$i}:=$i
End for 

If (Size of array:C274(alActas_ColumnNumber)>0)
	ACTAS_Ajustes_y_Orden ($l_nivel;$l_año)
	ACTAS_GuardaConfiguracion ($l_nivel;$t_curso;$l_año)
	
	If (($t_curso="") & ($l_año=<>gYear))
		$b_tablaEnLectura:=Read only state:C362([Cursos:3])
		$l_recnumCursoActual:=Record number:C243([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$l_nivel)
		LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNumCursos)
		For ($i;1;Size of array:C274($al_recNumCursos))
			GOTO RECORD:C242([Cursos:3];$al_recNumCursos{$i})
			If ([Cursos:3]ActaEspecificaAlCurso:35)
				ACTAS_ActualizaListaAsignaturas ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
			End if 
			CU_Firmas_ActualizaLista ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
		End for 
		If ($l_recnumCursoActual>No current record:K29:2)
			KRL_ResetPreviousRWMode (->[Cursos:3];$b_tablaEnLectura)
			GOTO RECORD:C242([Cursos:3];$l_recnumCursoActual)
		End if 
	End if 
	
Else 
	  //C_BLOB($xblob)
	  //$xblob:=$y_blob->
	  //$y_tabla:=Table(Table($y_blob))
	  //$b_tablaEnLectura:=Read only state($y_Tabla->)
	  //KRL_GotoRecord ($y_tabla;$l_recNum;True)
	  //SET BLOB SIZE($xblob;0)
	  //$y_blob->:=$xblob
	  //SAVE RECORD($y_tabla->)
	  //KRL_ResetPreviousRWMode ($y_Tabla;$b_tablaEnLectura)
	  // 20170727 ASM Ticket 186164 
	$y_tabla:=Table:C252(Table:C252($y_blob))
	$b_tablaEnLectura:=Read only state:C362($y_Tabla->)
	ACTAS_ConfiguracionPorDefecto ($l_nivel)
	ACTAS_GuardaConfiguracion ($l_nivel;$t_curso)
	KRL_ResetPreviousRWMode ($y_Tabla;$b_tablaEnLectura)
End if 


  //If ((Count parameters=1) & ($l_año=<>gYear))
  //QUERY([Cursos];[Cursos]Nivel_Numero=$l_nivel;*)
  //QUERY([Cursos]; & [Cursos]ActaEspecificaAlCurso=True)
  //SELECTION TO ARRAY([Cursos]Curso;$at_cursos)
  //For ($i;1;Size of array($at_cursos))
  //ACTAS_ActualizaListaAsignaturas ($l_nivel;$at_cursos{$i})
  //End for 
  //End if 
