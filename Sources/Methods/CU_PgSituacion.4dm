//%attributes = {}
  // CU_PgSituacion()
  // Por: Alberto Bachler K.: 27-02-14, 18:00:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_promedioEditable)
C_LONGINT:C283($i;$l_filaSeleccionada)
C_POINTER:C301($y_listboxControl;$y_SitFinalAlumno;$y_SitFinalAsistencia;$y_SitFinalComentarios;$y_SitFinalObsActas;$y_SitFinalPromedio;$y_SitFinalRecNum;$y_SitFinalSituacionFinal)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY INTEGER:C220($al_ausenciasInjustificadas;0)
ARRAY INTEGER:C220($al_ausenciasJustificadas;0)
ARRAY INTEGER:C220($al_inasistenciasJornada;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_Estilos;0)
ARRAY REAL:C219($ar_FaltasRetardoJornada;0)
ARRAY REAL:C219($ar_FaltasRetardoSesiones;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$y_SitFinalAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Alumno")
$y_SitFinalPromedio:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Promedio")
$y_SitFinalSituacionFinal:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_SituacionFinal")
$y_SitFinalAsistencia:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Asistencia")
$y_SitFinalComentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Comentarios")
$y_SitFinalObsActas:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_ObsActas")
$y_SitFinalRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_RecNum")
$y_listboxControl:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxControl")


KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]EvStyle_oficial:23)
EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
READ ONLY:C145([Alumnos_SintesisAnual:210])
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos:2]apellidos_y_nombres:40;>)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210];$y_SitFinalRecNum->;[Alumnos:2]apellidos_y_nombres:40;$y_SitFinalAlumno->;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19;$y_SitFinalPromedio->;[Alumnos_SintesisAnual:210]SituacionFinal:8;$y_SitFinalSituacionFinal->;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;$y_SitFinalAsistencia->;[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49;$al_ausenciasJustificadas;[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50;$al_ausenciasInjustificadas;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;$al_inasistenciasJornada;[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45;$ar_FaltasRetardoJornada;[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46;$ar_FaltasRetardoSesiones;[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62;$y_SitFinalComentarios->;[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9;$y_SitFinalObsActas->;[Alumnos_SintesisAnual:210]Inasistencias_Horas:31;$al_horasInasistencia)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)



$b_promedioEditable:=((<>vtXS_CountryCode="uy") & ((USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )) | USR_checkRights ("M";->[Cursos:3])))
Case of 
	: (<>vtXS_CountryCode="cl")
		OBJECT SET FORMAT:C236(*;"SitFinal_Asistencia";"##0,0")
		OBJECT SET TITLE:C194(*;"hdrAsistencia";__ ("Asist."))
		OBJECT SET ENTERABLE:C238(*;"sitFinal_promedio";$b_promedioEditable)
		
	: (<>vtXS_CountryCode="ar")
		OBJECT SET FORMAT:C236(*;"SitFinal_Asistencia";"###0,00")
		OBJECT SET TITLE:C194(*;"hdrAsistencia";__ ("Faltas"))
		For ($i;1;Size of array:C274($y_SitFinalRecNum->))
			$y_SitFinalAsistencia->{$i}:=$al_inasistenciasJornada{$i}+$ar_FaltasRetardoJornada{$i}+$ar_FaltasRetardoSesiones{$i}
		End for 
		
	: (<>vtXS_CountryCode="uy")
		OBJECT SET FORMAT:C236(*;"SitFinal_Asistencia";"###0")
		OBJECT SET TITLE:C194(*;"hdrAsistencia";__ ("Aus."))
		For ($i;1;Size of array:C274($y_SitFinalRecNum->))
			$y_SitFinalAsistencia->{$i}:=Int:C8($al_ausenciasJustificadas{$i}/2)+$al_ausenciasInjustificadas{$i}
		End for 
		
	Else 
		  //LISTBOX SET COLUMN WIDTH(*;"sitFinal_comentarios";LISTBOX Get column width(*;"sitFinal_comentarios")+LISTBOX Get column width(*;"SitFinal_ObsActas"))
		OBJECT SET FORMAT:C236(*;"SitFinal_Asistencia";"##0,0")
		OBJECT SET TITLE:C194(*;"hdrAsistencia";__ ("Asist."))
		
End case 

OBJECT SET ENTERABLE:C238(*;"sitFinal_@";False:C215)
OBJECT SET RGB COLORS:C628(*;"lbSituacionFinal";0;0x00FFFFFF;<>vl_ColorFilasAlternas)
  // las observaciones en actas son visibles y editables solo para Chile
OBJECT SET VISIBLE:C603(*;"SitFinal_ObsActas";<>vtXS_CountryCode="cl")
OBJECT SET ENTERABLE:C238(*;"SitFinal_ObsActas";<>vtXS_CountryCode="cl")
  // los comentarios sobre la situación final son editables en todos los países distintos de Chile
OBJECT SET ENTERABLE:C238(*;"sitFinal_comentarios";<>vtXS_CountryCode#"cl")
If (<>vtXS_CountryCode#"cl")
	LISTBOX SET COLUMN WIDTH:C833(*;"sitFinal_comentarios";LISTBOX Get column width:C834(*;"sitFinal_comentarios")+LISTBOX Get column width:C834(*;"SitFinal_ObsActas"))
End if 

  // obtengo información sobre la estructura del listbox
LISTBOX GET ARRAYS:C832(*;"lbSituacionFinal";$at_nombreColumnas;$at_nombreEncabezados;$ay_Columnas;$ay_Encabezados;$ab_visibles;$ay_Estilos)
OBJECT SET RGB COLORS:C628(*;"rectanguloEntrada";color RGB darkgreen;Background color none:K23:10)

  // reestablezco las propiedades del listbox (necesario al pasar de un curso a otro
If (OB Is defined:C1231($y_ListboxControl->))
	$l_filaSeleccionada:=OB Get:C1224($y_ListboxControl->;"celda_fila")
	LISTBOX SET ROW FONT STYLE:C1268(*;"sitFinal@";$l_filaSeleccionada;Plain:K14:1)
	OBJECT SET VISIBLE:C603(*;"fondoEdicion";False:C215)
	OBJECT SET VISIBLE:C603(*;"rectanguloEntrada";False:C215)
End if 

  // inicializo el objeto que se utiliza para manejar la selección de filas, columnas y celdas del listbox
OB SET ARRAY:C1227($y_ListboxControl->;"columnas";$at_nombreColumnas)
OB SET:C1220($y_ListboxControl->;"celda_fila";0)
OB SET:C1220($y_ListboxControl->;"celda_columna";0)
OB SET:C1220($y_ListboxControl->;"nombreColumnaActual";"")


LISTBOX SELECT ROW:C912(*;"lbSituacionFinal";1)
CU_SituacionFinal_EventosLB 

FORM GOTO PAGE:C247(5)






