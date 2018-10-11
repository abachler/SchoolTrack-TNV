//%attributes = {}
  // AS_PaginaPropiedades()
  // Por: Alberto Bachler K.: 21-03-14, 17:21:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_accesoEnEscritura)
C_LONGINT:C283($l_ItemEncontrado;$l_modoPromedioInterno;$l_modoPromedioOficial;$l_recNumAsignaturaActual;$l_recNumHorario;$records)
C_TEXT:C284($t_codImpHorario)
C_DATE:C307($d_inicioSemana;$d_finSemana)
ARRAY TEXT:C222($at_AsignaturasMadres;0)

If (False:C215)
	C_LONGINT:C283(AS_PaginaPropiedades ;$1)
End if 

ARRAY TEXT:C222(at_Profesores_Nombres;0)
ARRAY LONGINT:C221(al_Profesores_ID;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Profesores:4])

RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
If ([Asignaturas:18]Numero:1=0)
	[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
	[Asignaturas:18]Incide_en_promedio:27:=True:C214
	[Asignaturas:18]En_InformesInternos:14:=True:C214
	[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 0
	[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 1
	[Asignaturas:18]IncideEnPromedioInterno:64:=True:C214
	[Asignaturas:18]Incluida_en_Actas:44:=True:C214
	[Asignaturas:18]Incide_en_Asistencia:45:=True:C214
	[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=-5
	[Asignaturas:18]Numero_de_evaluaciones:38:=12
	[Asignaturas:18]En_InformesInternos:14:=True:C214
	AS_PropEval_Inicializa   //para crear el registro de propiedades de evaluación
	
	OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";False:C215)
	OB SET:C1220([Asignaturas:18]Opciones:57;"BloqueoPropDeEval";False:C215)
	OB SET:C1220([Asignaturas:18]Opciones:57;"impHorarioCode";"")
	OB SET:C1220([Asignaturas:18]Opciones:57;"mostrarPTC";False:C215)
	OB SET:C1220([Asignaturas:18]Opciones:57;"NoMostrarEnSTWA";False:C215)
End if 

  // construyo la lista desplegable con la lista de profesores autorizados
If ([Asignaturas:18]Asignatura:3#"")
	If ([Asignaturas:18]Asignatura_No_Oficial:71)
		ALL RECORDS:C47([Profesores:4])
	Else 
		QUERY:C277([Profesores:4];[Profesores]Asignaturas'Asignatura=[Asignaturas:18]Asignatura:3;*)
		QUERY:C277([Profesores:4]; | [Profesores:4]AutorizadoTodaAsignatura:9=True:C214)
	End if 
	QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
	ORDER BY:C49([Profesores:4];[Profesores:4]Apellido_paterno:3;>)
	SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;at_Profesores_Nombres;[Profesores:4]Numero:1;al_Profesores_ID)
	SORT ARRAY:C229(at_Profesores_Nombres;al_Profesores_ID;>)
End if 

  // cargo en arreglos la lista lista de alumnos inscritos en la asignatura y configuro el area ALP
AS_LoadStudentList 
If (Records in selection:C76([Alumnos_Calificaciones:208])#[Asignaturas:18]Numero_de_alumnos:49)  // actualizo el número de alumnos en la asignatura
	[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
End if 

  // construyo la lista desplegable con las opciones para el campos Curso
ARRAY TEXT:C222(aCursos;0)
If (Not:C34(Is new record:C668([Asignaturas:18])))
	If ([Asignaturas:18]Numero_del_Nivel:6#-4)
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[Asignaturas:18]Numero_del_Nivel:6;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)  //ABC
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aCursos)
		INSERT IN ARRAY:C227(aCursos;Size of array:C274(aCursos)+1;2)
		aCursos{Size of array:C274(aCursos)-1}:="-"
		aCursos{Size of array:C274(aCursos)}:=__ ("Selección")
	End if 
End if 

  //  si ya hay alumnos inscritos en la asignatura elimino las opciones para curso
  // (no es posible cambiar el curso si ya hay alumnos inscritos)
If (Size of array:C274(aNtaStdNme)>0)
	ARRAY TEXT:C222(aCursos;0)
End if 

  // determino el valor de la variable sSex en funcion del valor del campo
If ([Asignaturas:18]Seleccion_por_sexo:24>0)
	sSex:=<>aSexSel{[Asignaturas:18]Seleccion_por_sexo:24}
Else 
	[Asignaturas:18]Seleccion_por_sexo:24:=1
	sSex:=<>aSexSel{1}
End if 

  // seleccione en el popup estilo de evaluación el item correspondiente al estilo de la asignatura
$l_ItemEncontrado:=Find in array:C230(aEvStyleId;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
If ($l_ItemEncontrado>0)
	aEvStyleName:=$l_ItemEncontrado
Else 
	aEvStyleName:=0
End if 

  // información condensada de la configuración
If (Not:C34(Is new record:C668([Asignaturas:18])))
	$l_recNumAsignaturaActual:=Record number:C243([Asignaturas:18])
	$b_accesoEnEscritura:=Not:C34(Read only state:C362([Asignaturas:18]))
	AS_AbstractoConfiguracion ([Asignaturas:18]Numero:1)
	KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignaturaActual;$b_accesoEnEscritura)
Else 
	AS_AbstractoConfiguracion ([Asignaturas:18]Numero:1)
End if 

  // oculto o muestro los campos ponderacion para la asignatura si la opción está activada en el nivel
$l_modoPromedioInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47)
OBJECT SET VISIBLE:C603(*;"ponderacionInterno@";($l_modoPromedioInterno=Ponderado por factor))
$l_modoPromedioOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48)
OBJECT SET VISIBLE:C603(*;"ponderacionOficial@";($l_modoPromedioOficial=Ponderado por factor))

  // si hay horarios asignados obtengo el numero de horas semanales y determino si el campo es editable
If (vlSTR_Horario_NoCiclos=1)
	$l_recNumHorario:=Find in field:C653([TMT_Horario:166]ID_Asignatura:5;[Asignaturas:18]Numero:1)
	If (($l_recNumHorario>=0) & (vlSTR_Horario_NoCiclos=1))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
		READ ONLY:C145([TMT_Horario:166])
		  // Modificado por: Saúl Ponce (19/05/2017) Ticket Nº 180337,horas de clases vigentes
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero)
		  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=[Asignaturas]Numero;*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=Current date(*);*)
		  //QUERY([TMT_Horario]; & ;[TMT_Horario]SesionesDesde<=Current date(*))
		  // Modificado por: Saúl Ponce (12/03/2018) valido con el nuevo método creado por Alberto B.
		DT_GetStartEndWeekDates (Current date:C33(*);->$d_inicioSemana;->$d_finSemana)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$d_inicioSemana;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=$d_finSemana)
		[Asignaturas:18]Horas_Semanales:51:=$records
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		OBJECT SET ENTERABLE:C238(*;"horas@";False:C215)
	Else 
		OBJECT SET ENTERABLE:C238(*;"horas@";True:C214)
	End if 
Else 
	OBJECT SET ENTERABLE:C238(*;"horas@";True:C214)
End if 

OBJECT SET VISIBLE:C603([Asignaturas:18]Numero_del_grupo_electivo:29;[Asignaturas:18]Electiva:11)

If ([Asignaturas:18]Seleccion:17)
	OBJECT SET ENTERABLE:C238([Asignaturas:18]Curso:5;True:C214)
	OBJECT SET COLOR:C271([Asignaturas:18]Curso:5;-6)
End if 

If (<>vtXS_CountryCode#"cl")
	OBJECT SET TITLE:C194(*;"enActas";__ ("Asignatura Oficial"))
End if 

Case of 
	: (<>vtXS_CountryCode="pe")
		OBJECT SET TITLE:C194(*;"Optativa";__ ("Taller"))
End case 

Case of 
	: ([Asignaturas:18]Publicar_en_SchoolNet:60=0)
		cb_publicarEnSchoolNet:=0
	: ([Asignaturas:18]Publicar_en_SchoolNet:60=15)
		cb_publicarEnSchoolNet:=1
	Else 
		cb_publicarEnSchoolNet:=2
End case 
FORM GOTO PAGE:C247(vlSTR_PaginaFormAsignaturas)

  // construyo la lista de asignaturas desde la cual se puede copiar la nómina de alumnos
AS_PopupCopiaNomina 